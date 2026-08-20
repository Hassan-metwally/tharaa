import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../core.dart';
import '../../di/di.dart';

part 'config.dart';

class PusherHandler {
  PusherHandler._();

  static PusherHandler? _instance;
  static PusherHandler get instance => _instance ??= PusherHandler._();

  // Pusher instance
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
  final GetTokenUseCase _getTokenUseCase = injector<GetTokenUseCase>();

  // Track connection state
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  /// Initialize and connect to Pusher Channels
  ///
  Future<void> initialize() async {
    try {
      _debugPrint("Start initializing Pusher");
      await _pusher.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onAuthorizer: _onAuthorizer,
        onError: _handleError,
        onEvent: (event) {
          _debugPrint("On Global Event Triggered");
        },
      );

      await _pusher.connect();
      _debugPrint("Initializing Pusher Finished Successfully");
      _isConnected = true;
    } catch (e) {
      _debugPrint("Failed To Initializing Pusher\nError: $e");
      _isConnected = false;
    }
  }

  dynamic _onAuthorizer(String channelName, String socketId, dynamic options) async {
    try {
      final token = await _getTokenUseCase();
      if (token == null) {
        _debugPrint("Authorizer error: Token is null");
        return {};
      }

      _debugPrint("Authorizing channel: $channelName");

      final result = await Dio(
        BaseOptions(
          baseUrl: ApiConstants.apiBaseUrl,
          headers: {
            'Authorization': 'Bearer ${token.token}',
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      ).post(_authBroadcastingUrl, data: {'socket_id': socketId, 'channel_name': channelName});

      _debugPrint("Authorizer success: ${result.data}");
      return result.data;
    } catch (e) {
      _debugPrint("Authorizer error: $e");
      if (e is DioException) {
        _debugPrint("Dio error data: ${e.response?.data}");
      }
      return {}; // Returning an empty map prevents the native side from receiving a FlutterError and crashing
    }
  }

  /// Handle errors from Pusher
  void _handleError(String message, int? code, dynamic error) {
    _debugPrint("Pusher initializing error:\n$message");
  }

  /// Subscribe to a channel with event handling
  static Future<PusherChannel?> subscribeToChannel({
    required String channelName,
    required Function(PusherEvent event) onEvent,
    Function(String error)? onSubscriptionError,
    Function(dynamic data)? onSubscriptionSucceeded,
  }) async {
    try {
      _debugPrint("Subscribing to channel: $channelName");
      final bool isAlreadySubscribed = instance._pusher.channels.containsKey(channelName);
      if (isAlreadySubscribed) {
        await unsubscribeFromChannel(channelName);
      }
      final channel = await instance._pusher.subscribe(
        channelName: channelName,
        onSubscriptionError: (error) {
          _debugPrint("Failed subscribing to channel: $channelName\nError: $error");
          onSubscriptionError?.call(error);
        },
        onSubscriptionSucceeded: (data) {
          _debugPrint("Successfully subscribed to channel: $channelName");
          onSubscriptionSucceeded?.call(data);
        },
        onEvent: (event) {
          if (event is PusherEvent) {
            onEvent(event);
          }
        },
      );
      return channel;
    } catch (e) {
      _debugPrint("Failed to subscribe to channel: $channelName\nError: $e");
      return null;
    }
  }

  /// Unsubscribe from a specific channel
  static Future<void> unsubscribeFromChannel(String channelName) async {
    try {
      _debugPrint("Unsubscribing from channel: $channelName");
      await instance._pusher.unsubscribe(channelName: channelName);
      _debugPrint("Un Subscribing successfully from channel: $channelName");
    } catch (e) {
      _debugPrint("Error Un Subscribing from channel: $channelName\nError: $e");
    }
  }

  Future<void> disconnect() async {
    try {
      await _pusher.disconnect();
      _isConnected = false;
      _instance = null;
      _debugPrint("Disconnected Pusher Success");
    } catch (e) {
      _debugPrint("Failed to disconnect from Pusher\nError: $e");
    }
  }
}

void _debugPrint(String message) {
  debugPrint("[PusherHandler] ::: $message :::");
}

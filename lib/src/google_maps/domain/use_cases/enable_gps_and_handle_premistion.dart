import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../../../../core/core.dart';

@LazySingleton()
class EnableGpsAndHandlePermissionUseCase {
  final Location _locationObj = Location.instance;

  EnableGpsAndHandlePermissionUseCase();

  Future<bool> call() async {
    try {
      bool isHasPermission = true;
      bool gpsEnabled = true;
      if (await hasPermission() == false) {
        isHasPermission = await requestPermission();
      }
      if (await isGpsServiceEnabled() == false) {
        gpsEnabled = await requestGpsService();
      }
      // if (await isBackgroundModeEnabled() == false) {
      // await requestBackgroundMode();
      // }

      debugPrint('[EnableGpsAndHandlePermissionUseCase] : isHasPermission : $isHasPermission  :::  gpsEnabled : $gpsEnabled');

      return isHasPermission && gpsEnabled;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isEverythingOk() async {
    try {
      final bool isPremistionOk = await hasPermission();
      final bool isGpsServiceOk = await isGpsServiceEnabled();
      debugPrint("[EnableGpsAndHandlePermissionUseCase] isPremistionOk : $isPremistionOk :::  isGpsServiceOk : $isGpsServiceOk");
      // final bool isBackgroundEnabled = await isBackgroundModeEnabled();
      return isPremistionOk && isGpsServiceOk;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasPermission({PermissionStatus? status, bool showDeniedToast = false}) async {
    try {
      final permission = status ?? (await _locationObj.hasPermission());
      if (permission == PermissionStatus.granted || permission == PermissionStatus.grantedLimited) {
        return true;
      } else if (permission == PermissionStatus.denied || permission == PermissionStatus.deniedForever) {
        if (showDeniedToast) {
          showPremisstionDeniedToast();
        }
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      if (await hasPermission()) {
        return true;
      } else {
        final requestedPremission = await _locationObj.requestPermission();
        final bool isRequestedPremissionTaken = await hasPermission(status: requestedPremission);
        return isRequestedPremissionTaken;
      }
    } catch (e) {
      log("Request Permission Failed", name: "GetCurrentUserLocationUseCase");
      return false;
    }
  }

  Future<bool> isBackgroundModeEnabled() async {
    try {
      return await _locationObj.isBackgroundModeEnabled();
    } catch (e) {
      return false;
    }
  }

  // Future<bool> requestBackgroundMode() async {
  //   try {
  //     if (await isBackgroundModeEnabled()) {
  //       return true;
  //     } else {
  //       return await _locationObj.enableBackgroundMode(enable: true);
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> isGpsServiceEnabled() async {
    try {
      return await _locationObj.serviceEnabled();
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestGpsService() async {
    try {
      if (await isGpsServiceEnabled()) {
        return true;
      } else {
        return await _locationObj.requestService();
      }
    } catch (_) {
      return false;
    }
  }

  bool? _isEverythingOk;
  Timer? _listenChangeGpsStatusTimer;
  void listenChangeGpsStatus(void Function(bool isEnabled) onGpsStatusChange) {
    _listenChangeGpsStatusTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final bool isEnabled = await isEverythingOk();
      if (_isEverythingOk != isEnabled) {
        _isEverythingOk = isEnabled;
        onGpsStatusChange(isEnabled);
      }
    });
  }

  void dispose() {
    try {
      _listenChangeGpsStatusTimer?.cancel();
      _listenChangeGpsStatusTimer = null;
      _locationObj.enableBackgroundMode(enable: false);
    } catch (_) {}
  }

  void showPremisstionDeniedToast() {
    Fluttertoast.showToast(
      msg: appLocalizer.locationPermissionDeniedMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.white,
      textColor: Colors.black,
      fontSize: 14.0,
    );
  }
}

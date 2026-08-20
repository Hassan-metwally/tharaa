import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';

import '../../core/core.dart';

class FullVideoPlayerPage extends StatelessWidget {
  final VideoSourceInput input;

  const FullVideoPlayerPage._({required this.input});

  static const String routeName = '/VideoFullPlayerPage';

  static void navigate(BuildContext context, {required VideoSourceInput input}) async => await Navigator.of(context).push(
    FadeTransitionRoute(
      settings: const RouteSettings(name: routeName),
      duration: Duration(milliseconds: 300),
      child: (context) => FullVideoPlayerPage._(input: input),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: VideoViewWidget(input: input, isCurrent: true, showProgress: true)),
          PositionedDirectional(
            top: 10,
            start: 20,
            child: SafeArea(
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(color: AppColors.black50.withOpacityPercent(90), shape: BoxShape.circle),
                child: BackButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoViewWidget extends StatefulWidget {
  final VideoSourceInput input;
  final Function()? onVideoClicked;
  final bool isCurrent;
  final bool showProgress;

  const VideoViewWidget({
    super.key,
    // ignore: unused_element
    this.onVideoClicked,
    required this.input,
    this.isCurrent = false,
    this.showProgress = false,
  });

  @override
  State<VideoViewWidget> createState() => _VideoViewWidgetState();
}

class _VideoViewWidgetState extends State<VideoViewWidget> {
  late final Future<VideoPlayerController?> _future;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isMuted = false;

  Future<VideoPlayerController?> initializeVideoPlayer() async {
    try {
      _videoController = widget.input.createController();
      await _videoController?.initialize();
      if (_videoController != null) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: true,
          errorBuilder: (context, errorMessage) {
            return _FailToLoadVideoWidget(errorMessage);
          },
          placeholder: Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
          ),
          customControls: _CustomControls(
            videoPlayerController: _videoController!,
            onPlayPause: _playPause,
            isMuted: _isMuted,
            onMuteUnMute: _muteUnMute,
            showProgress: widget.showProgress,
          ),
        );
      }
      return _videoController;
    } catch (e) {
      throw Exception("Failed to load video");
    }
  }

  @override
  void initState() {
    _future = initializeVideoPlayer();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VideoViewWidget oldWidget) {
    if (oldWidget.isCurrent != widget.isCurrent) {
      if (_chewieController?.isPlaying == true) {
        _playPause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoPlayerController?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _videoController != null &&
            snapshot.hasError == false &&
            _chewieController != null) {
          return GestureDetector(
            onTap: widget.onVideoClicked,
            child: AspectRatio(
              aspectRatio: _chewieController?.aspectRatio ?? 16 / 9,
              child: Theme(
                data: ThemeData(progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.secondary)),
                child: Chewie(controller: _chewieController!),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return _FailToLoadVideoWidget(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }
        return Container(color: Colors.black);
      },
    );
  }

  void _playPause() {
    if (_chewieController?.videoPlayerController.value.isPlaying == true) {
      _chewieController?.pause();
    } else {
      _chewieController?.play();
    }
  }

  void _muteUnMute() {
    _isMuted = !_isMuted;
    _chewieController?.setVolume(_isMuted ? 0 : 1);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

class _CustomControls extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onPlayPause;
  final VoidCallback onMuteUnMute;
  final VideoPlayerController videoPlayerController;
  final bool showProgress;

  const _CustomControls({
    required this.isMuted,
    required this.onPlayPause,
    required this.onMuteUnMute,
    required this.videoPlayerController,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: videoPlayerController,
      builder: (context, value, child) {
        if (!value.isInitialized) return const SizedBox.shrink();
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onPlayPause,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacityPercent(40),
                      child: Icon(value.isPlaying ? Iconsax.pause : Iconsax.play, size: 20.0, color: AppColors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: onMuteUnMute,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacityPercent(40),
                        child: Icon(value.volume == 0 ? Iconsax.volume_slash : Iconsax.volume_high, size: 20.0, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (showProgress)
              SliderTheme(
                data: SliderThemeData(
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape: SliderComponentShape.noThumb,
                  trackHeight: 1,
                  minThumbSeparation: 0,
                ),
                child: Slider(
                  value: value.position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    videoPlayerController.seekTo(Duration(milliseconds: value.toInt()));
                  },
                  activeColor: AppColors.secondary,
                  thumbColor: Colors.white,
                  inactiveColor: AppColors.blue100,
                  max: value.duration.inMilliseconds.toDouble(),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FailToLoadVideoWidget extends StatelessWidget {
  const _FailToLoadVideoWidget(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 16),
          const SizedBox(height: 16),
          Text(errorMessage, style: TextStyles.bold14.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}

abstract class VideoSourceInput {
  VideoPlayerController createController();
  bool get useCustomSSL;

  String get path;
}

class NetworkVideoSourceInput implements VideoSourceInput {
  final String url;

  NetworkVideoSourceInput(this.url);

  @override
  VideoPlayerController createController() {
    final fullEncodedUrl = Uri.encodeFull(url);
    final uri1 = Uri.parse(fullEncodedUrl);
    final uri2 = uri1.replace(scheme: 'https');
    if (url.contains("https")) {
      return VideoPlayerController.networkUrl(uri2);
    } else {
      return VideoPlayerController.file(File(url));
    }
  }

  @override
  bool get useCustomSSL => true;

  @override
  String get path => url;
}

class FileVideoSourceInput implements VideoSourceInput {
  final String url;

  FileVideoSourceInput(this.url);

  @override
  VideoPlayerController createController() {
    return VideoPlayerController.file(File.fromUri(Uri.parse(url)));
  }

  @override
  bool get useCustomSSL => false;

  @override
  String get path => url;
}

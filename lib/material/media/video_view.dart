// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import '../app_fail_widget.dart';
// import '../app_loading_widget.dart';
// import 'app_image.dart';
// import 'package:thoad/core/core.dart';

// class VideoWidget extends StatefulWidget {
//   const VideoWidget({
//     super.key,
//     this.controller,
//     required this.path,
//     this.onFinished,
//     this.loop = true,
//     this.autoPlay = true,
//     this.disposeController = true,
//     this.tumbnail,
//     this.canReloadIfFail = true,
//   });

//   final VideoPlayerController? controller;
//   final String path;
//   final String? tumbnail;
//   final VoidCallback? onFinished;
//   final bool loop;
//   final bool autoPlay;
//   final bool disposeController;
//   final bool canReloadIfFail;

//   @override
//   State<VideoWidget> createState() => _VideoWidgetState();
// }

// class _VideoWidgetState extends State<VideoWidget> {
//   late Future<VideoPlayerController?> _future;
//   VideoPlayerController? _controller;

//   Future<VideoPlayerController?> initializeVideoPlayer() async {
//     try {
//       if (_controller?.value.isInitialized == true) {
//         return _controller;
//       }

//       final uri = Uri.parse(widget.path);
//       _controller = widget.controller ?? VideoPlayerController.networkUrl(uri);
//       if (_controller?.value.isInitialized != true) {
//         await _controller?.initialize();
//       }
//       await _controller?.setLooping(widget.loop);
//       if (widget.autoPlay && _controller?.value.isPlaying != true) {
//         await _controller?.play();
//       }
//       if (_controller == null) {
//         throw Exception("Failed to load video");
//       }

//       return _controller;
//     } catch (e) {
//       throw Exception("Failed to load video");
//     }
//   }

//   @override
//   void initState() {
//     _future = initializeVideoPlayer();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<VideoPlayerController?>(
//       initialData: _controller,
//       future: _future,
//       builder: (context, snapshot) {
//         final Widget child;
//         final videoController = snapshot.data ?? _controller;
//         if (snapshot.connectionState == ConnectionState.done &&
//             videoController != null &&
//             snapshot.hasError == false) {
//           child = ValueListenableBuilder(
//             valueListenable: videoController,
//             child: VideoPlayer(videoController),
//             builder: (context, playerValue, child) {
//               final progressValue = (playerValue.position.inMilliseconds /
//                       playerValue.duration.inMilliseconds)
//                   .sign;
//               return AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   clipBehavior: Clip.antiAlias,
//                   children: [
//                     child!,
//                     LinearProgressIndicator(
//                       minHeight: 2,
//                       value: progressValue,
//                       // valueColor:
//                       //     AlwaysStoppedAnimation<Color>(AppColors.secondary),
//                       backgroundColor: Colors.transparent,
//                     ),
//                     if (playerValue.isBuffering)
//                       const PositionedDirectional(
//                           top: 12,
//                           end: 12,
//                           child: AppLoadingWidget(
//                             size: 12,
//                             strokeWidth: 2,
//                             color: AppColors.gray200,
//                           )),
//                   ],
//                 ),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           if (!widget.canReloadIfFail) {
//             child = Icon(
//               Icons.play_arrow_rounded,
//               size: 50,
//               color: Colors.grey.shade400,
//             );
//           } else {
//             child = AppFailWidget(
//               onRetry: () {
//                 setState(() {
//                   _future = initializeVideoPlayer();
//                 });

//                 // initializeVideoPlayer();
//                 // videoController?.initialize();
//               },
//             );
//           }
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           child = _LoadingWidget(
//             tumbnail: widget.tumbnail,
//           );
//         } else {
//           child = const SizedBox();
//         }
//         return Container(
//           // color: AppColors.blue50,
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     if (widget.disposeController) {
//       _controller?.dispose();
//     }
//     super.dispose();
//   }
// }

// class _LoadingWidget extends StatelessWidget {
//   const _LoadingWidget({this.tumbnail});

//   final String? tumbnail;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         if (tumbnail?.isNotEmpty == true)
//           AppImage(
//             path: tumbnail!,
//             fit: BoxFit.cover,
//             height: double.infinity,
//             width: double.infinity,
//           ),
//         BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//           child: Container(
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(
//           height: 25,
//           width: 25,
//           child: CircularProgressIndicator(
//             strokeWidth: 3,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
//           ),
//         ),
//       ],
//     );
//   }
// }

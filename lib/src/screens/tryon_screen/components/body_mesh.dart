import 'dart:ffi';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/collision_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:video_player/video_player.dart';

class CollisionsVideo extends StatefulWidget {
  @override
  _CollisionsVideoState createState() => _CollisionsVideoState();
}

class _CollisionsVideoState extends State<CollisionsVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool videoDone = false;

  @override
  void initState() {
    super.initState();
    videoDone = false;
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset('assets/meshes/video.mp4');
    _controller.initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  void _reinitializeVideoPlayer() async {
    _controller.dispose();
    _controller = VideoPlayerController.asset('assets/meshes/video.mp4');
    await _controller.initialize();
    _controller.setPlaybackSpeed(0.5);
    _controller.setLooping(true);
    _controller.play();
    setState(() {
      videoDone = true;
    }); // trigger a rebuild after reinitialization
  }

  @override
  Widget build(BuildContext context) {
    final size = _controller.value.size;
    
    return Consumer<CollisionsProvider>(
      builder: (context, collisionsProvider, child) {
        if (!collisionsProvider.isGenerating && !videoDone) {
          _reinitializeVideoPlayer();
        }
        return Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Center(
                    child: collisionsProvider.isGenerating
                        ? Container(
                            height: 150,
                            child: Column(
                              children: [
                                Text(
                                  'Generating your outfit\n This may take a few minutes...',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              ],
                            ),
                          )
                        : collisionsProvider.hasOutfit
                            ? videoDone
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        190.0),
                                    child: OverflowBox(
                                      minWidth: 0,
                                      maxWidth: double.infinity,
                                      minHeight: 0,
                                      maxHeight: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: SizedBox(
                                          width: _controller.value.size.width *
                                              0.5,
                                          height:
                                              _controller.value.size.height *
                                                  0.5,
                                          child: VideoPlayer(_controller),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Generating your outfit\n This may take a few minutes...',
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20),
                                        CircularProgressIndicator(
                                          color: AppColors.secondaryColor,
                                        ),
                                      ],
                                    ),
                                  )
                            : Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(
                                      'No outfit chosen yet\n Go back and select an outfit to try on!',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Icon(
                                      Icons.error,
                                      color: AppColors.secondaryColor,
                                      size: 50,
                                    ),
                                  ],
                                ),
                              )),
              ),
            ),
          ],
        );
      },
    );
  }
}
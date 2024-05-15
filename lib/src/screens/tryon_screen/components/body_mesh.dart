import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/collision_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:video_player/video_player.dart';
// import 'package:flutter_cube/flutter_cube.dart';

// class MeshRender extends StatefulWidget {
//   const MeshRender({Key? key}) : super(key: key);

//   @override
//   State<MeshRender> createState() => _MeshRenderState();
// }

// class _MeshRenderState extends State<MeshRender> {
//   // on below line creating an object for earth
//   late Object body;
//   late Object shirt;

//   // on below line initializing state
//   @override
//   void initState() {
//     // on below line initializing earth object
//     body = Object(
//         fileName: "assets/meshes/woman_test.obj",
//         lighting: true,
//         rotation: Vector3(270, -100, -50));

//     shirt = Object(
//         fileName: "assets/meshes/tshirt_test.obj",
//         lighting: true,
//         rotation: Vector3(270, -100, -50));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Cube(
//         onSceneCreated: (Scene scene) {
//           scene.world.add(body);
//           // scene.world.add(shirt);
//           // body.position.setFrom(Vector3(2, 0, 2));
//           scene.camera.position.setFrom(Vector3(0, 0, -11));
//           scene.light.position.setFrom(Vector3(-15, 15, -10));
//           // scene.light.position.setFrom(Vector3(2, 0, 2));
//           //scene.light.diffuse.setFrom(Vector3(2, 0, 2));
//           scene.textureBlendMode = BlendMode.modulate;
//           // on below line setting camera for zoom.
//           scene.camera.zoom = 9.5;
//         },
//       ),
//     );
//   }
// }

class CollisionsVideo extends StatefulWidget {
  @override
  _CollisionsVideoState createState() => _CollisionsVideoState();
}

class _CollisionsVideoState extends State<CollisionsVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset('assets/meshes/video.mp4');
    await _controller.initialize();
    _controller.setPlaybackSpeed(0.5);
    _controller.setLooping(true);
    _controller.play();
    setState(() {}); // trigger a rebuild after initialization
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollisionsProvider>(
      builder: (context, collisionsProvider, child) {
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
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          )
                        : collisionsProvider.hasOutfit
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(
                                      'No outfit chosen yet\n Go back and select an outfit to try on!',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Icon(
                                      Icons.error,
                                      color: AppColors.primaryColor,
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


// class CollisionsVideo extends StatefulWidget {
//   @override
//   _CollisionsVideoStateState createState() => _CollisionsVideoStateState();
// }

// class _CollisionsVideoStateState extends State<CollisionsVideo> {
//   late VideoPlayerController _controller;
//   // CollisionsProvider collisionsProvider =
//   //     Provider.of<CollisionsProvider>(context);

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/meshes/video.mp4')
//       ..initialize().then((_) {
//         print('initialized?');
//         setState(
//             () {}); // Ensure the first frame is shown after the video is initialized
//       })
//       ..setPlaybackSpeed(0.5)
//       ..setLooping(true);
//     print('controller is ${_controller.value.isInitialized} init');
//     bool isGenerating = _fetchCollisionsStatus();
//     print(isGenerating);
//     if (!isGenerating) {
//       _controller.play();
//     } else {
//       setState(() {});
//     }
//   }

//   bool _fetchCollisionsStatus() {
//     CollisionsProvider collisionsProvider =
//         Provider.of<CollisionsProvider>(context, listen: false);

//     return collisionsProvider.isGenerating;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('building');
//     CollisionsProvider collisionsProvider =
//         Provider.of<CollisionsProvider>(context, listen: true);

//     // if (!collisionsProvider.isGenerating) {
//     //   _controller = VideoPlayerController.asset('assets/meshes/video.mp4')
//     //     ..initialize().then((_) {
//     //       setState(
//     //           () {}); // Ensure the first frame is shown after the video is initialized
//     //     })
//     //     ..setPlaybackSpeed(0.5)
//     //     ..setLooping(true)
//     //     ..play();

//     //   setState(() {
//     //     _controller.play();
//     //   });
//     //   print('controller is ${_controller.value.isInitialized}');
//     // }
//     return Column(
//       children: [
//         Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.7,
//             width: MediaQuery.of(context).size.width * 0.95,
//             child: Center(
//               child: _controller.value.isInitialized
//                   // collisionsProvider.isGenerating
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//                   : CircularProgressIndicator(
//                       color: AppColors.primaryColor,
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class MeshRender extends StatefulWidget {
  const MeshRender({Key? key}) : super(key: key);

  @override
  State<MeshRender> createState() => _MeshRenderState();
}

class _MeshRenderState extends State<MeshRender> {
  // on below line creating an object for earth
  late Object earth;

  // on below line initializing state
  @override
  void initState() {
    // on below line initializing earth object
    earth = Object(
        fileName: "assets/meshes/result.obj",
        lighting: true,
        rotation: Vector3(270, -100, -50));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // on below line creating our UI.
    return Expanded(
      // on below line creating a cube
      child: Cube(
        // on below line creating a scene
        onSceneCreated: (Scene scene) {
          // on below line adding a scene as earth
          scene.world.add(earth);
          earth.position.setFrom(Vector3(2, 0, 2));
          scene.camera.position.setFrom(Vector3(0, 0, -11));
          scene.light.position.setFrom(Vector3(-15, 15, -10));
          // scene.light.position.setFrom(Vector3(2, 0, 2));
          //scene.light.diffuse.setFrom(Vector3(2, 0, 2));
          scene.textureBlendMode = BlendMode.modulate;
          // on below line setting camera for zoom.
          scene.camera.zoom = 9.5;
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/mesh_renderer.dart';
import 'package:tayt_app/provider/outfit_provider.dart';

class MeshRender extends StatefulWidget {
  const MeshRender({Key? key}) : super(key: key);

  @override
  State<MeshRender> createState() => _MeshRenderState();
}

class _MeshRenderState extends State<MeshRender> {
  late Object body;

  @override
  void initState() {
    // final AuthProvider authProvider =
    //     Provider.of<AuthProvider>(context, listen: false);
    // Provider.of<MeasurementsProvider>(context, listen: false)
    //     .getBodyMesh(authProvider.getUserId());
    // String path = Provider.of<MeasurementsProvider>(context, listen: false)
    //     .fetchBodyMeshPath(authProvider.getUserId());
    // body = Object(
    //     fileName: 'assets/meshes/body.obj',
    //     lighting: true,
    //     rotation: Vector3(270, -100, -50));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.getUserId();

    final meshProvider = Provider.of<MeasurementsProvider>(context);
    String bodyMeshPath = 'assets/meshes/body.obj';

    print(meshProvider
        .getIsGenerating); //prints false and enters the if block, even though form called startGemerating?
    // for context, this mechanism is to make sure that the mesh is generated before rendering it- the form should set is Generating to be true. as soon as the
    // obj file is written to a file, isGenerating turns to false and the listeners are notified, and the path is fetched
    if (!(meshProvider.getIsGenerating)) {
      print(
          '${meshProvider.isGenerating} generating, now fetching body mesh path');
      bodyMeshPath = meshProvider.fetchBodyMeshPath(userId);
    }

    body = Object(
        fileName: bodyMeshPath,
        lighting: true,
        rotation: Vector3(270, -100, -50));

    return Expanded(
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(body);
          body.position.setFrom(Vector3(2, 0, 2));
          scene.camera.position.setFrom(Vector3(0, 0, -11));
          scene.light.position.setFrom(Vector3(-15, 15, -10));
          // scene.light.position.setFrom(Vector3(2, 0, 2));
          //scene.light.diffuse.setFrom(Vector3(2, 0, 2));
          scene.textureBlendMode = BlendMode.modulate;
          scene.camera.zoom = 9.5;
        },
      ),
    );
  }
}

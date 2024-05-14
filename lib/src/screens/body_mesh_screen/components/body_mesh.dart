import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:provider/provider.dart';
import 'package:tayt_app/provider/authentication_provider.dart';
import 'package:tayt_app/provider/body_provider.dart';
import 'package:tayt_app/src/deps/colors.dart';

class MeshRender extends StatefulWidget {
  const MeshRender({Key? key}) : super(key: key);

  @override
  State<MeshRender> createState() => _MeshRenderState();
}

class _MeshRenderState extends State<MeshRender> {
  late Object body;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Trigger the API call only when the widget is first initialized
    _fetchBodyMeshData();
  }

  Future<void> _fetchBodyMeshData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.getUserId();

    final meshProvider = Provider.of<BodyProvider>(context, listen: false);
    final bodyMeshData = await meshProvider.getBodyMesh(userId);

    // Parse bodyMeshData into vertices and faces
    final List<String> lines = bodyMeshData.split('\n');
    final List<Vector3> vertices = [];
    final List<int> indices = [];

    for (final line in lines) {
      final parts = line.trim().split(' ');
      if (parts[0] == 'v') {
        final x = double.parse(parts[1]);
        final y = double.parse(parts[2]);
        final z = double.parse(parts[3]);
        vertices.add(Vector3(x, y, z));
      } else if (parts[0] == 'f') {
        for (var i = 1; i < parts.length; i++) {
          final index = int.parse(parts[i].split('/')[0]) - 1;
          indices.add(index);
        }
      }
    }

    final polygons = <Polygon>[];
    for (var i = 0; i < indices.length; i += 3) {
      final a = indices[i];
      final b = indices[i + 1];
      final c = indices[i + 2];
      polygons.add(Polygon(a, b, c));
    }

    final mesh = Mesh(
      vertices: vertices,
      indices: polygons,
    );

    setState(() {
      // Initialize the Object using the Mesh
      body = Object(
        mesh: mesh,
        lighting: true,
        rotation: Vector3(270, -100, -50),
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
              color: AppColors
                  .primaryColor)); // Show a loading indicator while fetching data
    } else {
      // Once data is loaded, render the Cube
      return _buildCube();
    }
  }

  Widget _buildCube() {
    // Return the Cube widget with the initialized body object
    return Cube(
      onSceneCreated: (Scene scene) {
        scene.world.add(body);
        scene.camera.position.setFrom(Vector3(0, 0, -11));
        scene.light.position.setFrom(Vector3(-15, 15, -10));
        scene.textureBlendMode = BlendMode.modulate;
        scene.camera.zoom = 5.5;
      },
    );
  }
}

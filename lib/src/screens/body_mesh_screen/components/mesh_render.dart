import 'package:flutter/material.dart';

class MeshRender extends StatefulWidget {
  const MeshRender({Key? key}) : super(key: key);

  @override
  State<MeshRender> createState() => _MeshRenderState();
}

class _MeshRenderState extends State<MeshRender> {
  _MeshRenderState({Key? key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Mesh Render',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.black,
                fontSize: 19,
                fontFamily: 'Poppins',
              ),
        ),
      ),
    );
  }
}

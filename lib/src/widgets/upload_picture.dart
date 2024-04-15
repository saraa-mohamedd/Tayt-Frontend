// upload_picture_widget.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tayt_app/src/deps/colors.dart';

class UploadPictureWidget extends StatefulWidget {
  final Function(File)? onImageSelected;

  const UploadPictureWidget({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _UploadPictureWidgetState createState() => _UploadPictureWidgetState();
}

class _UploadPictureWidgetState extends State<UploadPictureWidget> {
   File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              final image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                final File file = File(image.path);
                setState(() {
                  _selectedImage = file;
                });
                if (widget.onImageSelected != null) {
                  widget.onImageSelected!(file);
                }
              }
            },
            icon: Icon(Icons.camera, color: Colors.white),
            label: Text(
              'Upload Picture',
              style: TextStyle(color: Colors.white), // Text color
            ),
            style: ElevatedButton.styleFrom(
              //make backgournd color Appcolors.primayColor
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        ),
        if (_selectedImage != null)
          Container(
            width: 100, // Specify the desired width
            height: 100, // Specify the desired height
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover, // Adjusts the image to cover the entire container
            ),
          ),
      ],
    );
  }
}


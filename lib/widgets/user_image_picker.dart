import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFunction;

  const UserImagePicker(this.imagePickFunction, {super.key});

  @override
  State<StatefulWidget> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future<File?> _imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(() {
      final imageTemp = File(pickedImageFile!.path);
      _pickedImage = imageTemp;
    });
    widget.imagePickFunction(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
          _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColorDark,
          ),
          onPressed: _imagePicker,
          label: const Text('Add Image'),
          icon: const Icon(Icons.image),
        ),
      ],
    );
  }
}

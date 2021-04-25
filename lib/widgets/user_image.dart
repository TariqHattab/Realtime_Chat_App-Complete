import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    Key key,
  }) : super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _pickedImage;
  _pickImage() async {
    var picker = ImagePicker();
    var _pickedImageFile = await picker.getImage(source: ImageSource.camera);
    if (_pickedImageFile != null) {
      setState(() {
        _pickedImage = File(_pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Add image'),
            onPressed: _pickImage),
      ],
    );
  }
}

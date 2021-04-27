import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  final void Function(File image) choosenImagefn;
  const UserImage({Key key, this.choosenImagefn}) : super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _pickedImage;
  _pickImage() async {
    var picker = ImagePicker();
    var _pickedImageFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (_pickedImageFile != null) {
      setState(() {
        _pickedImage = File(_pickedImageFile.path);
      });
      widget.choosenImagefn(_pickedImage);
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
            label: Text('Add a image'),
            onPressed: _pickImage),
      ],
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickerWidget extends StatefulWidget {
  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  File? _pickedImage;

  Future _getImageFromCamera() async {
    try {
      final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImageFile != null) {
        _cropImage(pickedImageFile.path);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future _cropImage(filepath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filepath,
      maxWidth: 800,
      maxHeight: 500,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 0.625),
    );
    if (croppedImage != null) {
      _pickedImage = croppedImage;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _pickedImage != null ? Image.file(_pickedImage!) : SizedBox(height: 240),
        ),
        TextButton.icon(
          onPressed: _getImageFromCamera,
          icon: Icon(Icons.camera),
          label: Text('Add image'),
        ),
        ElevatedButton(
          onPressed: () async {
            final imageId = DateTime.now().toString();
            final ref = FirebaseStorage.instance.ref().child('ship_post').child(imageId);
            if (_pickedImage != null) {
              await ref.putFile(_pickedImage!);
            }
          },
          child: Text('保存する'),
        ),
        ElevatedButton(
          onPressed: () async {
            print('hello');
            await FirebaseFirestore.instance.collection('books').get().then((snapshot) {
              snapshot.docs.map((e) => print(e));
            });
          },
          child: Text('保存する'),
        ),
      ],
    );
  }
}

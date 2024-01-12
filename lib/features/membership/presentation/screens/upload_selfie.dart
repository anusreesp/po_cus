import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../networking/http_client.dart';

class UploadSelfie extends StatefulWidget {
  const UploadSelfie({super.key});

  @override
  State<UploadSelfie> createState() => _UploadSelfieState();
}

class _UploadSelfieState extends State<UploadSelfie> {
  XFile? _capturedImage;
  String? _selfieUrl;
  bool uploadingImage = false;

  Future<void> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });

    try {
      _selfieUrl = await NetworkClient().uploadFile(_capturedImage!.path);
      setState(() {
        _capturedImage = null;
        uploadingImage = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        uploadingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/idverification/presentation/pages/selfie/selfie_capture.dart';
import 'package:htp_customer/features/membership/controller/membership_form_controller.dart';
import 'package:htp_customer/features/membership/controller/membership_form_index.dart';

import '../../../../common/widgets_common/outlined_black_button.dart';
import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../htp_theme.dart';
import '../../../../networking/http_client.dart';

class Selfie extends StatefulWidget {
  const Selfie({super.key});

  @override
  State<Selfie> createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
  // List<CameraDescription>? cameras;
  // CameraController? controller;

  XFile? _capturedImage;

  bool _showCaptureScreen = true;
  String? selfieUrl;

  bool uploadingImage = false;

  Future<void> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });

    try {
      if (_capturedImage != null) {
        // await Future.delayed(const Duration(seconds: 1));
        selfieUrl = await NetworkClient().uploadFile(_capturedImage!.path);
        // setState(() {
        _capturedImage = null;
        uploadingImage = false;
        // });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        uploadingImage = false;
      });
    }
  }

  // loadCamera() async {
  //   cameras = await availableCameras();
  //   if (cameras != null) {
  //     controller = CameraController(cameras![1], ResolutionPreset.high,
  //         enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
  //     //cameras[0] = first camera, change to 1 to another camera
  //
  //     controller!.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       } else {
  //         setState(() {});
  //       }
  //     });
  //   } else {
  //     debugPrint("No any camera found");
  //   }
  // }

  // Future<XFile?> takePicture() async {
  //   // final CameraController? cameraController = controller;
  //   if (controller!.value.isTakingPicture) {
  //     debugPrint('A capture is already pending, do nothing.');
  //     // A capture is already pending, do nothing.
  //     return null;
  //   }
  //   try {
  //     XFile file = await controller!.takePicture();
  //     debugPrint("FILE: $file");
  //     return file;
  //   } on CameraException catch (e) {
  //     debugPrint('Error occurred while taking picture: $e');
  //     return null;
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // loadCamera();
  }

  @override
  void dispose() {
    super.dispose();
    // controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      ref.listen(membershipFormDataProvider, (previous, next) {
        if (next is MembershipSuccessState) {
          ref.read(membershipFormIndexProvider.notifier).state =
              MembershipTab.membership;
        }
        if (next is MembershipErrorState) {
          setState(() {
            uploadingImage = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.msg)));
        }
      });
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _showCaptureScreen && _capturedImage != null
            ? Column(
                children: [
                  const Row(
                    children: [],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0, bottom: 32),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.73,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.file(
                          File(_capturedImage!.path),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // child: _capturedImage != null
                      //     ? Image.file(
                      //         File(_capturedImage!.path),
                      //         fit: BoxFit.cover,
                      //       )
                      //     : controller != null
                      //         ? CameraPreview(controller!)
                      //         : null,
                    ),
                  ),
                  if (_capturedImage == null)
                    const Column(
                      children: [
                        Text(
                          'Take a selfie',
                          style: tenor22White,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(55, 8, 55, 0),
                          child: Text(
                            'Hold your phone at eye level. Use a well-lit area',
                            style: man14LightGrey,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  if (!uploadingImage)
                    _capturedImage != null
                        ? OutlinedBlackButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelfieCapture(onCapture: (image) {
                                            _capturedImage = image;
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          })));
                              // _capturedImage = null;
                              // setState(() {});
                            },
                            text: 'Retake',
                          )
                        : OutlinedBlackButton(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelfieCapture(onCapture: (image) {
                                            _capturedImage = image;
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          })));
                              // _capturedImage = await takePicture();
                              // setState(() {});
                            },
                            text: 'Capture',
                          ),
                  if (_capturedImage != null && !uploadingImage)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RoundedGoldenButton(
                        onTap: () {
                          uploadImage().then((value) {
                            if (selfieUrl != null) {
                              ref
                                  .read(membershipFormDataProvider.notifier)
                                  .submitFormData(selfieUrl!);
                            }
                          });
                        },
                        text: 'Continue',
                        textStyle: man16BlackW5,
                      ),
                    ),
                  if (uploadingImage)
                    const CircularProgressIndicator(
                        color: HtpTheme.goldenColor),
                  const SizedBox(
                    height: 22,
                  )
                ],
              )
            : _placeholderDesign(),

        ///Display placeholder on opening
      );
    });
  }

  Widget _placeholderDesign() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 18,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: HtpTheme.goldenColor,
              size: 18,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              'Govt. ID captured!',
              style: man14LightGrey,
            )
          ],
        ),
        const Spacer(),
        SvgPicture.asset('assets/svg/icons/membership/photoyourself.svg'),
        const SizedBox(
          height: 54,
        ),
        const Text(
          'Next, take a photo of yourself',
          style: tenor22White,
        ),
        const SizedBox(
          height: 6,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.0),
          child: Text(
            'We’ll verify this with the photograph in your Govt. Id',
            style: man14LightGrey,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        // Consumer(
        //   builder: (context, ref, child) => OutlinedBlackButton(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           // SvgPicture.asset('assets/svg/icons/membership/upload.svg'),
        //           // const SizedBox(
        //           //   width: 16,
        //           // ),
        //           const Text(
        //             'Upload photo',
        //             style: man16White,
        //           )
        //         ],
        //       ),
        //       onTap: () {
        //         ref.read(idVerificationScreen.notifier).state =
        //             VerificationScreen.selfieUpload;
        //       }),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        RoundedGoldenButton(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelfieCapture(onCapture: (image) {
                          _capturedImage = image;
                          setState(() {});
                          Navigator.of(context).pop();
                        })));
            // setState(() {
            //   _showCaptureScreen = true;
            // });
          },
          text: 'Take a selfie',
          textStyle: man16BlackW5,
        ),
        const SizedBox(
          height: 22,
        )
      ],
    );
  }
}

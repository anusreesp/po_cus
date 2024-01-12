import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/networking/http_client.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets_common/outlined_black_button.dart';
import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../common/widgets_common/text_field_electra.dart';
import '../../../../htp_theme.dart';
import '../../../idverification/presentation/pages/docs/img_capture.dart';
import '../../controller/id_verification_screen_control.dart';
import '../../controller/membership_form_controller.dart';

class UploadId extends StatefulWidget {
  const UploadId({super.key});

  @override
  State<UploadId> createState() => _UploadIdState();
}

class _UploadIdState extends State<UploadId> {
  XFile? _capturedImage;

  String? _frontIdUrl;
  String? _backIdUrl;

  bool uploadImageSelection = true; ///This value is used for changing image fit property to display complete uploaded image
  bool uploadingImage = false;

  /// If front id uploaded means the url is received
  bool get frontIdUploaded => _frontIdUrl != null;

  bool get captureState => _capturedImage == null;

  //both id and url is null --- initial state

  Future<void> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });

    try {
      if (!frontIdUploaded) {
        // await Future.delayed(const Duration(seconds: 1));
        _frontIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
        setState(() {
          _capturedImage = null;
          uploadingImage = false;
        });
      } else {
        _backIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
        setState(() {
          _capturedImage = null;
          uploadingImage = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        uploadingImage = false;
      });
    }
  }

  captureId() async {
    _capturedImage = await takePicture();
    uploadImageSelection = true;
    setState(() {});
  }

  // captureIdFromCamera()async{
  //   _capturedImage = await takePictureFromCamera();
  //   setState(() {});
  // }

  Future<XFile?> takePicture() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      debugPrint("FILE: $file");
      return file;
    } catch (_) {
      rethrow;
    }
  }

  // Future<XFile?> takePictureFromCamera() async {
  //   try {
  //     XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  //     debugPrint("FILE: $file");
  //     return file;
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  final frontIdPlaceholder = 'assets/svg/icons/membership/uploadfront_image.svg';
  final backIdPlaceholder = 'assets/svg/icons/membership/upload_back.svg';

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Column(
        children: [
          // const SizedBox(
          //   height: 18,
          // ),

          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 32, bottom: 16),
            child: Text(
              'Upload a photo of your Government ID',
              style: tenor22White,
            ),
          ),

          Container(
            width: double.infinity,
            height: 240,
            color: _capturedImage != null ? HtpTheme.lightBlueColor : null,
            child: _capturedImage != null
                ? Image.file(
                    File(_capturedImage!.path),
                    fit: uploadImageSelection ? BoxFit.contain : BoxFit.cover,
                  )
                : Center(
                    child: SvgPicture.asset(
                    frontIdUploaded ? backIdPlaceholder : frontIdPlaceholder,
                    height: 80,
                  )),
          ),

          const SizedBox(
            height: 16,
          ),

          Text(
            frontIdUploaded ? 'Back Side' : 'Front Side',
            style: tenor22White,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Upload or capture the ${frontIdUploaded ? 'back' : 'front'} side of your valid ID.',
            style: man14LightGrey,
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          !uploadingImage
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16),
                      //   child: OutlinedBlackButton(
                      //       // text: captureState ? 'Upload' : 'Re-upload',
                      //       text: 'Choose from library',
                      //       onTap: () {
                      //         captureId();
                      //       }),
                      // ),

                      if(!captureState)
                      OutlinedBlackButton(onTap: (){
                        _capturedImage = null;
                        setState(() {});

                      }, text: 'Retake',),

                      // ---------------- Two buttons ---- new section
                      if(captureState)
                      OutlinedBlackButton(
                          onTap: captureId,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/icons/membership/upload.svg'),
                              const SizedBox(
                                width: 16,
                              ),
                              const Text(
                                'Upload photo',
                                style: man16White,
                              )
                            ],
                          ),),

                      const DividerElectra(),

                      if(captureState)
                      OutlinedBlackButton(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageCapture())).then((image) {
                              if(image != null){
                                _capturedImage = image;
                                uploadImageSelection = false;
                                setState(() {});
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/svg/icons/membership/capturephoto.svg'),
                              const SizedBox(
                                width: 16,
                              ),
                              const Text(
                                'Capture photo',
                                style: man16White,
                              )
                            ],
                          ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // --------------------------------


                      if (captureState &&
                          _capturedImage == null &&
                          frontIdUploaded)
                        Column(
                          children: [
                            // const DividerElectra(),
                            TextButton(
                                onPressed: () {
                                  if (_frontIdUrl != null) {
                                    ref
                                        .read(idVerificationScreen.notifier)
                                        .state = VerificationScreen.selfie;
                                    ref
                                        .read(membershipFormDataProvider.notifier)
                                        .addGovtId(_frontIdUrl!, _backIdUrl);
                                  }
                                },
                                child: const Text(
                                  'Skip if not applicable',
                                  style: TextStyle(
                                      fontFamily: manrope,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      color: HtpTheme.goldenColor,
                                      decorationThickness: 2),
                                ))
                          ],
                        ),
                      if (_capturedImage != null)
                        RoundedGoldenButton(
                          onTap: () {
                            uploadImage().then((_) {
                              if (_frontIdUrl != null && _backIdUrl != null) {
                                ref.read(idVerificationScreen.notifier).state =
                                    VerificationScreen.selfie;
                                ref
                                    .read(membershipFormDataProvider.notifier)
                                    .addGovtId(_frontIdUrl!, _backIdUrl);
                              }
                            });
                          },
                          text: 'Confirm',
                          textStyle: man16BlackW5,
                        ),
                    ],
                  ),
              )
              : const CircularProgressIndicator(color: HtpTheme.goldenColor),

          const SizedBox(
            height: 22,
          )
          // DividerElectra(),
        ],
      );
    });
  }
}

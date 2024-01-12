import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import '../../../../../../common/widgets_common/outlined_black_button.dart';
import '../../../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../../../htp_theme.dart';
import '../../../../../../networking/http_client.dart';
import '../../../../../membership/presentation/screens/confirmation_display_page.dart';
import '../../../../controllers/billupload_controller.dart';

class BillCapture extends StatefulWidget {
  final String id;
  final String bookingType;
  const BillCapture({required this.id, required this.bookingType, super.key});

  @override
  State<BillCapture> createState() => _BillCaptureState();
}

class _BillCaptureState extends State<BillCapture> {
  List<CameraDescription>? cameras;
  CameraController? controller;

  XFile? _capturedImage;

  bool _showCaptureScreen = false;
  String? billUrl;
  File? billFile;

  // MultipartFile? fileData;

  bool uploadingImage = false;

  Future<void> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });

    try {
      if (_capturedImage != null) {
        // await Future.delayed(const Duration(seconds: 1));
        // billUrl = await NetworkClient().uploadInvoiceFile(_capturedImage!.path);

        // fileData = await FormData.fromMap({
        //   'images': [await MultipartFile.fromFile(_capturedImage!.path)]
        // });

        // fileData =
        //     await MultipartFile.fromFile(File(_capturedImage!.path).path);

        billFile = File(_capturedImage!.path);
        setState(() {
          _capturedImage = null;
          uploadingImage = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() {
          uploadingImage = false;
        });
      }
    }
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.high,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        } else {
          setState(() {});
        }
      });
    } else {
      debugPrint("No any camera found");
    }
  }

  Future<XFile?> takePicture() async {
    // final CameraController? cameraController = controller;
    if (controller!.value.isTakingPicture) {
      debugPrint('A capture is already pending, do nothing.');
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      await controller!.setFocusMode(FocusMode.locked);
      await controller!.setExposureMode(ExposureMode.locked);
      XFile file = await controller!.takePicture();
      debugPrint("FILE: $file");
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking picture: $e');
      return null;
    } catch (_) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(
          'UPLOAD INVOICE',
          style: man14White,
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        ref.listen(billUploadProvider, (previous, next) {
          if (next is BillUploadSuccessState) {}
          if (next is BillUploadErrorState) {
            setState(() {
              uploadingImage = false;
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(next.msg)));
          }
        });

        return Column(
          children: [
            const Row(
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 42.0, bottom: 32),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                width: MediaQuery.of(context).size.width,
                child: _capturedImage != null
                    ? Image.file(
                        File(_capturedImage!.path),
                        fit: BoxFit.fill,
                      )
                    : controller != null
                        ? CameraPreview(controller!)
                        : null,
              ),
            ),
            // if (_capturedImage == null)
            //   const Column(
            //     children: [
            //       Text(
            //         'Take a selfie',
            //         style: tenor22White,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(55, 8, 55, 0),
            //         child: Text(
            //           'Hold your phone at eye level. Use a well-lit area',
            //           style: man14LightGrey,
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            const Spacer(),
            if (!uploadingImage)
              _capturedImage != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: OutlinedBlackButton(
                        onTap: () {
                          _capturedImage = null;
                          setState(() {});
                        },
                        text: 'Retake',
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: OutlinedBlackButton(
                        onTap: () async {
                          _capturedImage = await takePicture();
                          setState(() {});
                        },
                        text: 'Capture',
                      ),
                    ),
            if (_capturedImage != null && !uploadingImage)
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 12,
                  right: 12,
                ),
                child: RoundedGoldenButton(
                  onTap: () {
                    uploadImage().then((value) {
                      // debugPrint("~~~~~~~~~~~~~~~~~~~~~~$billUrl");
                      // // if (billUrl != null) {
                      // if (billFile != null) {
                      //   // ref
                      //   //     .read(billUploadProvider.notifier)
                      //   //     .submitBill(billUrl!);

                      //   uploadBillVoice(billFile!, ref);
                      // }

                      debugPrint("~~~~~~~~~~~~~~~~~~~~~~${billFile}");
                      if (billFile != null) {
                        // ref.read(billUploadProvider.notifier).submitBill(
                        //     fileData!, widget.id, widget.bookingType);

                        upload(
                          billFile!,
                          widget.id,
                          widget.bookingType,
                          ref,
                        );
                      }
                    });

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmationDisplayPage(
                                  appBarTitle: 'UPLOAD INVOICE',
                                  title: 'Bill sent!',
                                  description:
                                      'Your bill has been sent. We will review the bill and add loyalty points to your account',
                                  justPop: false,
                                  inVoice: true,
                                  emailVerify: false,
                                  onTap: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             EntryConfirmation(
                                    //                 id: widget.id,
                                    //                 bookingType:
                                    //                     widget.bookingType),

                                    //                     ));

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                )));
                  },
                  text: 'Continue',
                  textStyle: man16BlackW5,
                ),
              ),
            if (uploadingImage) const CircularProgressIndicator(color: HtpTheme.goldenColor),
            const SizedBox(
              height: 22,
            )
          ],
        );
      }),
    );
  }

  // uploadBillVoice(File data, WidgetRef ref) async {
  //   final _client = ref.watch(clientProvider);
  //   print("datat--->$data");
  //   try {
  //     final response =
  //         await _client.postRequest('/uploads/v1/uploadInvoice', data.uri);

  //     final result = response.data;
  //     print("##################################${response}");
  //   } catch (e) {
  //     debugPrint("??????????????????????????????????????${e.toString()}");
  //     rethrow;
  //   }
  // }

  upload(
    File file,
    String id,
    String type,
    WidgetRef ref,
  ) async {
    final _client = ref.read(clientProvider);

    final data = FormData.fromMap({
      'invoice': await MultipartFile.fromFile(file.path),
      'id': id,
      'booking_type': type,
    });

    try {
      final response =
          await _client.postRequest('/booking/v2/uploadInvoice', data);

      final result = response.data;
      print("##################################${response}");
    } catch (e) {
      debugPrint("??????????????????????????????????????${e.toString()}");
      rethrow;
    }
  }
}

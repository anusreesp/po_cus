import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:htp_customer/common/widgets_common/camera_access_denied_placeholder.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
import 'package:htp_customer/htp_theme.dart';
// import 'package:image_picker/image_picker.dart';

class SelfieCapture extends StatefulWidget {
  final Function(XFile file) onCapture;
  const SelfieCapture({super.key, required this.onCapture});

  @override
  State<SelfieCapture> createState() => _SelfieCaptureState();
}

class _SelfieCaptureState extends State<SelfieCapture> {
  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showProfile: false,
      ),
      body: buildBody(context),
    );
  }

  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //   }
  // }
  //
  // cameraPicker() async {
  //   var pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedImg != null) {
  //     File imgFile = File(pickedImg.path);
  //   }
  // }

  List<CameraDescription>? cameras;
  CameraController? controller;
  bool cameraAccessDenied = false;

  loadCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null) {
        controller = CameraController(cameras![1], ResolutionPreset.high,
            enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
        //cameras[0] = first camera, change to 1 to another camera

        await controller!.initialize();
        if (mounted) {
          setState(() {});
        }
      } else {
        debugPrint("No any camera found");
      }
    } catch (e) {
      if (e is CameraException &&
          (e.code == 'CameraAccessDenied' ||
              e.code == 'CameraAccessRestricted')) {
        setState(() {
          cameraAccessDenied = true;
        });
      }
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

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (cameraAccessDenied) {
      return const CameraAccessDeniedPlaceholder();
    }

    return SingleChildScrollView(
      child: Center(
        child: Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
            child: Column(
              children: [
                //------------------------------------------capturing part----------------------------
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HtpTheme.lightBlueColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: SizedBox(
                        height: size.height * 0.5,
                        child: controller == null ||
                                !controller!.value.isInitialized
                            ? const Center(
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: const CircularProgressIndicator(color: HtpTheme.goldenColor),),
                              )
                            : CameraPreview(
                                controller!,
                                child: Center(
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            size.height * 0.55),
                                        border: Border.all(
                                            color: HtpTheme.goldenColor,
                                            width: 2)),
                                  ),
                                ),
                              ),
                      ),
                      // child: Stack(
                      //   alignment: AlignmentDirectional.center,
                      //   children: [
                      //     //--------------------------------------------
                      //     // ClipOval(
                      //     //   child: Container(
                      //     //     height: 285,
                      //     //     width: 225,
                      //     //     color: HtpTheme.goldenColor,
                      //     //   ),
                      //     // ),
                      //
                      //
                      //     // Container(
                      //     //   // width: MediaQuery.of(context).size.width * 0.8,
                      //     //   height: MediaQuery.of(context).size.width * 0.8,
                      //     //   child: controller == null || !controller!.value.isInitialized
                      //     //       ? const CircularProgressIndicator()
                      //     //       : CameraPreview(controller!),
                      //     // ),
                      //
                      //     Container(
                      //       height: MediaQuery.of(context).size.height * 0.6,
                      //       child: controller == null || !controller!.value.isInitialized
                      //               ? const CircularProgressIndicator()
                      //               : CameraPreview(controller!),
                      //     ),
                      //
                      //   ],
                      // ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                // const Text(
                //   "Take a selfie",
                //   style: TextStyle(
                //       fontFamily: "Montserrat",
                //       fontSize: 20,
                //       color: HtpTheme.goldenColor,
                //       fontWeight: FontWeight.w600),
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Text(
                //     "Hold your phone at eye level so that your selfie is similar to your ID. Use a well-lit area",
                //     style:
                //         HtpTheme.newTitleTextStyle.apply(fontSizeFactor: 0.70),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // const SizedBox(
                //   height: 12,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OutlinedBlackButton(
                      height: 50,
                      onTap: () async {
                        try {
                          final capture = await takePicture();
                          if (capture == null) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Image capture failed')));
                            }
                          } else {
                            widget.onCapture(capture);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                        // await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SubmitPicture()));
                      },
                      text: "CAPTURE",
                      textStyle:
                          HtpTheme.detailTitleText.apply(fontWeightDelta: 1)),
                )
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}

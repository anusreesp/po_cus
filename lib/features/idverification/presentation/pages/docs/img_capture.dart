import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/camera_access_denied_placeholder.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/htp_theme.dart';

class ImageCapture extends StatefulWidget {
  final String scanTitle;
  const ImageCapture({super.key, this.scanTitle = "Scan front of ID"});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool cameraAccessDenied = false;

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
        ),
        // appBar: const VerifyAppBar(
        //   hideBackButton: false,
        //   leftSpace: 2,
        // ),
        body: cameraAccessDenied
            ? const CameraAccessDeniedPlaceholder()
            : buildBody(context),
      ),
    );
  }

//-----------------------------------------------------------------------------camera---------------------------------
//   onNewCameraSelected(CameraDescription description) async {
//     final previousCameraController = controller;
//     final CameraController cameraController =
//         CameraController(description, ResolutionPreset.high);
//
//     await previousCameraController?.dispose();
//   }

  loadCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null) {
        controller = CameraController(
            kDebugMode ? cameras![1] : cameras![0], ResolutionPreset.high,
            enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
        //cameras[0] = first camera, change to 1 to another camera

        await controller!.initialize();
        if (mounted) {
          setState(() {});
        }
      } else {
        debugPrint("NO any camera found");
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
    }
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            //------------------------------------------capturing part--------------------------------------
            // const SizedBox(height: 22,),
            const Spacer(),
            Container(
              width: double.infinity,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: HtpTheme.lightBlueColor),
              // margin: const EdgeInsets.only(top: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: controller == null || !controller!.value.isInitialized
                      ? const CircularProgressIndicator(color: HtpTheme.goldenColor)
                      : CameraPreview(
                          controller!,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/images/verification/others/corner_icon.svg",
                              width: size.width * 0.8,
                              fit: BoxFit.fitWidth,
                              // height: 250,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const Spacer(),
            // const SizedBox(
            //   height: 54,
            // ),
            // Text(
            //   widget.scanTitle,
            //   style: const TextStyle(
            //       fontFamily: "Montserrat",
            //       fontSize: 20,
            //       color: HtpTheme.goldenColor,
            //       fontWeight: FontWeight.w600),
            // ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 46.0),
              child: Text(
                "To get started, place your ID in the frame. Make sure to use a well-lit area and a plain dark background.",
                style: man14LightGrey,
                textAlign: TextAlign.center,
              ),
            ),
            // const SizedBox(
            //   height: 54,
            // ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 24),
              child: OutlinedBlackButton(
                  // height: 40,
                  onTap: () async {
                    XFile? rawImage = await takePicture();
                    if (rawImage != null && mounted) {
                      Navigator.pop(context, rawImage);
                    }
                    // Navigator.pop(context, File('File'));
                    // print("RAW IMAGE: $rawImage");
                    // File imageFile = File(rawImage!.path);
                    // print(imageFile.path);

                    // int currentUnix = DateTime.now().millisecondsSinceEpoch;
                    // final directory = await getApplicationDocumentsDirectory();
                    // String fileFormat = imageFile.path.split('.').last;

                    // await imageFile.copy(
                    //   '${directory.path}/$currentUnix.$fileFormat',
                    // );
                    // print("$currentUnix");
                  },
                  text: "CAPTURE",
                  textStyle:
                      HtpTheme.detailTitleText.apply(fontWeightDelta: 1)),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}

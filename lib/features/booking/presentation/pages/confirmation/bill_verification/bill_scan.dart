// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:htp_customer/common/widgets_common/goldborder_button.dart';
// import 'package:htp_customer/features/booking/presentation/pages/confirmation/bill_verification/bill_send.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/greycard.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/titleanddesc.dart';
// import 'package:htp_customer/features/idverification/presentation/widgets/verify_appbar.dart';
// import 'package:htp_customer/htp_theme.dart';

// class ScanBill extends StatefulWidget {
//   static const route = "/scanbill";
//   const ScanBill({super.key});

//   @override
//   State<ScanBill> createState() => _ScanBillState();
// }

// class _ScanBillState extends State<ScanBill> {
//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }

//   List<CameraDescription>? cameras;
//   CameraController? controller;

//   loadCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera

//       controller!.initialize().then((_) {});
//     } else {
//       print("NO any camera found");
//     }
//   }

//   Future<XFile?> takePicture() async {
//     final CameraController? cameraController = controller;
//     if (cameraController!.value.isTakingPicture) {
//       // A capture is already pending, do nothing.
//       return null;
//     }
//     try {
//       XFile file = await cameraController.takePicture();
//       return file;
//     } on CameraException catch (e) {
//       print('Error occured while taking picture: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: VerifyAppBar(
//             hideBackButton: true,
//             // leftSpace: 12,
//             child: Text(
//               "Bill verification",
//               style: HtpTheme.newTitleTextStyle,
//             )),
//         body: buildBody(context),
//       ),
//     );
//   }

//   Widget buildBody(BuildContext context) {
//     var width = MediaQuery.of(context).size.width -
//         (MediaQuery.of(context).size.width / 3);

//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           GreyCard(
//               child: Stack(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 40),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     border:
//                         Border.all(color: HtpTheme.greytext1Color, width: 0.9)),
//                 child: SvgPicture.asset(
//                   "assets/svg/images/verification/others/corner_border.svg",
//                   // width: width,
//                   width: 600,
//                   height: 320,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Container(
//                   child: controller == null
//                       ? Container()
//                       : !controller!.value.isInitialized
//                           ? const CircularProgressIndicator()
//                           : CameraPreview(controller!),
//                 ),
//               ),
//             ],
//           )),
//           const TitleAndDesc(
//               title: "Capture your bill",
//               desc:
//                   "Start by positioning front of your bill in the Frame. Use a well-lit area and a simple dark background"),
//           // const SizedBox(
//           //   height: 12,
//           // ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 12),
//             child: GoldBorderButton(
//                 // height: 40,
//                 onTap: () async {
//                   var images = await controller!.takePicture();
//                   XFile? rawImage = await takePicture();
//                   File imageFile = File(rawImage!.path);

//                   int currentUnix = DateTime.now().millisecondsSinceEpoch;
//                   // final directory = await getApplicationDocumentsDirectory();
//                   String fileFormat = imageFile.path.split('.').last;

//                   // await imageFile.copy(
//                   //   '${directory.path}/$currentUnix.$fileFormat',
//                   // );
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BillSend()));
//                 },
//                 text: "CAPTURE",
//                 textStyle: HtpTheme.detailTitleText.apply(fontWeightDelta: 1)),
//           )
//         ],
//       ),
//     );
//   }
// }

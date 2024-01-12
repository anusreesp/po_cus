// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_customer/features/membership/controller/id_verification_screen_control.dart';
// import 'package:htp_customer/features/membership/data/model/membership_response.dart';
//
// import '../../../../common/widgets_common/outlined_black_button.dart';
// import '../../../../common/widgets_common/rounded_golden_button.dart';
// import '../../../../common/widgets_common/text_field_electra.dart';
// import '../../../../htp_theme.dart';
// import '../../../../networking/http_client.dart';
// import '../../controller/membership_application_controller.dart';
// import 'confirmation_display_page.dart';
//
// class CrewCaptureId extends StatefulWidget {
//   final MembershipData data;
//   const CrewCaptureId({super.key, required this.data});
//
//   @override
//   State<CrewCaptureId> createState() => _CrewCaptureIdState();
// }
//
// class _CrewCaptureIdState extends State<CrewCaptureId> {
//   List<CameraDescription>? cameras;
//   CameraController? controller;
//
//   XFile? _capturedImage;
//
//   String? _frontIdUrl;
//   String? _backIdUrl;
//
//   bool uploadingImage = false;
//
//   /// If front id uploaded means the url is received
//   bool get frontIdUploaded => _frontIdUrl != null;
//
//   bool get captureState => _capturedImage == null;
//
//   //both id and url is null --- initial state
//
//   Future<void> uploadImage() async {
//     setState(() {
//       uploadingImage = true;
//     });
//
//     if (!frontIdUploaded) {
//       // await Future.delayed(const Duration(seconds: 1));
//       _frontIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
//       setState(() {
//         _capturedImage = null;
//         uploadingImage = false;
//       });
//     } else {
//       // await Future.delayed(const Duration(seconds: 1));
//       _backIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
//       setState(() {
//         _capturedImage = null;
//         uploadingImage = false;
//       });
//     }
//   }
//
//   captureId() async {
//     _capturedImage = await takePicture();
//     setState(() {});
//   }
//
//   loadCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![0], ResolutionPreset.high,
//           enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
//       //cameras[0] = first camera, change to 1 to another camera
//
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         } else {
//           setState(() {});
//         }
//       });
//     } else {
//       debugPrint("No any camera found");
//     }
//   }
//
//   Future<XFile?> takePicture() async {
//     // final CameraController? cameraController = controller;
//     if (controller!.value.isTakingPicture) {
//       debugPrint('A capture is already pending, do nothing.');
//       // A capture is already pending, do nothing.
//       return null;
//     }
//     try {
//       XFile file = await controller!.takePicture();
//       debugPrint("FILE: $file");
//       return file;
//     } on CameraException catch (e) {
//       debugPrint('Error occurred while taking picture: $e');
//       return null;
//     } catch (_) {
//       rethrow;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       final requestController = ref.watch(membershipApplicationProvider);
//
//       ref.listen(membershipApplicationProvider, (previous, next) {
//         if (next is MAErrorState) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(next.msg)));
//         }
//
//         if (next is MASubmitState) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const ConfirmationDisplayPage()),
//               (route) => route.isFirst);
//         }
//       });
//
//       return Column(
//         children: [
//           const SizedBox(
//             height: 18,
//           ),
//
//           Container(
//             width: double.infinity,
//             height: 240,
//             color: HtpTheme.lightBlueColor,
//             child: _capturedImage != null
//                 ? Image.file(
//                     File(_capturedImage!.path),
//                     fit: BoxFit.cover,
//                   )
//                 : controller != null
//                     ? CameraPreview(controller!)
//                     : const SizedBox.shrink(),
//           ),
//
//           const SizedBox(
//             height: 28,
//           ),
//
//           Text(
//             frontIdUploaded ? 'Back Side' : 'Front Side',
//             style: tenor22White,
//           ),
//
//           Padding(
//             padding: const EdgeInsets.fromLTRB(54, 18, 54, 0),
//             child: Text(
//               'Place the ${frontIdUploaded ? 'back' : 'front'} side of your ID in the frame and take a photo',
//               style: man14LightGrey,
//               textAlign: TextAlign.center,
//             ),
//           ),
//
//           const Spacer(),
//
//           !uploadingImage && requestController is! MALoadingState
//               ? Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16),
//                       child: OutlinedBlackButton(
//                           text: captureState ? 'Capture' : 'Retake',
//                           onTap: () {
//                             if (captureState) {
//                               captureId();
//                             } else {
//                               setState(() {
//                                 _capturedImage = null;
//                               });
//                             }
//                           }),
//                     ),
//                     if (captureState &&
//                         _capturedImage == null &&
//                         frontIdUploaded)
//                       Column(
//                         children: [
//                           const DividerElectra(),
//                           TextButton(
//                               onPressed: () {
//                                 if (_frontIdUrl != null) {
//                                   ref
//                                       .read(idVerificationScreen.notifier)
//                                       .state = VerificationScreen.selfie;
//                                   ref
//                                       .read(membershipApplicationProvider
//                                           .notifier)
//                                       .submitMembershipRequest(widget.data,
//                                           frontIdPath: _frontIdUrl);
//                                   // ref.read(membershipFormDataProvider.notifier).addGovtId(_frontIdUrl!, _backIdUrl);
//                                 }
//                               },
//                               child: const Text(
//                                 'Skip if not applicable',
//                                 style: TextStyle(
//                                     fontFamily: manrope,
//                                     fontSize: 14,
//                                     decoration: TextDecoration.underline,
//                                     color: HtpTheme.goldenColor,
//                                     decorationThickness: 2),
//                               ))
//                         ],
//                       ),
//                     if (_capturedImage != null)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: RoundedGoldenButton(
//                           onTap: () {
//                             uploadImage().then((_) {
//                               if (_frontIdUrl != null && _backIdUrl != null) {
//                                 ref.read(idVerificationScreen.notifier).state =
//                                     VerificationScreen.selfie;
//                                 ref
//                                     .read(
//                                         membershipApplicationProvider.notifier)
//                                     .submitMembershipRequest(widget.data,
//                                         frontIdPath: _frontIdUrl,
//                                         backIdPath: _backIdUrl);
//                                 // ref.read(membershipFormDataProvider.notifier).addGovtId(_frontIdUrl!, _backIdUrl);
//                               }
//                             });
//                           },
//                           text: _frontIdUrl == null
//                               ? 'Continue'
//                               : "Send Membership Request",
//                           textStyle: man16BlackW5,
//                         ),
//                       ),
//                   ],
//                 )
//               : const CircularProgressIndicator(),
//
//           const SizedBox(
//             height: 18,
//           )
//           // DividerElectra(),
//         ],
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller?.dispose();
//   }
// }

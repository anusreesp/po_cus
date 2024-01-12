import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/membership/presentation/screens/selfie_screen.dart';
import 'package:htp_customer/features/membership/presentation/screens/upload_id.dart';
import '../../controller/id_verification_screen_control.dart';

class FileUploads extends ConsumerWidget {
  const FileUploads({super.key});

  final List<Widget> children = const [
    // UploadGovtID(),
    // CaptureId(),
    UploadId(),
    Selfie(),
    // SelfieUpload(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(idVerificationScreen);
    return children[controller.index];
  }
}
//
// class UploadGovtID extends ConsumerWidget {
//   const UploadGovtID({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 18,
//           ),
//           const Text(
//             'Upload a photo of your Government ID',
//             style: tenor22White,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 34.0),
//             child: Text(
//               'Please make sure your valid ID is with you. It is necessary for the next steps.',
//               style: man14LightGrey,
//             ),
//           ),
//           const Spacer(),
//           OutlinedBlackButton(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset('assets/svg/icons/membership/upload.svg'),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   const Text(
//                     'Upload photo',
//                     style: man16White,
//                   )
//                 ],
//               ),
//               onTap: () {
//                 ref.read(idVerificationScreen.notifier).state =
//                     VerificationScreen.upload;
//               }),
//           const DividerElectra(),
//           OutlinedBlackButton(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                       'assets/svg/icons/membership/capturephoto.svg'),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   const Text(
//                     'Capture photo',
//                     style: man16White,
//                   )
//                 ],
//               ),
//               onTap: () {
//                 ref.read(idVerificationScreen.notifier).state =
//                     VerificationScreen.capture;
//               }),
//           const SizedBox(
//             height: 20,
//           )
//         ],
//       ),
//     );
//   }
// }

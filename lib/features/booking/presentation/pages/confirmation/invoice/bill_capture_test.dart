// import 'dart:io';
//
// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
// import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
// import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
// import 'package:htp_customer/htp_theme.dart';
// import 'package:path_provider/path_provider.dart';
// xa
// class BillCaptureTest extends StatefulWidget {
//   final String id, bookingType;
//   const BillCaptureTest(
//       {super.key, required this.id, required this.bookingType});
//
//   @override
//   State<BillCaptureTest> createState() => _BillCaptureTestState();
// }
//
// class _BillCaptureTestState extends State<BillCaptureTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const AppbarBackButton(),
//         title: const Text(
//           'UPLOAD INVOICE',
//           style: man14White,
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 40, bottom: 32),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.58,
//               width: MediaQuery.of(context).size.width,
//               child: CameraAwesomeBuilder.awesome(
//                 saveConfig: SaveConfig.photo(pathBuilder: () async {
//                   final Directory extDir = await getTemporaryDirectory();
//                   final testDir = await Directory('${extDir.path}/camerawesome')
//                       .create(recursive: true);
//
//                   return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//                 }),
//                 // onMediaTap: (p0) {
//                 //   print('Tap on ${p0.filePath}');
//                 // },
//                 // onPreviewTapBuilder: (p0) => OnPreviewTap(
//                 //     onTap: (position, flutterPreviewSize, pixelPreviewSize) {}),
//                 // middleContentBuilder: (state) {
//                 //   return Column(
//                 //     children: [
//                 //       AwesomeFilterWidget(state: state),
//                 //       Builder(builder: (context) => Container()),
//                 //       AwesomeCameraModeSelector(state: state),
//                 //     ],
//                 //   );
//                 // },
//               ),
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: OutlinedBlackButton(
//               onTap: () async {},
//               text: 'Retake',
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: OutlinedBlackButton(
//               onTap: () async {},
//               text: 'Capture',
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
//             child: RoundedGoldenButton(
//               onTap: () {},
//               text: 'Continue',
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

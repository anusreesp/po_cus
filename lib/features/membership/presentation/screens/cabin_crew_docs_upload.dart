import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/features/membership/presentation/screens/crew_upload_id.dart';
import 'package:htp_customer/htp_theme.dart';

enum CabinCrewDocs { menu, capture }

final cabinCrewDocsScreen =
    StateProvider.autoDispose<CabinCrewDocs>((ref) => CabinCrewDocs.menu);

class CabinCrewDocsUpload extends ConsumerWidget {
  final MembershipData data;
  const CabinCrewDocsUpload({super.key, required this.data});

  List<Widget> get children => [
        const UploadCabinCrewId(),
        // CrewCaptureId(
        //   data: data,
        // ),
        CrewUploadId(
          data: data,
        ),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cabinCrewDocsScreen);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEMBERSHIP'),
        automaticallyImplyLeading: false,
        leading: const AppbarBackButton(),
      ),
      body: children[controller.index],
    );
  }
}

class UploadCabinCrewId extends ConsumerWidget {
  const UploadCabinCrewId({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Upload Cabin Crew ID',
                style: tenor22White,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 34.0),
            child: Text(
              'Please make sure you have your valid Cabin Crew ID with you',
              style: man14LightGrey,
            ),
          ),
          const Spacer(),
          SvgPicture.asset('assets/svg/icons/membership/take_selfie.svg'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 44),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_rounded,
                  color: HtpTheme.goldenColor,
                  size: 14,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: Text(
                  'Please ensure that you are presently serving as an active cabin crew member',
                  style: man14LightGrey,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
          const Spacer(),
          // OutlinedBlackButton(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SvgPicture.asset('assets/svg/icons/membership/upload.svg'),
          //         const SizedBox(
          //           width: 16,
          //         ),
          //         const Text(
          //           'Upload photo',
          //           style: man16White,
          //         )
          //       ],
          //     ),
          //     onTap: () {
          //       ref.read(cabinCrewDocsScreen.notifier).state =
          //           CabinCrewDocs.capture;
          //     }),
          // const DividerElectra(),
          OutlinedBlackButton(
              text: 'Upload photo',
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SvgPicture.asset(
              //         'assets/svg/icons/membership/capturephoto.svg'),
              //     const SizedBox(
              //       width: 16,
              //     ),
              //     const Text(
              //       'Capture photo',
              //       style: man16White,
              //     )
              //   ],
              // ),
              onTap: () {
                ref.read(cabinCrewDocsScreen.notifier).state =
                    CabinCrewDocs.capture;
              }),
          const SizedBox(
            height: 22,
          )
        ],
      ),
    );
  }
}

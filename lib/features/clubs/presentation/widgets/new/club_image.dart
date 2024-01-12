import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';

import '../../../../../htp_theme.dart';
import '../../../../profile/controller/fav_club_list.dart';
import '../../../controllers/club_details_controller.dart';
import '../../../data/models/club_list_api_response.dart';
import '../../../data/models/fire_club_details.dart';
import '../../../data/services/club_services.dart';

class ClubImage extends ConsumerWidget {
  // final ClubDataNew data;
  final String? displayImage;
  final bool featured;
  final String? logo;

  ClubImage({
    super.key,
    /* required this.data */
    this.displayImage,
    required this.featured,
    this.logo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 145,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          displayImage != null
              ? Image(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(displayImage!))
              : const Image(
                  image: AssetImage(
                      'assets/images/placeholders/placeholder_15.png'),
                  fit: BoxFit.cover,
                ),
          Positioned(
              right: -0,
              child: Column(children: [
                if (featured ?? false)
                  Container(
                    height: 24,
                    width: 80,
                    color: HtpTheme.goldColor,
                    child: const Center(
                        child: Text(
                      "FEATURED",
                      style: man10DarkBlue,
                    )),
                  ),
              ])),
          logo == null
              ? SizedBox()
              : Positioned(
                  bottom: 10,
                  left: 15,
                  child: CircleAvatar(
                      radius: 29,
                      //-------------------------------------Change here--------------------------------------
                      backgroundImage:
                          const AssetImage('assets/images/logoBg.png'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image(
                          image: NetworkImage("$logo"),
                          // AssetImage(
                          //     'assets/images/temp/profile.png'),
                          height: 55,
                          width: 55,
                          fit: BoxFit.cover,
                        ),
                      ))),
          Positioned(
              bottom: 0,
              child: NeedleHorizontal(
                thickness: 1,
                width: MediaQuery.of(context).size.width * 0.65,
              ))
        ]));
    // }
    // if (snapshot.hasError) {
    //   return Center(child: Text(snapshot.error.toString()));
    // }

    // if (snapshot.connectionState == ConnectionState.waiting) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // return const SizedBox.shrink();
    // }
    // );
  }
}

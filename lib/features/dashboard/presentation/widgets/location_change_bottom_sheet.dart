import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/services/location_service.dart';
import 'package:htp_customer/common/widgets_common/needles_widget.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/dashboard/controllers/location_background_controller.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/htp_theme.dart';

class LocationChangeBottomSheet extends ConsumerWidget {
  final LocationChanged locationChanged;
  const LocationChangeBottomSheet({Key? key, required this.locationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // height: MediaQuery.of(context).size.height/2 + 30,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: HtpTheme.darkBlue2Color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          Container(
            width: 75,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: HtpTheme.whiteColor),
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            "Your current location is \n${locationChanged.cityName}",
            style: tenor22White,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          NeedleDoubleSided(
            width: MediaQuery.of(context).size.width - 62,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 300,
              child: Text(
                "Update your location to see clubs and events near you",
                style: man14White,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedBlackButton(
                  onTap: () {
                    ref.read(userLocationProvider.notifier).canDisplayLocationPopup = false;
                    Navigator.pop(context);
                  },
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: const Center(
                    child: Text(
                      "Cancel",
                      style: man16White,
                    ),
                  )),
              RoundedGoldenButton(
                onTap: () {
                  ref.read(userLocationProvider.notifier).updateLocation(
                      locationChanged.cityName,
                      locationChanged.newLat,
                      locationChanged.newLng);
                  ref.read(userLocationProvider.notifier).canDisplayLocationPopup = false;
                  Navigator.of(context).pop();
                },
                text: "Update",
                childPadding: const EdgeInsets.symmetric(horizontal: 62),
              )
            ],
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/locations/presentation/location.dart';

import '../../features/dashboard/controllers/dashboard_controllers.dart';
import '../../features/dashboard/controllers/location_controller.dart';
import '../../htp_theme.dart';
import 'goldborder_button.dart';

class LocationLoadPlaceholder extends ConsumerWidget {
  final bool loading;
  final String? errorMsg;
  const LocationLoadPlaceholder({Key? key, this.loading = true, this.errorMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   "assets/svg/icons/logos/party_one_logo.svg",
          // ),
          // const SizedBox(height: 16,),

          loading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CircularProgressIndicator(color: HtpTheme.goldenColor),
                    SizedBox(
                      width: 12,
                    ),
                    Text('Fetching your location')
                  ],
                )
              : Column(
                  children: [
                    Text(
                      '$errorMsg',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        RoundedGoldenButton(
                            onTap: () {
                              ref
                                  .read(dashboardProvider.notifier)
                                  .gotoPage(TabItem.home, LocationPage.route);
                            },
                            text: 'Select location manually'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: FloatingBlackButton(
                          onTap: () {
                            ref
                                .read(userLocationProvider.notifier)
                                .getUserLocation();
                          },
                          text: 'Retry',
                          // textStyle: const TextStyle(color: Colors.white),
                        ))
                      ],
                    )
                  ],
                )
        ],
      ),
    );
  }
}

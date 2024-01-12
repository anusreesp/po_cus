import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/background.dart';
import 'package:htp_customer/htp_theme.dart';
import '../dashboard/presentation/widgets/custom_app_bar.dart';

class TakeMeHome extends ConsumerWidget {
  static const route = '/takeme';
  TakeMeHome({super.key});

  List<String> logoImage = [
    "grab.png",
    "ola.png",
    "uber.png",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationController = ref.watch(userLocationProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          // height: 20,
          child: Text(
            "Take Me Home",
            // style: HtpTheme.newTitleTextStyle
          ),
        ),
        body: Stack(
          children: [
            const DefaultBackground(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        buildNewItem('assets/images/logos/bl_logo.jpg'),
                        buildNewItem('assets/images/logos/carey_logo.png'),
                        buildNewItem('assets/images/logos/empirecels_logo.png'),
                      ],
                    ),

                    // locationController is LocationLoaded
                    //     ? buildLogo(locationController.countryName?.toLowerCase(), context)
                    //     : buildLogo(null, context),

                    // const SizedBox(
                    //   // height: 140,
                    //   width: double.infinity,
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     // child: Padding(
                    //     //   padding:
                    //     //       EdgeInsets.symmetric(horizontal: 0.0, vertical: 18),
                    //     //   child: SearchBox(),
                    //     // ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(bottom: 12.0, left: 8),
                    //       child: Text("Take me home", style: HtpTheme.newTitleTextStyle),
                    //     ),
                    //     const Spacer(),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppCard(
                    //   onTap: () {
                    //     // Navigator.pushNamed(context, ClubDetails.route
                    //     // );
                    //   },
                    //   imageName: logoImage[2],
                    //   buttonName: 'Book Now!',
                    // ),
                    // SizedBox(height: 8),

                    const SizedBox(
                      height: 16,
                    ),

                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "This feature is coming soon !",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildNewItem(String image, {bool colorBlend = false}) {
    return Container(
      height: 86,
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Image(
        image: AssetImage(image),
        color: colorBlend ? Colors.black : null,
      ),
    );
  }

  Widget buildLogo(String? countryName, BuildContext context) {
    List<String> grabPresenceList = [
      'thailand',
      'cambodia',
      'indonesia',
      'malaysia',
      'myanmar',
      'philippines',
      'singapore',
      'vietnam'
    ];
    if (countryName == null) {
      emptyPlaceholder(context);
    }
    if (countryName == 'india') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppCard(
            onTap: () {},
            imageName: logoImage[1], //Ola
            buttonName: 'Coming Soon',
          ),
          AppCard(
            onTap: () {},
            imageName: logoImage[2], //Uber
            buttonName: 'Coming Soon',
          ),
        ],
      );
    }
    if (countryName == 'dubai') {
      return AppCard(
        onTap: () {},
        imageName: logoImage[2], //Uber
        buttonName: 'Coming Soon',
      );
    }
    if (countryName == 'london') {
      return AppCard(
        onTap: () {},
        imageName: logoImage[2], //Uber
        buttonName: 'Coming Soon',
      );
    }
    if (grabPresenceList.contains(countryName)) {
      return AppCard(
        onTap: () {},
        imageName: logoImage[0], //Grab
        buttonName: 'Coming Soon',
      );
    }

    return emptyPlaceholder(context);
  }

  Widget emptyPlaceholder(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
        child: const Image(
          image: AssetImage('assets/images/placeholders/take_me_home.png'),
          width: 240,
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final void Function()? onTap;
  final String imageName;
  final String buttonName;

  const AppCard({
    Key? key,
    this.onTap,
    required this.imageName,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 85,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Image(
                    image: AssetImage("assets/images/others/$imageName"),
                    height: 120,
                    width: 130,
                    fit: BoxFit.contain,
                  ),
                ),
                // const Spacer(),
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(6),
                //     child: Container(
                //         height: 40,
                //         width: 115,
                //         color: Color.fromARGB(255, 233, 233, 233),
                //         child: Center(
                //           child: FittedBox(
                //             child: Text(
                //               buttonName,
                //               style: const TextStyle(
                //                   fontWeight: FontWeight.w600, fontSize: 16),
                //             ),
                //           ),
                //         ))),
                // const SizedBox(
                //   width: 16,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

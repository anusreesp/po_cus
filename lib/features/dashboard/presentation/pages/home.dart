import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/common/services/location_service.dart';
import 'package:htp_customer/common/utils/images_path.dart';
import 'package:htp_customer/common/utils/member_utils.dart';
import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/features/dashboard/controllers/ad_benner_controller.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/controllers/location_background_controller.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/email_verify_check.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/location_change_bottom_sheet.dart';
import 'package:htp_customer/features/dashboard/spacing_values.dart';
import 'package:htp_customer/features/event/controllers/event_list_controller.dart';
import 'package:htp_customer/shimmers/home/advertisement.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/shimmers/home/club_list_shimmer.dart';
import 'package:htp_customer/shimmers/home/event_list_shimmer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../../common/widgets_common/location_loading_placeholder.dart';
import '../../../../common/widgets_common/needles_widget.dart';
import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../common/widgets_common/update_app_bottom_sheet.dart';
import '../../../locations/presentation/location.dart';
import '../../../membership/presentation/memberships.dart';
import '../../../profile/controller/booking_list_controller.dart';
import '../../controllers/ad_popup_controller.dart';
import '../../controllers/app_config_controller.dart';
import '../../controllers/email_verification_controller.dart';
import '../../data/models/app_settings.dart';
import '../widgets/ad_popup.dart';
import '../widgets/add_banner_scrollable.dart';
import '../widgets/coming_soon.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_page_components.dart';
import '../widgets/past_booking_widgets.dart';

final homeScrollController = ScrollController();

class HomeScreen extends ConsumerWidget {
  static const route = '/home';
  final GlobalKey<ScaffoldState>? dashBoardScaffoldKey;
  const HomeScreen({super.key, this.dashBoardScaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    final activeMembership =
        (authController as AuthLoggedInState).activeMembership;
    print('ACTIVE: $activeMembership');
    final screenHeight = MediaQuery.of(context).size.height;

    ref.listen(appConfigProvider, (previous, next) {
      if (next is AppConfigLoaded) {
        checkUpdate(next.settings, context);
      }
    });

    ref.listen(locationBackgroundProvider, (previous, next) {
      if (next is LocationLatLngFetched) {
        ref
            .read(userLocationProvider.notifier)
            .updateLocation(next.cityName, next.lat, next.lng);
      }

      if (next is LocationChanged) {
        showLocationUpdate(context, next);
      }
    });

    ref.listen(adPopupProvider, (previous, next) {
      print("--------------------------------------<<${next}");
      if (next is AdPopupShow && next.images.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AdPopup(
                images: next.images,
                eventName: next.clubEventName,
                url: next.url ?? [],
                internalRedirect: next.internalRedirect ?? [],
              );
            });
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      // drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(bookingListProvider.notifier).init();
          // fire.reloadUser();
          ref.read(emailVerificationProvider.notifier).userReload();
          ref.invalidate(adBannerProvider);
        },
        child: CustomScrollView(
          controller: homeScrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: HtpTheme.darkBlue1Color,
              forceElevated: true,
              title: SearchTitle(
                dashboardScaffoldKey: dashBoardScaffoldKey,
                titleWidget: const LocationIcon(),
              ),
              expandedHeight: activeMembership != MembershipType.nonMember
                  ? screenHeight * 0.65
                  : screenHeight * 0.76,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: activeMembership == MembershipType.nonMember
                    ? CollapseMode.none
                    : CollapseMode.parallax,
                background: activeMembership != MembershipType.nonMember
                    ? const HeroSectionExistingUser()
                    : const HeroSection(),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Consumer(builder: (context, ref, _) {
                final userLocationController = ref.watch(userLocationProvider);
                if (userLocationController is LocationLoaded) {
                  return _buildBody(context, userLocationController.cityName,
                      ref, activeMembership != MembershipType.nonMember);
                }
                if (userLocationController is LocationError) {
                  return Center(
                      child: LocationLoadPlaceholder(
                    loading: false,
                    errorMsg: userLocationController.msg,
                  ));
                }
                return const Center(child: LocationLoadPlaceholder());
              }),
              const SizedBox(
                height: 60,
              ),
              SvgPicture.asset(
                logo,
                height: 70,
              ),
              const SizedBox(
                height: 150,
              )
            ]))
          ],
        ),
      ),
    );
  }

  showLocationUpdate(
      BuildContext context, LocationChanged changedLocation) async {
    showBottomSheet(
      context: context,
      builder: (context) {
        return LocationChangeBottomSheet(
          locationChanged: changedLocation,
        );
      },
    );
  }

  checkUpdate(AppSettings settings, BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final int buildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    debugPrint("VERSION ------------------ $buildNumber");
    debugPrint(
        "LATEST VERSION ------------------ ${settings.latestBuildNumber}");
    if (buildNumber < settings.buildNumberInt) {
      if (context.mounted) {
        debugPrint("CHECK VERSION EXECUTED");
        showBottomSheet(
            context: context,
            builder: (context) {
              return UpdateAppComponent(
                onConfirm: () {
                  const appId = 'one.party.customer';
                  final uri = Uri.parse(Platform.isAndroid
                      ? 'market://details?id=$appId'
                      : 'https://apps.apple.com/app/id$appId');
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                onTapClose: () {
                  Navigator.of(context).pop();
                },
                image: "assets/svg/icons/update_app_icon.svg",
              );
            });
      }
    }
  }

  Widget _buildBody(BuildContext context, String cityName, WidgetRef ref,
      bool hasActiveMembership) {
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          // final linkSentProvider = ref.watch(verificationLinkSentProvider);
          final verificationStatus = ref.watch(emailVerificationProvider);
          final providerId = ref
              .read(firebaseAuthServiceProvider)
              .geCurrentUser()
              ?.providerData
              .first
              .providerId;
          if (providerId != 'google.com' || providerId != 'apple.com') {
            if (verificationStatus is EmailVerificationLoaded) {
              if (!verificationStatus.isVerifed) {
                return const Padding(
                    padding: EdgeInsets.fromLTRB(16, 36, 16, 16.0),
                    child: EmailVerifictionSection());
              }
            }

            return const SizedBox();
          }
          return const SizedBox();
        }),

        const SizedBox(
          height: 8,
        ),
        const Bookings(),

        HorizontalTextButton(
          padding: const EdgeInsets.fromLTRB(leftDashboardPadding, 8, 8, 12),
          title: 'Clubs',
          onTap: () {
            ref.read(dashboardProvider.notifier).selectTab(TabItem.clubs);
          },
        ),

        ///Clubs list
        Consumer(builder: (context, ref, _) {
          final clubs = ref.watch(clubListProvider);

          if (clubs is ClubError ||
              (clubs is ClubLoaded && clubs.clubs.isEmpty)) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'No clubs found nearby. Consider changing location',
                      style: tenor22LightBlue,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 10,
                      width: 210,
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      decoration: BoxDecoration(
                          color: const Color(0xff151F2C),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Container(
                      height: 10,
                      width: 160,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                          color: const Color(0xff151F2C),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    RoundedGoldenButton(
                      onTap: () {
                        ref
                            .read(dashboardProvider.notifier)
                            .gotoPage(TabItem.home, LocationPage.route);
                      },
                      text: 'Change Location',
                    )
                  ],
                ),
              ),
            );
          }

          if (clubs is ClubLoaded) {
            return SizedBox(
              height: 358,
              child: ListView.builder(
                  itemCount: clubs.clubs.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                      right: rightDashboardPadding, left: leftDashboardPadding),
                  itemBuilder: (context, index) {
                    return ClubCardSpock(data: clubs.clubs[index]);
                  }),
            );
          }

          return const ClubListShimmer();
        }),

        ///Ads banner
        Consumer(builder: (context, ref, _) {
          final controller = ref.watch(adBannerProvider(cityName));
          return controller.when(data: (data) {
            return Column(
              children: [
                if (data.isNotEmpty)
                  const Padding(
                    padding:
                        EdgeInsets.fromLTRB(leftDashboardPadding, 16, 8, 4),
                    child: SizedBox(
                        height: 40,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Promotions and Offers',
                                style: tenor14LightBlue,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: NeedleHorizontal(
                                width: double.infinity,
                                thickness: 1,
                              )),
                            ])),
                  ),
                Container(
                  height: 180,
                  // padding: const EdgeInsets.only(left: 26),
                  margin: const EdgeInsets.only(bottom: 18, left: 0),
                  child: AddBannerScrollable(
                    data: data,
                  ),
                ),
              ],
            );
          }, error: (error, stack) {
            return SizedBox(
              height: 120,
              child: Center(
                child: Text(error.toString()),
              ),
            );
          }, loading: () {
            return const AdvertisementShimmer();
          });
        }),

        ///Events list
        Consumer(builder: (context, ref, _) {
          // final locationController = ref.watch(userLocationProvider);
          final eventController = ref.watch(eventListProvider);

          return eventController.when(
              data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.isNotEmpty)
                      HorizontalTextButton(
                        title: 'Events',
                        onTap: () {
                          ref
                              .read(dashboardProvider.notifier)
                              .selectTab(TabItem.events);
                        },
                      ),
                    if (data.isNotEmpty)
                      SizedBox(
                        height: 290,
                        child: ListView.builder(
                            itemCount: data.length,
                            padding: const EdgeInsets.only(
                                left: leftDashboardPadding - 12,
                                right: rightDashboardPadding),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return EventCardSpock(
                                data: data[index],
                              );
                            }),
                      )
                  ],
                );
              },
              error: (error, stack) {
                return const SizedBox.shrink();
              },
              loading: () => const EventListShimmer());
        }),

        if (!hasActiveMembership)
          const HorizontalTextButton(title: 'Journey to be the one!'),

        if (!hasActiveMembership)
          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: rightDashboardPadding),
              children: [
                CampaignCardSpock(
                  title: 'Choose a \nmembership',
                  description:
                      'Our collection of memberships is designed for your unique desires and preferences',
                  backgroundImage:
                      'assets/svg/icons/dashboard/choosemembership_bg.png',
                  bottomWidget: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MembershipsPage.route);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/membership_circle.png',
                          height: 56,
                        ),
                        const Spacer(),
                        const Text('Explore'),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/svg/arrow_splashscreen.svg',
                          color: HtpTheme.goldenColor,
                        )
                      ],
                    ),
                  ),
                ),
                CampaignCardSpock(
                  title: 'Discover \nexclusive clubs',
                  description:
                      'Delve into our curated selection of clubs and events happening around the world',
                  bottomWidget: Image.asset(
                    'assets/images/icons/appimage.png',
                    height: 56,
                  ),
                ),
                CampaignCardSpock(
                  title: 'Effortless bookings',
                  description:
                      'Party One helps you gain access to the best nightlife venues and events worldwide, with just a few clicks',
                  bottomWidget: Image.asset(
                    'assets/images/icons/appimage2.png',
                    height: 56,
                  ),
                ),
              ],
            ),
          ),

        ///Loyalty section ------------------
        const LoyaltySection(),

        const HorizontalTextButton(title: 'Coming soon'),
        // Row(
        //   children: [
        //     PictureButton(
        //       title: 'Ladies Night',
        //       onTap: () {
        //         Navigator.pushNamed(context, LadiesNight.route);
        //       },
        //       imagePath: 'assets/images/icons/ladie_night.jpeg',
        //     ),
        //     PictureButton(
        //       title: 'Take Me Home',
        //       onTap: () {
        //         Navigator.pushNamed(context, TakeMeHome.route);
        //       },
        //       imagePath: 'assets/images/icons/take_me_home.jpeg',
        //     ),
        //     // PictureButton(
        //     //   title: 'Yacht and charter services',
        //     //   onTap: () {},
        //     //   imagePath: 'assets/images/coming_soon/yacht_and_charter.jpg',
        //     // ),
        //   ],
        // ),

        //----------------------------
        const SizedBox(height: 200, child: ComingSoonPart())
      ],
    );
  }
}

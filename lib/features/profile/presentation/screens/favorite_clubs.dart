import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/goldborder_button.dart';
import 'package:htp_customer/common/widgets_common/horizontal_scroll_with_controller.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
import 'package:htp_customer/features/clubs/data/models/club_list_api_response.dart';
import 'package:htp_customer/features/clubs/data/models/fire_club_details.dart';
import 'package:htp_customer/features/clubs/data/services/club_services.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/rating_box.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/profile/controller/fav_club_list.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/router.dart';

class MyFavoriteClubsPage extends ConsumerWidget {
  static const route = '/favourite';
  const MyFavoriteClubsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "FAVORITE CLUBS",
            style: man14LightBlue,
          ),
          leading: AppbarBackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Consumer(builder: (context, ref, _) {
                final controller = ref.watch(favClubListProvider);
                return controller.when(
                    data: (List<ClubDataModel> data) {
                      if (data.isNotEmpty) {
                        return Expanded(
                          child: GridView.builder(
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.86),
                              itemBuilder: (context, index) {
                                return FavoriteTile(
                                  onMainTap: () {
                                    mainNavigatorKey.currentState!.pushNamed(
                                        ClubDetailsPage.route,
                                        arguments: data[index].id);
                                  },
                                  img: data[index].displayImage ?? "",
                                  title: data[index].name,
                                  city: data[index].cityName,
                                  country: data[index].countryName ?? "",
                                  onTap: () async {
                                    await ref
                                        .read(clubServiceProvider)
                                        .deleteFav(data[index].id);
                                    ref.invalidate(favClubListProvider);
                                  },
                                );
                              }),
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              SvgPicture.asset(
                                  'assets/svg/icons/no_favourite_clubs.svg',
                                  height: 100),
                              SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Start by adding a club!",
                                    style: tenor22White,
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  width: 230,
                                  child: Text(
                                    "You have not added any clubs to your  favorites, Add Now!",
                                    style: man14LightGrey,
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                height: 24,
                              ),
                              OutlinedBlackButton(
                                  onTap: () {
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    ref
                                        .read(dashboardProvider.notifier)
                                        .selectTab(TabItem.clubs);
                                  },
                                  child: Center(
                                      child: Text(
                                    "Explore Clubs",
                                    style: man16LightBlue,
                                  )))
                            ],
                          ),
                        );
                      }
                    },
                    error: (e, _) => Text(e.toString()),
                    loading: () => Expanded(
                        child:
                            Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),)));
              }),
            ],
          ),
        ));
  }
}

class FavoriteTile extends StatelessWidget {
  final String img;
  final String title;
  final String city;
  final String country;
  final GestureTapCallback onTap;
  final GestureTapCallback onMainTap;
  const FavoriteTile(
      {Key? key,
      required this.img,
      required this.title,
      required this.city,
      required this.country,
      required this.onTap,
      required this.onMainTap})
      : super(key: key);
  // await ref.read(clubServiceProvider).deleteFav(widget.id);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMainTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 140,
                    width: 200,
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Text(
                          title,
                          style: tenor16White,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      city + ", " + country,
                      style: man14LightBlue,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 8),
            height: 60,
            width: 200,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: HtpTheme.goldenColor,
                ),
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavClubPlaceholder extends ConsumerWidget {
  const _FavClubPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/images/placeholders/fav_club_place.png'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 22),
          child: Text(
            'Oops! Looks like you don\'t have any favourite clubs yet',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 160,
          child: GoldBorderButton(
            height: 36,
            onTap: () {
              ref.read(dashboardProvider.notifier).selectTab(TabItem.clubs);
            },
            text: 'Find Clubs',
            textStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        const Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
            child: Text(
              'Suggestions',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final controller = ref.watch(clubListProvider);

          if (controller is ClubLoaded && controller.clubs.isNotEmpty) {
            return SizedBox(
              height: 92,
              child: HorizontalScrollWithController(
                  itemCount: controller.clubs.length,
                  itemBuilder: (context, count) {
                    return _FavClubCard(
                      data: controller.clubs[count],
                      onTap: () {
                        ref.read(dashboardProvider.notifier).gotoPage(
                            TabItem.clubs, ClubDetailsPage.route,
                            arguments: controller.clubs[count].id);
                      },
                    );
                  },
                  height: 140,
                  arrowIcon: false),
            );
          }

          return const SizedBox.shrink();
        }),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }
}

class _FavClubCard extends StatelessWidget {
  final ClubDataNew data;
  // final String? cityName;
  final void Function()? onTap;
  const _FavClubCard({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            // height: 60,
            width: 300,
            // margin: const EdgeInsets.only(right: 12),
            // color: Colors.white,
            color: HtpTheme.cardBlackColor,
            child: Stack(
              children: [
                Row(
                  children: [
                    data.displayImage != null
                        ? Image.network(
                            data.displayImage!,
                            height: 92,
                            width: 110,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage(
                                'assets/images/placeholders/placeholder_15.png'),
                            height: 92,
                            width: 110,
                            fit: BoxFit.fill,
                          ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            // softWrap: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/svg/bottom_nav/location_f.svg"),
                              // Expanded(
                              //   child:
                              Text(
                                // data.distance == null
                                //     ? " ${data.cityName.name} | 7.21 Km" :
                                data.cityName ?? ' ',

                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                                softWrap: true,
                                maxLines: 2,
                              ),
                              // ),
                              if (data.distance != null)
                                Text("| ${data.distance} Km"),
                            ],
                          ),
                          SizedBox(
                            width: 44,
                            child: RatingBox(
                              whiteText: true,
                              value: "${data.rating ?? 0}",
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (data.featured ?? false)
                  Positioned(
                    // right: 0,
                    child: Container(
                      height: 24,
                      width: 73,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/featured-label.png'),
                              fit: BoxFit.fill)),
                      child: const Center(
                          child: Text(
                        "Featured",
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(0xff735c09),
                            fontWeight: FontWeight.w800),
                      )),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

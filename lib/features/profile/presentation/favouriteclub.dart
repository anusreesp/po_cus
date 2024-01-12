import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/widgets_common/horizontal_scroll_with_controller.dart';
import 'package:htp_customer/features/clubs/data/services/club_services.dart';
// import 'package:htp_customer/features/clubs/presentation/pages/club_details_old.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/profile/controller/fav_club_list.dart';
import '../../../common/widgets_common/goldborder_button.dart';
import '../../../htp_theme.dart';
import '../../clubs/controllers/club_list_controller.dart';
import '../../clubs/data/models/club_list_api_response.dart';
import '../../clubs/data/models/fire_club_details.dart';
import '../../clubs/presentation/pages/new/club_details_page.dart';
import '../../clubs/presentation/widgets/rating_box.dart';
import '../../dashboard/presentation/widgets/custom_app_bar.dart';

class FavouriteClub extends StatelessWidget {
  static const route = '/favourite';
  const FavouriteClub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          // height: 10,
          child: Text(
            'My Favourite Clubs',
            style: HtpTheme.newTitleTextStyle,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.bottomLeft,
                  opacity: 0.3,
                  image: AssetImage(
                    "assets/images/mask_group.png",
                  ))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const SizedBox(
                  //   // height: 144,
                  //   width: double.infinity,
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //   ),
                  // ),
                  // Row(
                  //   children: const [
                  //     Text(
                  //       "My Favourite Clubs",
                  //       style: TextStyle(
                  //           fontFamily: "Montserrat",
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //
                  //     // const Spacer(),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 28,
                  // ),

                  Consumer(builder: (context, ref, _) {
                    final controller = ref.watch(favClubListProvider);

                    return controller.when(
                        data: (List<ClubDataModel> data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (data.isEmpty) const _FavClubPlaceholder(),
                              // Text('Your favorite club list is looking a little empty. Time to explore and find your new go-to spot for unforgettable night outs !',
                              // style: Theme.of(context).textTheme.headline4,
                              //   textAlign: TextAlign.center,
                              // ),

                              ...data.map((club) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, ClubDetailsPage.route,
                                              arguments: club.id);
                                        },
                                        child: UpcomingEvents(
                                          id: club.id,
                                          imageName: club.displayImage,
                                          eventTitle: club.name,
                                          // date: "01 Mar 2023",
                                          place: club.cityName, space: 16,
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(left: 12),
                                        color: const Color.fromARGB(
                                            255, 224, 224, 224),
                                        height: .15,
                                        width: 300,
                                      ),
                                    ],
                                  ))
                            ],
                          );
                        },
                        error: (e, _) => Text(e.toString()),
                        loading: () => const CircularProgressIndicator(color: HtpTheme.goldenColor),);
                  }),

                  const SizedBox(
                    height: 100,
                  )

                  // UpcomingEvents(
                  //   imageName: "party-crowd.jpg",
                  //   eventTitle: "Ice-bar",
                  //   // date: "01 Mar 2023",
                  //   place: "Bangalore", space: 16,
                  // ),
                  // Container(
                  //   // padding: EdgeInsets.only(left: 12),
                  //   color: const Color.fromARGB(255, 224, 224, 224),
                  //   height: .15,
                  //   width: 300,
                  // ),
                  // UpcomingEvents(
                  //     imageName: "party-nopath.jpg",
                  //     eventTitle: "Sanctum club",
                  //     // date: "18 Mar 2023",
                  //     place: "Bali")
                ],
              ),
            ),
          ),
        ));
  }
}

class UpcomingEvents extends StatefulWidget {
  final String? imageName;
  final String eventTitle;
  final String id;
  // final String date;
  final String place;
  double? space;

  UpcomingEvents(
      {super.key,
      required this.imageName,
      required this.id,
      required this.eventTitle,
      // required this.date,
      required this.place,
      this.space});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  bool heart = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: widget.imageName != null
                ? Image(
                    fit: BoxFit.cover,
                    height: 70,
                    width: 90,
                    image: NetworkImage(
                      widget.imageName!,
                    ),
                  )
                : const SizedBox(
                    height: 70,
                    width: 90,
                  ),
          ),
          // SizedBox(
          //   height: 12,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: 100,
                      child: Text(
                        widget.eventTitle,
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffe8d48a), fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(
                        //   Icons.location_on_sharp,
                        //   size: 17,
                        //   color: HtpTheme.goldenColor,
                        // ),
                        SvgPicture.asset(
                          'assets/svg/bottom_nav/location_f.svg',
                          height: 18,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.place,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            // fontFamily: "OpenSans",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // widget.space != null
          //     ? SizedBox(
          //         width: widget.space,
          //       )
          //     : const SizedBox(),

          Consumer(builder: (context, ref, _) {
            return MaterialButton(
              onPressed: () async {
                // setState(() {
                //   heart = !heart;
                // });

                await ref.read(clubServiceProvider).deleteFav(widget.id);
                ref.invalidate(favClubListProvider);
              },
              child: heart == true
                  ? const Image(
                      image:
                          AssetImage("assets/images/icons/awesome-heart.png"),
                      height: 18,
                    )
                  : const Image(
                      image: AssetImage("assets/images/icons/heart.png"),
                      height: 18,
                    ),
            );
          })
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
            'You have not added any club to your favorites. Add now !',
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

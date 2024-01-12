import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/locations/controllers/location_list_controller.dart';
import 'package:htp_customer/features/locations/data/models/location_list_response.dart';
import 'package:htp_customer/features/locations/data/services/location_service.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../dashboard/presentation/widgets/custom_app_bar.dart';
import '../../dashboard/presentation/widgets/profile_icon.dart';
import '../../dashboard/presentation/widgets/search_box.dart';

class LocationPage extends ConsumerWidget {
  static const route = '/locations';
  const LocationPage({super.key});

  // final List images = [
  //   "group1.jpg",
  //   "group2.jpg",
  //   "group3.jpg",
  //   "group4.jpg",
  //   "group5.jpg",
  //   "group6.jpg",
  //   "group7.jpg"
  // ];

  // final List locationName = [
  //   "Bali",
  //   "Dubai",
  //   "Las Vegas",
  //   "Amsterdam",
  //   "Miami",
  //   "Bangkok",
  //   "Rio De Janeiro"
  // ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildBody();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            expandedHeight: 160,
            excludeHeaderSemantics: true,
            titleTextStyle: const TextStyle(fontSize: 14),
            // title: const Image(
            //   image: AssetImage('assets/images/logos/htp_logo_gold.png'),
            //   height: 50,
            //   // width: 100,
            // ),
            leading: const DrawerIcon(),
            leadingWidth: 50,
            // actions: const [
            //   Padding(
            //     padding: EdgeInsets.only(right: 12.0),
            //     child: ProfileIcon(),
            //   )
            // ],
            flexibleSpace: const FlexibleSpaceBar(
              background: SizedBox(
                height: 200,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
                    child: SearchBox(),
                  ),
                ),
              ),
            )),
        SliverList(
            delegate: SliverChildListDelegate([
          _buildBody(),
        ]))
      ],
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   extendBody: true,
    //   appBar: const CustomAppBar(
    //     hideDrawerButton: false,
    //   ),
    //   body: _buildBody(),
    // );
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackButton(),
        title: Text("Popular Party Destinations"),
      ),
      // appBar: CustomAppBar(
      //   child: Text(
      //     "Popular Party Destinations",
      //     style: HtpTheme.newTitleTextStyle,
      //     // style: TextStyle(
      //     //   fontFamily: "Allrox",
      //     //   color: Colors.white,
      //     //   fontSize: 18,
      //     // fontWeight: FontWeight.w500
      //     // ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 12.0, bottom: 12),
              //   child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "Popular Party Locations",
              //         style: HtpTheme.newTitleTextStyle,
              //         // style: TextStyle(
              //         //   fontFamily: "Allrox",
              //         //   color: Colors.white,
              //         //   fontSize: 18,
              //         // fontWeight: FontWeight.w500
              //         // ),
              //       )),
              // ),
              // Column(
              //   children: [
              //     Row(
              //       children: [],
              //     )
              //   ],
              // ),

              Consumer(builder: (context, ref, _) {
                final controller = ref.watch(locationListProvider);

                if (controller is LocationListLoading) {
                  return const Center(
                    child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
                  );
                }

                if (controller is LocationListError) {
                  return Text(controller.message);
                }

                if (controller is LocationListLoaded) {
                  return GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.only(left: 4, top: 12, bottom: 16),
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.75,
                    children: [
                      ...controller.location
                          .map((data) => locationGrid(data, context, ref))
                    ],
                  );
                }

                return const SizedBox.shrink();
                // return FutureBuilder(
                //     // future: ref.read(locationServiceProvider.future),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done &&
                //           snapshot.hasData) {
                //         return GridView.count(
                //           padding: const EdgeInsets.only(
                //               left: 4, top: 12, bottom: 16),
                //           shrinkWrap: true,
                //           // physics: const NeverScrollableScrollPhysics(),
                //           crossAxisCount: 2,
                //           mainAxisSpacing: 8,
                //           crossAxisSpacing: 8,
                //           childAspectRatio: 1.75,
                //           children: [
                //             ...snapshot.data!
                //                 .map((data) => locationGrid(data, context, ref))
                //           ],
                //         );
                //       }
                //       if (snapshot.hasError) {
                //         return Text(snapshot.error.toString());
                //       }
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return const SizedBox.shrink();
                //     });
              }),

              /*
                    ...List.generate(7, (index) {
                      return GestureDetector(
                        onTap: (() {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LocationClubsPage()));
                        }),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image(
                                image: AssetImage(
                                    "assets/images/temp/location/${images[index]}"),
                                // height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 0, 0, 25),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  locationName[index],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                    */
              //   ],
              // ),

              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationGrid(LocationData data, BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() {
        ref
            .read(userLocationProvider.notifier)
            .selectManualLocation(data.name, data.id, data.countryName);
        ref.read(dashboardProvider.notifier).selectTabHome(TabItem.clubs);

        // ref.read(dashboardProvider.notifier).selectTabHome(TabItem.events);

        Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const ClubNotFoundExceptions()));
      }),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: data.cityImage == null
                ? const SizedBox(
                    width: 180,
                    height: 120,
                    child: Image(
                      image: AssetImage(
                          "assets/images/placeholders/placeholder_15.png"),
                      // height: 100,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    // width: 180,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(data.cityImage!),
                          // colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                          fit: BoxFit.cover),
                    ),
                    // child: Image.network(data.profileImage!, fit: BoxFit.fill,)
                  ),
          ),
          Container(
            color: Colors.black38,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter,
            //
            //     colors: [
            //       Colors.black26,
            //       Colors.black87
            //     ]
            //   )
            // ),
            height: 42,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  // locationName[index],
                  data.name.toTitleCase(),
                  // style: mont16w600,
                  style: man16White,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/controllers/club_list_controller.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/club_card.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/club_filter.dart';
// import '../../clubs/presentation/pages/club_details_old.dart';
import '../../../htp_theme.dart';
import '../../clubs/presentation/widgets/club_card.dart';
import '../../clubs/presentation/widgets/new/club_filter.dart';
import '../../dashboard/presentation/widgets/custom_app_bar.dart';
import '../../dashboard/presentation/widgets/search_box.dart';

class LocationClubsPage extends ConsumerWidget {
  const LocationClubsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(clubListProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 18),
                    child: SearchBox(),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Clubs on Bali",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Spacer(),
                  const ClubsFilter()
                ],
              ),

              if (controller is ClubLoaded)
                ...controller.clubs.map((data) => NewClubCard(
                      data: data,
                      onTap: () {
                        Navigator.pushNamed(context, ClubDetailsPage.route);
                      },
                    )),

              if (controller is ClubsLoading) const  CircularProgressIndicator(color: HtpTheme.goldenColor),

              if (controller is ClubError)
                Text(
                  controller.msg,
                  style: const TextStyle(color: Colors.red),
                ),

              // ...List.generate(
              //     4,
              //     (index) => ClubCard(
              //           data: SampleData().sampleClub2[index],
              //           onTap: () {
              //             Navigator.pushNamed(context, ClubDetails.route);
              //           },
              //         )),

              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}

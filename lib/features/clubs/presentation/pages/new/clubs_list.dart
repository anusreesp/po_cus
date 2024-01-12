import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/clubs/controllers/new/clubs_filterlist_controller.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/custom_app_bar.dart';
import '../../../../../exception_handling/club_exceptions.dart';
import '../../../../../htp_theme.dart';
import '../../../controllers/club_list_controller.dart';
import '../../../data/models/club_list_api_response.dart';
import '../../widgets/new/club_card.dart';
import '../../widgets/new/club_filter.dart';

class ClubsList extends ConsumerWidget {
  final GlobalKey<ScaffoldState>? dashBoardScaffoldKey;
  const ClubsList({super.key, required this.dashBoardScaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(clubListProvider);
    final clubsFilteredController = ref.watch(clubsFilterListProvider);

    return Scaffold(
      // drawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchTitle(
          titleWidget: const Text('CLUBS'),
          dashboardScaffoldKey: dashBoardScaffoldKey,
        ),
      ),
      body: buildBody(context, controller, clubsFilteredController),
    );
  }

  Widget buildBody(BuildContext context, ClubListStates controller,
      List<ClubDataNew> clubs) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Row(
                children: [Spacer(), ClubsFilter()],
              ),
              if (controller is ClubLoaded && controller.clubs.isNotEmpty)
                ...clubs.map((data) => NewClubCard(
                      data: data,
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ClubDetails(data: data)));
                        FirebaseAnalytics.instance.logSelectItem(itemListId: data.id, itemListName: data.name);
                        Navigator.pushNamed(context, ClubDetailsPage.route,
                            arguments: data.id);
                      },
                    )),
              if (controller is ClubLoaded && controller.clubs.isEmpty)
                const ClubNotFoundExceptions(),
              if (controller is ClubsLoading) const CircularProgressIndicator(color: HtpTheme.goldenColor),
              if (controller is ClubError) const ClubTryAgainExceptions(),
              const SizedBox(
                height: 130,
              )
            ],
          )),
    );
  }
}

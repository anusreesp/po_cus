import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';

class HorizontalUpcomingEvents extends ConsumerWidget {
  final String? imageName;
  final String? logo;
  final String eventTitle;
  final DateTime date;
  final String? description;
  const HorizontalUpcomingEvents(
      {required this.imageName,
      required this.logo,
      required this.eventTitle,
      required this.date,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 8,
      ),
      child: eventsList(context),
    ));
  }

  Widget eventsList(BuildContext context) {
    int difDays, difWeek, difMonth, difYear;

    // remainDays() {
    final today = DateTime.now();
    final from = DateTime(today.year, today.month, today.day);
    final to = DateTime(date.year, date.month, date.day);

    difDays = (to.difference(from).inHours / 24).round();
    difWeek = difDays ~/ 7;
    difMonth = difDays ~/ 30;
    difYear = (difDays / 365).toInt();
    TextStyle durationStyle =
        man14LightBlue.merge(const TextStyle(fontWeight: FontWeight.w600));

    // }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: HtpTheme.darkBlue2Color,
      ),
      // height: MediaQuery.of(context).size.height * 0.3,
      width: 240,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 240,
            child: Stack(
              children: [
                imageName != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            topLeft: Radius.circular(6)),
                        child: Image(
                            fit: BoxFit.cover,
                            width: 240,
                            height: 200,
                            image: NetworkImage(imageName!)),
                      )
                    : const ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            topLeft: Radius.circular(6)),
                        child: Image(
                          image: AssetImage(
                              'assets/images/placeholders/placeholder_15.png'),
                          height: 200,
                          fit: BoxFit.fill,
                        )),
                // logo == null
                //     ? const SizedBox()
                //     : Positioned(
                //         bottom: 10,
                //         left: 15,
                //         child: CircleAvatar(
                //             radius: 29,
                //             //-------------------------------------Change here--------------------------------------
                //             backgroundImage:
                //                 const AssetImage('assets/images/logoBg.png'),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(40),
                //               child: Image(
                //                 image: NetworkImage("${logo}"),
                //                 // AssetImage(
                //                 //     'assets/images/temp/profile.png'),
                //                 height: 55,
                //                 width: 55,
                //                 fit: BoxFit.cover,
                //               ),
                //             ))),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //-----------------Name

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              eventTitle.toTitleCase() ?? 'Name',
              overflow: TextOverflow.ellipsis,
              style: tenor16Gold,
            ),
          ),

          //-----------------Description

          Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
              child: Text(
                description ?? "Description right here...",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: man14LightBlue,
              )),

          //----------------- days to go

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                (difDays >= 7)
                    ? (difWeek >= 4)
                        ? (difMonth >= 12)
                            ? (difYear == 1)
                                ? Text(" 1 Year ", style: durationStyle)
                                : Text("$difYear Years ", style: durationStyle)
                            : (difMonth == 1)
                                ? Text("1 Month ", style: durationStyle)
                                : Text("$difMonth Months ",
                                    style: durationStyle)
                        : (difWeek == 1)
                            ? Text("1 Week ", style: durationStyle)
                            : Text("$difWeek Weeks ", style: durationStyle)
                    : difDays == 0
                        ? Text("Today", style: durationStyle)
                        : difDays == 1
                            ? Text("1 Day ", style: durationStyle)
                            : Text("$difDays Days ", style: durationStyle),
                if (difDays != 0) Text("to go", style: durationStyle),
                const Spacer(),
                SvgPicture.asset("assets/svg/icons/arrow/arrow.svg"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

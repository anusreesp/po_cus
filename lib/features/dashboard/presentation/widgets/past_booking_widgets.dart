import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/profile/controller/booking_list_controller.dart';
import 'package:htp_customer/features/profile/data/models/booking_details.dart';
import 'package:htp_customer/features/profile/presentation/screens/my_bookings_screen.dart';
import 'package:intl/intl.dart';

import '../../../../htp_theme.dart';
import '../../../booking/presentation/pages/confirmation/entry_confirmation.dart';
import '../../spacing_values.dart';
import 'home_page_components.dart';

class Bookings extends ConsumerWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(bookingListProvider);

    if (controller is BookingListLoaded &&
        controller.activeBookings.isNotEmpty) {
      final activeBookings = controller.activeBookings;
      return Column(
        children: [
          HorizontalTextButton(
            title: 'Upcoming Bookings',
            ctaText: 'View all',
            padding: const EdgeInsets.fromLTRB(leftDashboardPadding, 12, 8, 12),
            onTap: () {
              Navigator.pushNamed(context, MyBookingsScreen.route);
            },
          ),
          SizedBox(
            height: 68,
            child: ListView.builder(
                itemCount: activeBookings.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _bookingCard(activeBookings[index], context);
                }),
          ),
          const SizedBox(
            height: 34,
          )
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _bookingCard(BookingData data, BuildContext context) {
    final displayImage = data.clubImage ?? data.eventImage;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EntryConfirmation(
                    id: data.id, bookingType: data.bookingType)));
      },
      child: Container(
        height: 68,
        width: 280,
        color: HtpTheme.darkGrey4Color,
        margin: const EdgeInsets.only(left: leftDashboardPadding, right: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            displayImage == null
                ? const Image(
                    fit: BoxFit.fill,
                    height: 68,
                    width: 68,
                    image: AssetImage(
                        'assets/images/placeholders/placeholder_15.png'),
                  )
                : Image.network(
                    displayImage,
                    height: 68,
                    width: 68,
                    fit: BoxFit.fill,
                  ),

            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data.bookingType == 'event_entry_booking' ? data.eventName : data.clubName}",
                    overflow: TextOverflow.ellipsis,
                    style: man14LightBlue,
                  ),
                  // const SizedBox(height: 6,),
                  Text(
                    DateFormat('dd MMMM, yyyy').format(data.bookingDateOnly),
                    style: man14White,
                  )
                ],
              ),
            ),
            // const Spacer(),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              'assets/svg/arrow_splashscreen.svg',
              width: 26,
              color: Colors.white,
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
      ),
    );
  }
}

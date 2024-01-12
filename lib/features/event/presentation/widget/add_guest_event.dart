import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/htp_theme.dart';
import '../../../../common/widgets_common/add_people_form_new.dart';
import '../../../../common/widgets_common/info_box.dart';
import '../../../booking/controllers/selection/guests_controller.dart';
import '../../../booking/data/models/guest_model.dart';
import '../../../booking/presentation/pages/confirmation/entry_confirmation.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../data/models/event_model.dart';

class AddGuestsEvent extends ConsumerWidget {
  final EventModel data;
  AddGuestsEvent({required this.data, super.key});

  // final GlobalKey<AddingPeopleNewState> _key = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final guestController = ref.watch(guestAddProviderEvent);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      margin: const EdgeInsets.only(top: 8),
      // decoration: BoxDecoration(
      //     color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // _infoBox(), //Display title to add guest
          const InfoBox(
            text1: "Bringing Friends?",
            /* text2: "Add upto 3 persons as per membership benefits", */ showGuestInfo:
                true,
          ),

          GuestCounts(),

          const SizedBox(
            height: 12,
          ),

          Consumer(builder: (context, ref, _) {
            final editList = ref.watch(guestEditProvider);
            return AddingPeopleNew(
              // key: _guestListKye,
              editGuestList: editList,
              onAddGuestClick: () {
                ref.read(guestEditProvider.notifier).addGuest();
              },
              onDeleteItem: ref.read(guestEditProvider.notifier).removeGuest,
              formKey: ref.read(guestEditProvider.notifier).formKey,
            );
          }),

          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

class GuestCounts extends ConsumerWidget {
  const GuestCounts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);

    if (profileController is ProfileLoaded) {
      final membershipName = profileController.activeMembershipData;

      final guestCount =
          membershipName?.membershipCalculations?.complimentaryGuests;
      return Container(
        child: guestCount == 0
            ? SizedBox()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: SvgPicture.asset(
                      "assets/svg/icons/others/info.svg",
                      width: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      "Add up to $guestCount complimentary guests, as per your membership benefits",
                      maxLines: 2,
                      style: man12White,
                    ),
                  ),
                ],
              ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

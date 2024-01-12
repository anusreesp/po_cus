import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/controllers/booking_selection_controller.dart';
import 'package:htp_customer/features/booking/controllers/selection/smoke_controller.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/drinks/drink_detail_box.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/guest_table.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/smoke/smoke_detail_box.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/smoke/smoke_selection.dart';
import 'package:htp_customer/features/booking/presentation/widgets/buttons/nextback_button.dart';

import '../../../../../../htp_theme.dart';
import '../../../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../../clubs/data/models/products_model.dart';
import '../../../widgets/buttons/options_widget.dart';

class AddSmokes extends ConsumerWidget {
  final List<ProductModel> smokes;
  const AddSmokes({super.key, required this.smokes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smokeAddedController = ref.watch(smokeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
          // horizontal: 18,
          vertical: 18),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          if (smokeAddedController.isEmpty) _infoText(),
          if (smokeAddedController.isNotEmpty)
            for (int i = 0; i < smokeAddedController.length; i++)
              DrinkSmokeBox(
                type: smokeAddedController[i].type,
                brand: smokeAddedController[i].brand,
                count: i + 1,
                onDeleteClick: () {
                  ref
                      .read(smokeProvider.notifier)
                      .removeSmoke(smokeAddedController[i].tempId);
                },
                isSmoke: true,
              ),
          SmokeSelectionButton(
            smokes: smokes,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    ref.read(selectionProvider.notifier).state =
                        SelectionType.drinks;
                  },
                  child: const Text('BACK')),
              const SizedBox(
                width: 24,
              ),
              SizedBox(
                  width: 160,
                  height: 44,
                  child: RoundedGoldenButton(
                      onTap: () {
                        ref.read(selectionProvider.notifier).state =
                            SelectionType.guest;
                      },
                      text: 'Next'))
            ],
          )
        ],
      ),
    );
  }

  Widget _infoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Preferred Smoke",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Icon(
              Icons.info,
              size: 14,
              color: Colors.grey.shade500.withOpacity(0.5),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              "Add upto any number of smoke.",
              softWrap: true,
              style: TextStyle(
                  fontSize: 12, color: Colors.grey.shade500.withOpacity(0.6)),
            ),
          ],
        ),
      ],
    );
  }
}

class SmokeSelectionButton extends ConsumerWidget {
  final List<ProductModel> smokes;
  const SmokeSelectionButton({super.key, required this.smokes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showForm = ref.watch(showSmokeFormProvider);
    final addedSmokes = ref.watch(smokeProvider);

    if (!showForm && addedSmokes.isNotEmpty) {
      return AddMoreSmoke(
        smokes: smokes,
      );
    }
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 18, bottom: 12),
        decoration: BoxDecoration(
            // color: Colors.white,
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Smoke ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          OptionWidget(
              hint: 'Select type of smoke',
              onclick: () => showDialog(
                    context: context,
                    builder: (context) => SelectSmokeType(
                      smokes: smokes,
                    ),
                  )),
          const SizedBox(
            height: 12,
          )
          // OptionWidget(
          //     hint: "Select a flavor",
          //     onclick: () {
          //       showDialog(
          //           context: context,
          //           // builder: (context) => SelectSmokeFlavor(),
          //         builder: (context) => SelectSmokeType(smokes: smokes,),
          //       );
          //     }),
        ]));
  }
}

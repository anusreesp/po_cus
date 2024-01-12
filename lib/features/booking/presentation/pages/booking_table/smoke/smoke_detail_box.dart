import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/booking/presentation/pages/booking_table/smoke/smoke_table.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../../../../clubs/data/models/products_model.dart';
import '../../../../controllers/selection/smoke_controller.dart';

class SmokeDetailBox extends StatelessWidget {
  final String type;
  final String brand;
  const SmokeDetailBox({super.key, required this.type, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24),
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "     Smoke ",
            style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                // color: Colors.white
                color: HtpTheme.cardBlackColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: HtpTheme.cardBlackColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        brand,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text("Edit",
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline)),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 175, 175, 175),
                        size: 22,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddMoreSmoke extends ConsumerWidget {
  final List<ProductModel> smokes;
  const AddMoreSmoke({super.key, required this.smokes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAddSmoke = ref.watch(showSmokeFormProvider);
    return showAddSmoke
        ? SmokeSelectionButton(smokes: smokes,)
        : GestureDetector(
          onTap: () {
            // ref.read(submitGuestsProvider.notifier).state = AddNew.no;
            ref.read(showSmokeFormProvider.notifier).state = true;
          },
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/icons/booking/other_icons/add_smoke.svg",
                      height: 25,
                      color: Colors.white,
                    ),
                    Text(
                      "   + ADD ANOTHER SMOKE",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                )),
          ),
        );
  }
}

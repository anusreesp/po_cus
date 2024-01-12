import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/features/booking/controllers/selection/drinks_controller.dart';


class DrinkSmokeBox extends StatelessWidget {
  final String type;
  final String brand;
  final int count;
  final VoidCallback onDeleteClick;
  final bool isSmoke;
  const DrinkSmokeBox({super.key, required this.type, required this.brand, required this.count, required this.onDeleteClick, this.isSmoke = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(right: 24),
      margin: const EdgeInsets.only(bottom: 12),
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "     ${isSmoke ? "Smoke" : "Drink"} $count",
            style: const TextStyle(
                // fontFamily: "Open Sans",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Colors.white.withOpacity(0.08),
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
                        type.toTitleCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        brand.toTitleCase(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: const Text("Edit",
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           decoration: TextDecoration.underline)),
                  // ),
                  IconButton(
                      onPressed: onDeleteClick,
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 175, 175, 175),
                        size: 20,
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

class AddMoreDrinks extends ConsumerWidget {
  const AddMoreDrinks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // ref.read(submitGuestsProvider.notifier).state = AddNew.no;
        ref.read(showAddDrinkForm.notifier).state = true;
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
                  "assets/svg/icons/booking/other_icons/add_drink.svg",
                  height: 25,
                  color: Colors.white,
                ),
                Text(
                  "   + ADD ANOTHER DRINK",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                )
              ],
            )),
      ),
    );
  }
}

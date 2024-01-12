import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/booking/controllers/selection/guests_controller.dart';
import 'package:htp_customer/htp_theme.dart';

class GuestDetailBoxWidget extends ConsumerWidget {
  final String name;
  final String age;
  final int count;
  // final String id;
  final VoidCallback deleteClick;
  const GuestDetailBoxWidget(
      {super.key,
      required this.name,
      required this.age,
      required this.count,
      required this.deleteClick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // padding: EdgeInsets.only(right: 24),
      margin: const EdgeInsets.only(bottom: 12),
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "     Guest $count",
            style: const TextStyle(
                fontFamily: "Open Sans",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const SizedBox(
            height: 8,
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
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        age,
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
                      onPressed: deleteClick,
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

class AddMoreGuestsWidget extends ConsumerWidget {
  final VoidCallback onTap;
  const AddMoreGuestsWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        decoration: const BoxDecoration(
          color: HtpTheme.darkBlue2Color,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/icons/booking/new/guest_gold.svg",
                  height: 24,
                  color: HtpTheme.goldColor,
                ),
                const Text(
                  "     Add more",
                  style: man14White,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: onTap,
                      child:
                          //  Image.asset(
                          //   "assets/images/icons/add-more.png",
                          //   width: 24,
                          //   height: 24,
                          // )
                          SvgPicture.asset(
                              'assets/svg/icons/booking/new/plus_icon.svg')),
                )
              ],
            )),
      ),
    );
  }
}

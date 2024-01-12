import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../htp_theme.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  bool rating = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black,

          // color: HtpTheme.light().scaffoldBackgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.2),
        ),
        height: 220.0,
        width: 620.0,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    debugPrint("----------------------------");
                    // Navigator.pushNamed(context, RequestPlan.route);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "How's The Party?",
                    style: TextStyle(fontSize: 21, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ...List.generate(
                      5,
                      (index) => rating == true
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  rating = false;
                                });
                              },
                              icon: const Icon(
                                Icons.star_rate_rounded,
                                size: 30,
                                color: Color.fromARGB(255, 196, 174, 94),
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  rating = true;
                                });
                              },
                              icon: SvgPicture.asset(
                                  "assets/svg/icons/star/rating-star.svg")
                              //  const Image(
                              //   image:
                              //       AssetImage('assets/images/icons/star.png'),
                              //   height: 28,
                              //   width: 28,
                              // ),
                              ),
                    ),
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                      child: Ink(
                        width: 115,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: HtpTheme.goldenColor)),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "SUBMIT",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

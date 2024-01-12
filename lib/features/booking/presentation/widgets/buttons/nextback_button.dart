import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';

class NextBackButtons extends StatelessWidget {
  final Function onTap;
  final bool isInsideBox;
  const NextBackButtons(
      {super.key, required this.onTap, required this.isInsideBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // TextButton(
          //   onPressed: () {},
          //   child: Text(
          //     "< BACK",
          //     style: TextStyle(
          //         color: isInsideBox == true ? Colors.black : Colors.white,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600),
          //   ),
          // ),
          const SizedBox(
            width: 24,
          ),
          Consumer(
            builder: (context, ref, child) {
              return Container(
                  width: 150,
                  height: 45,
                  child: RoundedGoldenButton(
                      onTap: () {
                        // ref.read(submitGuestsProvider.notifier).state =
                        //     AddNew.yes;
                        onTap();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ConfirmTicket()));
                      },
                      text: "Next"));
            },
          )
        ],
      ),
    );
  }
}

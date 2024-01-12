import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class CancelDialog {
  static cancelBookingDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          // color: HtpTheme.light().scaffoldBackgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.6)
        ),
        height: 220.0,
        width: 620.0,
        // child: Padding(
        //   padding: const EdgeInsets.all(45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Cancel Booking ? ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),

            //----------------------------------------------------
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            //   child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, RequestPlan.route);
                    Navigator.of(context).pop();
                  },
                  child: Ink(
                    // width: double.maxFinite,
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 250, 241, 160),
                            Colors.yellow
                          ],
                        )),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "GO BACK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // color: HtpTheme.light().scaffoldBackgroundColor,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: 70,
                  height: 30,
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return greetDialog(context, context);
                        });
                  },
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.yellow, width: 0.6),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    "CANCEL BOOKING",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            // )
          ],
        ),
        // ),
      ),
    );
  }

  static greetDialog(BuildContext cxt, BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          // color: HtpTheme.light().scaffoldBackgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.6)
        ),
        height: 200,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.pushNamed(context, RequestPlan.route);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ),
            SizedBox(
              height: 14,
            ),
            const Text(
              "Hope to see you  ",
              style: TextStyle(
                  color: Color.fromARGB(255, 192, 192, 192),
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
            const Text(
              " next time ! ",
              style: TextStyle(
                  color: Color.fromARGB(255, 192, 192, 192),
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

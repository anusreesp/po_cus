import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../htp_theme.dart';
import '../../../data/models/booking_details.dart';

class ConfirmationSteps extends StatelessWidget {
  final String? confirmationStatus;
  final BookingResponseData snapData;
  const ConfirmationSteps(
      {super.key, required this.confirmationStatus, required this.snapData});

  @override
  Widget build(BuildContext context) {
    return confirmationStatus == "Approved" || confirmationStatus == "Completed"
        ? SizedBox(
            child:
                QRcode(data: snapData, confirmationStatus: confirmationStatus),
          )
        : (confirmationStatus == "Waiting for payment verification" ||
                confirmationStatus == "Waiting for approval")
            ? SizedBox(
                // height: MediaQuery.of(context).size.height * 0.14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    paymentVerification(),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          progressContent("Payment verification",
                              "Verification in progress"),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Booking confirmed",
                            style: man14DarkGrey2,
                          ),
                        ]),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 8),
                      child: SvgPicture.asset(
                          "assets/svg/icons/others/sandclock.svg"),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 1,
                              height: 105,
                              color: HtpTheme.lightGreyColor,
                            ),
                            Positioned(
                                top: 0, child: smallSquare(HtpTheme.goldColor)),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: smallSquare(HtpTheme.lightBlueColor),
                            ),
                            Positioned(
                                bottom: 0,
                                child: smallSquare(HtpTheme.lightBlueColor)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    //--------------------Title and content--------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        progressContent("Booking requested",
                            "Our concierge will contact you shortly"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Payment verification",
                          style: man14DarkGrey2,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Booking confirmed",
                          style: man14DarkGrey2,
                        )
                      ],
                    ),

                    // SizedBox(
                    //   width: 12,
                    // ),
                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 8),
                      child: SvgPicture.asset(
                          "assets/svg/icons/others/sandclock.svg"),
                    )
                  ],
                ),
              );
  }

  Widget smallSquare(Color color) {
    return Container(
      color: color,
      width: 5.5,
      height: 5.5,
    );
  }

  Widget progressContent(String title, String content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: man16White,
        ),
        Text(
          content,
          style: man12LightBlue,
        )
      ],
    );
  }

  Widget paymentVerification() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 1,
              height: 65,
              color: HtpTheme.lightGreyColor,
            ),
            smallSquare(HtpTheme.goldColor),
            Positioned(bottom: 0, child: smallSquare(HtpTheme.lightGreyColor)),
          ],
        ),
      ],
    );
  }
}

class QRcode extends StatelessWidget {
  final BookingResponseData data;
  final String? confirmationStatus;
  const QRcode(
      {super.key, required this.data, required this.confirmationStatus});

  Uint8List convertBase64Image(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.23,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              confirmationStatus != 'Completed'
                  ? const Text(
                      "Booking confirmed",
                      style: man16White,
                    )
                  : const Text(
                      "Booking completed",
                      style: man16White,
                    ),
              Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/others/greentick.svg",
                width: 22,
              ),
              SizedBox(
                width: confirmationStatus != 'Completed' ? 1 : 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Booking ID",
                    style: man14LightBlue,
                  ),
                  Text("${data.data.bookingId}", style: man16White),
                  if (confirmationStatus != 'Completed')
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SvgPicture.asset(
                              "assets/svg/icons/others/info.svg",
                              width: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: const Text(
                              "Show the QR code before Entry",
                              style: man12LightBlue,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
              const Spacer(),

              //------------------------------------- QR----------------------------------------
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                if (confirmationStatus != 'Completed')
                  data.qrCode != null
                      ? Image.memory(
                          convertBase64Image(data.qrCode!),
                          height: 120,
                        )
                      : const SizedBox(),

                // SvgPicture.asset(
                //   "assets/svg/images/qrcode.svg",
                //   height: 120,
                // ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htp_customer/exception_handling/exception_ui.dart';

class SomethingWrong extends StatelessWidget {
  final bool goBack;
  const SomethingWrong({super.key, this.goBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ExceptionUi(
      data:
          "Ooops! Looks like you took a wrong turn. We couldn't find the party you were looking for",
      path: "assets/svg/images/exception/clubs.svg",
      onTap: () {
        if (goBack) {
          Navigator.pop(context);
        }
      },
      buttonText: "Go back",
    ));
  }
}

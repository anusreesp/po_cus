import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../htp_theme.dart';

class DateTextField extends StatelessWidget {
  DateTextField({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          hintText: "DD/MM/YYYY",
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: HtpTheme.goldenColor)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: HtpTheme.goldenColor)),
          disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: HtpTheme.goldenColor)),
          // enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: HtpTheme.goldenColor)),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: HtpTheme.goldenColor,
            ),
            onPressed: () async {
              final dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)));
              if (dateTime != null) {
                _controller.text = DateFormat('dd MMMM yyyy').format(dateTime);
              }
            },
          )),
    );
  }
}

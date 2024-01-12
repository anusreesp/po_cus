import 'dart:async';

import 'package:flutter/material.dart';
import 'package:htp_customer/htp_theme.dart';

class TimeIndicator extends StatefulWidget {
  final VoidCallback onTimerCompleted;
  const TimeIndicator({super.key, required this.onTimerCompleted});

  @override
  State<TimeIndicator> createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator> {

  late Timer _timer;
  int counter = 60;
  startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter = counter - 1;
        if(counter == 0){
          widget.onTimerCompleted();
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Resend OTP in ', style: man12LightBlueOpac,),
        const SizedBox(width: 2,),
        SizedBox(
            width: 30,
            child: Text('$counter s', style: man14White1,))
      ],
    );
  }
}

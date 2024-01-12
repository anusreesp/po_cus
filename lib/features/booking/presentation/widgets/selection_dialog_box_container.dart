import 'package:flutter/material.dart';

import '../../../../htp_theme.dart';

class SelectionDialogBoxContainer extends StatelessWidget {
  final String titleText;
  final Widget child;
  final double height;
  final double width;
  SelectionDialogBoxContainer({Key? key, required this.titleText, required this.child, this.height = 460, this.width = 400}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // color: Colors.white,
            color: HtpTheme.dark().scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Text(
                    titleText,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.close))
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 350,
                height: height - 75,
                decoration: BoxDecoration(
                  // color: const Color.fromARGB(255, 238, 238, 238),
                    color: HtpTheme.cardBlackColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Scrollbar(
                  thickness: 10,
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: child,
                  ),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
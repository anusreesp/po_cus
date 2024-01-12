import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';

class AddDocument extends StatelessWidget {
  final String title, path;
  final bool isStar;
  final Function onTapFunc;
  final String buttonText;
  final File? imageFile;
  const AddDocument(
      {super.key,
      required this.title,
      required this.isStar,
      required this.path,
      required this.onTapFunc,
        this.buttonText = 'Add',
        this.imageFile
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: HtpTheme.newTitleTextStyle
                  .apply(fontSizeDelta: 1, fontSizeFactor: 0.80),
            ),
            const SizedBox(
              width: 2,
            ),
            isStar == true
                ? const Icon(
                    Icons.star_rate,
                    size: 12,
                    color: Colors.red,
                  )
                : Container()
          ],
        ),

        imageFile == null
            ? SvgPicture.asset(
                path,
                width: 160,
                height: 125,
                fit: BoxFit.cover,
              )
            : SizedBox(
            height: 125,
            width: 160,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(imageFile!, fit: BoxFit.fitWidth,)),
            )),

        addButton(onTapFunc, buttonText)
      ],
    );
  }

  static addButton(onTapFunc, String textValue) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Container(
        // height: 32,
        // width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: HtpTheme.addButtonColor.withOpacity(0.09)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.add_circle,
              color: HtpTheme.yellow1Color,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              textValue,
              style:
                  HtpTheme.detailTitleText.apply(color: HtpTheme.yellow1Color),
            ),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
      ),
    );
  }
}

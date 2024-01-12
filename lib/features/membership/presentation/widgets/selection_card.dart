import 'package:flutter/material.dart';

import '../../../../htp_theme.dart';

class SelectionCard extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final String cardUrl;
  const SelectionCard({super.key, required this.onTap, required this.selected, required this.cardUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 118,
        width: 200,
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(right: 8),
        decoration: selected
            ? BoxDecoration(
            border: Border.all(color: HtpTheme.goldenColor),
            borderRadius: BorderRadius.circular(12))
            : null,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue.shade50.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: NetworkImage(cardUrl), fit: BoxFit.cover)
              ),
            ),

            if(selected)
              const Positioned(
                  right: 4,
                  top: 4,
                  child: Icon(Icons.check_circle, color: HtpTheme.goldenColor, size: 20,))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../htp_theme.dart';
import 'outlined_black_button.dart';

class CameraAccessDeniedPlaceholder extends StatelessWidget {
  const CameraAccessDeniedPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40,),
            const Icon(Icons.error, size: 60, color: HtpTheme.lightBlueColor,),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 22.0),
              child: Text('Camera access denied. Please open your device\'s settings and grant camera access to this app.',
                textAlign: TextAlign.center,
                style: man14White,),
            ),

            OutlinedBlackButton(onTap: (){
              openAppSettings();
            }, text: 'Open system setting',)
            // Row(
            //   children: [
            //     Expanded(child: OutlinedBlackButton(onTap: (){
            //       openAppSettings();
            //     }, text: 'Open setting',)),
            //     const SizedBox(width: 12,),
            //     Expanded(child: RoundedGoldenButton(onTap: (){
            //       Permission.camera.request().then((value) {
            //         loadCamera();
            //       });
            //     }, text: 'Retry'))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

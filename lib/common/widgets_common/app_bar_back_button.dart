import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppbarBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AppbarBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        if(onTap != null){
          onTap!();
        }else{
          Navigator.pop(context);
        }
      },
      icon: SvgPicture.asset(
        "assets/svg/icons/arrow/sidearrow.svg",
        height: 12,
        width: 12,
      ),
    );
  }
}

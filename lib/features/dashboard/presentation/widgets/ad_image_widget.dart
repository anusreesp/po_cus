import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/dashboard/controllers/ad_popup_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:stories_page_view/stories_page_view.dart';


class ImageSnap extends StatelessWidget {
  final StoryController controller;
  final String image;
  final String? name;
  const ImageSnap({
    super.key,
    required this.image,
    required this.controller,
     this.name,
  });

  @override
  Widget build(BuildContext context) {

    return
            Consumer(
              builder: (context,ref,_) {
                return Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                    child:Image.network(alignment: Alignment.center,
                        image,
                        // height: MediaQuery.of(context).size.height - 150,
                        fit: BoxFit.fitWidth,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (frame != null) {
                            controller.play();
                          }
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            controller.pause();
                          }
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                          //   height: MediaQuery.of(context).size.height/1.3,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: const Center(
                          //       child: CircularProgressIndicator(color: HtpTheme.goldenColor),
                          //   ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                );
              }
            );
  }
}
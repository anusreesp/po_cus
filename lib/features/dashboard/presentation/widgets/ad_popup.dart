import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/dashboard/controllers/ad_popup_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/ad_image_widget.dart';
import 'package:htp_customer/features/profile/presentation/widgets/ad_progress_bar.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:stories_page_view/stories_page_view.dart';

import '../../controllers/notifications_controller.dart';
class AdPopup extends ConsumerWidget {
  final List images;
  final List? eventName;
  final List<String> url;
  final List<bool> internalRedirect;
  const AdPopup({
    super.key,
    required this.images,
    required this.url,
    this.eventName,
    required this.internalRedirect,
  });

  Widget getChild(
      int storyPageIndex,
      int snapIndex,
      StoryController controller,
      ) {
    final snap = images;
    return ImageSnap(image: snap[snapIndex], controller: controller,name: eventName?[snapIndex],);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    if (images.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width,
        child: const Center(
            child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
          ),
      );
    }
    return Scaffold(
      body: StoryPageView(
        pageCount: 1,
        outOfRangeCompleted: () {
          Navigator.pop(context);
       },
        durationBuilder: (pageIndex, snapIndex) {
          // if(snapIndex == images.length-1){
          //   return const Duration(seconds: 7);
          // }
          return const Duration(seconds: 5);
        },
        snapCountBuilder: (pageIndex) {
          return images.length;
        },
        snapInitialIndexBuilder: (pageIndex) {
          return 0;
        },
        itemBuilder: (context, pageIndex, snapIndex, animation, controller) {
          // if(snapIndex == images.length-1){
          //   Future.delayed(Duration(seconds: 7)).then((value) {Navigator.pop(context);});
          // }
          return Stack(
            children: [
              getChild(pageIndex, snapIndex, controller),
              SafeArea(
                child: StoryProgressBars(
                  snapIndex: snapIndex,
                  snapCount: images.length,
                  animation: animation,
                  builder: (progress) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: ProgressBarIndicator(
                          progress: progress,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 26,horizontal: 12),
                        child: Text(eventName?[snapIndex] ?? "",style: tenor12White),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12,right: 4),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear,color: HtpTheme.goldenColor,size: 32,),
                          ),
                        ),
                      ),
                    ],
                  ), Column(
                    children: [
                      RotatedBox(quarterTurns: 1,child: SvgPicture.asset('assets/svg/icons/arrow/sidearrow.svg')),
                      SizedBox(height: size.height/60,),
                      SizedBox(
                                width: 120,
                                child: OutlinedBlackButton(onTap: ()async{
                                  Navigator.pop(context);
                                  await ref.read(adPopupProvider.notifier).adRedirection(url[snapIndex],internalRedirect[snapIndex],);
                                  // final Map<String,dynamic> data = {};

                                }, text: "Check it out",height: 40,)),
                      SizedBox(height: size.height/20,),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

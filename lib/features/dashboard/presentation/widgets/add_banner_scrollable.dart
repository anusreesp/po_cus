import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/spacing_values.dart';

import '../../../../common/utils/dynamic_routes.dart';
import '../../data/models/ad_banners.dart';

class AddBannerScrollable extends StatefulWidget {
  final List<AdBanner> data;
  const AddBannerScrollable({Key? key, required this.data}) : super(key: key);

  @override
  State<AddBannerScrollable> createState() => _AddBannerScrollableState();
}

class _AddBannerScrollableState extends State<AddBannerScrollable> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (_scrollController.hasClients) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.linear);
          } else {
            _scrollController.animateTo(_scrollController.position.pixels + 320,
                duration: const Duration(seconds: 1), curve: Curves.linear);
          }
        }
      });

      // _scrollController.addListener(() {
      //   if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      //     _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      //   }else{
      //     // _scrollController.animateTo(320, duration: const Duration(seconds: 1), curve: Curves.linear);
      //   }
      // });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return ListView.builder(
          itemCount: widget.data.length,
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          padding: const EdgeInsets.only(
            right: rightDashboardPadding - 4,
          ),
          itemBuilder: (context, index) {
            // final data = SampleData().sampleBottlesImage;
            return Padding(
              padding: const EdgeInsets.only(
                // left: index == 0 ? 16 : 0,
                // right: widget.data.length == (index - 1) ? 0 : 12
                left: leftDashboardPadding - 4,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GestureDetector(
                    onTap: () {
                      try {
                        redirectUrl(widget.data[index].redirectUrl ?? '',
                            widget.data[index].redirectType == 'internal', ref);
                        // if(data[index].redirectType == 'internal'){
                        //
                        // }else{
                        //   launchUrl(Uri.parse(data[index].redirectUrl ?? ''));
                        // }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Image.network(
                      widget.data[index].image,
                      // 'https://honestreviewsin.files.wordpress.com/2020/08/jack-daniels-150th-anniversary-640x350-1.jpg',
                      width: 320,
                      // height: 124,
                      fit: BoxFit.fill,
                    ),
                  )),
            );
          });
    });
  }
}

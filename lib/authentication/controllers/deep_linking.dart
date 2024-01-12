

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';

final deepLinkingProvider = StateNotifierProvider<DeepLinkingController, DeepLinkBase>((ref) {

  return DeepLinkingController(ref);
});

class DeepLinkingController extends StateNotifier<DeepLinkBase>{
  final Ref _ref;
  DeepLinkingController(this._ref):super(DeepLinkInitial()){
    init();
  }

  final _fireDynamic = FirebaseDynamicLinks.instance;

  init() async{
    final PendingDynamicLinkData? initialLink = await _fireDynamic.getInitialLink();
    print("Dynamic Link: ${initialLink?.link.query} --- ${initialLink?.link.path}");
    if(initialLink != null){
      redirect({'internal_redirect': true, 'url': initialLink.link.query}, _ref, deepLink: true);
      return;
    }

    _fireDynamic.onLink.listen((event) {
      print("Dynamic Link Listen: ${event.link.query} --- ${event.utmParameters}");
      redirect({'internal_redirect': true, 'url': event.link.query}, _ref, deepLink: true);
    });

  }


}

abstract class DeepLinkBase{}

class DeepLinkInitial extends DeepLinkBase{}




import 'dart:async';

import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/utils/dynamic_routes.dart';

final branchProvider = StateNotifierProvider((ref) => BranchController(ref));

class BranchController extends StateNotifier<BranchState>{
  final Ref _ref;
  BranchController(this._ref):super(BranchInitial()){
    init();
  }

  late StreamSubscription<Map> streamSubscription;

  init()async{
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      // redirect({'internal_redirect': true, 'url': 'clubs=42525'}, _ref, deepLink: true);
      print("BRANCH DATA: $data");
    }, onError: (error){
      print("BRANCH DEEP LINK");
    });
  }


  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

}

abstract class BranchState{}

class BranchInitial extends BranchState{}
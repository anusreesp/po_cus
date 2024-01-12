

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/dashboard_service.dart';

final contactUsProvider = StateNotifierProvider<ContactUsController, ContactUsState>((ref){
  final service = ref.watch(dashboardServiceProvider);
  return ContactUsController(service);
});

class ContactUsController extends StateNotifier<ContactUsState>{
  final DashboardService _service;
  ContactUsController(this._service):super(ContactUsInitial());

  contactUsRequest({
    required String name,
    required String mobile,
    required String email,
    required String message
  }) async{
    try{
      state = ContactUsLoading();
      await _service.contactRequest(name: name, mobile: mobile, email: email, message: message);
      state = ContactUsSuccess();
    }catch(e){
      state = ContactUsError(e.toString());
    }
  }

}

abstract class ContactUsState{}

class ContactUsInitial extends ContactUsState{}

class ContactUsLoading extends ContactUsState{}

class ContactUsSuccess extends ContactUsState{}

class ContactUsError extends ContactUsState{
  final String msg;
  ContactUsError(this.msg);
}
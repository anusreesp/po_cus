import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/booking/data/services/invoice_services.dart';

final billUploadProvider =
    StateNotifierProvider.autoDispose<BillUploadController, BillUploadStates>(
        (ref) {
  final service = ref.watch(invoiceBillServiceProvider);
  return BillUploadController(service);
});

class BillUploadController extends StateNotifier<BillUploadStates> {
  final InvoiceServices services;
  BillUploadController(this.services) : super(BillUploadInitialState());

  submitBill(MultipartFile invoiceFile, String id, String type) async {
    state = BillUploadLoadingState();
    try {
      state = BillUploadSuccessState();
      await services.uploadBillInvoice(invoiceFile, id, type);
    } catch (e) {
      state = BillUploadErrorState(e.toString());
    }
  }
}

abstract class BillUploadStates {}

class BillUploadInitialState extends BillUploadStates {}

class BillUploadLoadingState extends BillUploadStates {}

class BillUploadSuccessState extends BillUploadStates {}

class BillUploadErrorState extends BillUploadStates {
  final String msg;
  BillUploadErrorState(this.msg);
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../networking/http_client.dart';

final invoiceBillServiceProvider = Provider((ref) {
  return;
});

class InvoiceServices {
  final NetworkClient _client;
  InvoiceServices(this._client);

  Future<void> uploadBillInvoice(
      MultipartFile invoiceFile, String id, String type) async {
    try {
      final response = await _client.postRequest('/booking/v2/uploadInvoice', {
        'invoice': invoiceFile,
        'id': id,
        'type': type,
      });

      final result = response.data;
    } catch (e) {
      debugPrint("???????${e.toString()}");
      rethrow;
    }
  }
}

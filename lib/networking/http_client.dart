import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as p;
import '../app_config.dart';
import 'custom_exception.dart';

String? uid;
String? idToken;

final clientProvider = Provider((ref) {
  final config = ref.watch(appConfigProvider);
  return NetworkClient(baseUrl: config.baseUrl);
});

class NetworkClient {
  final String baseUrl;

  NetworkClient({this.baseUrl = 'https://partyone-live-pro-1.as.r.appspot.com'}) {
    _dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "developement": false,
            "token": idToken ?? 'test_TOKEN',
            "uid": uid ?? 'test_UID'
          },
          contentType: 'application/json'),
    );

    _dioNoToken = Dio(BaseOptions(baseUrl: baseUrl));
  }

  // final baseUrl = 'http://35.244.11.231';
  late final Dio _dio;
  late final Dio _dioNoToken;

  Future<Response> getRequest(String path) async {
    try {
      return await _dio.get(path);
    } on DioError catch (e) {
      throw CustomException.fromDioError(e);
    }
  }

  Future<Response> postRequest(String path, dynamic request) async {
    try {
      return await _dio.post(path, data: request);
    } on DioError catch (e) {
      throw CustomException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> demoDataRequest(String filaPath) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final String response = await rootBundle.loadString(filaPath);
      return jsonDecode(response);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRequest(String path, Map<String, dynamic> query) async {
    try {
      return await _dio.delete(path, queryParameters: query);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> getRequestNoToken(String path) async {
    try {
      return await _dioNoToken.get(path);
    } on DioError catch (e) {
      throw CustomException.fromDioError(e);
    }
  }

  Future<Response> postRequestNoToken(String path, dynamic request,
      {Map<String, dynamic>? headers, Options? options}) async {
    try {
      if (headers != null) {
        _dioNoToken.options.headers = headers;
      }
      return await _dioNoToken.post(path, data: request, options: options);
    } on DioError catch (e) {
      print(e.response);
      throw CustomException.fromDioError(e);
    }
  }

  // Future<Response> postTwilio(String path, dynamic request,
  //     {Map<String, dynamic>? headers, Options? options}) async {
  //   try {
  //     if (headers != null) {
  //       _dioNoToken.options.headers = headers;
  //     }
  //     return await _dioNoToken.post(path, data: request, options: options);
  //   } on DioError catch (e) {
  //     print(e);
  //     if (e.response != null) {
  //       throw e.response!.data['message'];
  //     } else {
  //       throw CustomException.fromDioError(e);
  //     }
  //   }
  // }

  Future<String> uploadFile(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'images': [await MultipartFile.fromFile(filePath)]
      });

      final response = await _dio.post('/uploads/uploadImages', data: formData);
      final urls = response.data['url'] as List<dynamic>;
      return urls.single;
    } on DioError catch (e) {
      throw CustomException.fromDioError(e);
    }
  }

  // Future<String> uploadInvoiceFile(String filePath) async {
  //   try {
  //     final formData = await MultipartFile.fromFile(filePath);

  //     final response =
  //         await _dio.post('/uploads/v1/uploadInvoice', data: formData);
  //     final urls = response.data['url'];
  //     return urls.single;
  //   } on DioError catch (e) {
  //     throw CustomException.fromDioError(e);
  //   }
  // }

  Future uploadInvoiceFile(String filePath) async {
    try {
      final formData = await MultipartFile.fromFile(filePath);

      return formData;

      // final response =
      //     await _dio.post('/uploads/v1/uploadInvoice', data: formData);
      // final urls = response.data['url'];
      // return urls.single;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> downloadVideoFile(String url, String fileName) async {
    try {
      final appDirectory = await p.getApplicationSupportDirectory();
      final path = '${appDirectory.path}/$fileName';
      await _dio.download(url, path);
      return path;
    } on DioException catch (e) {
      throw CustomException.fromDioError(e);
    } catch (_) {
      rethrow;
    }
  }

  // downloadImage(String imageUrl)async{
  //  final file = await _dio.download('urlPath', 'savePath');
  //  file.data
  // }

}

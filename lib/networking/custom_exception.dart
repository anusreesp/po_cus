import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException.fromDioError(DioError dioError) {

    if(message == null){
      switch (dioError.type) {
        case DioErrorType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.connectionError:
          message = "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.unknown:
          message = _handleError(dioError.response!.statusCode);
          break;
        case DioErrorType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = _handleDefaultError(dioError);
          break;
      }
    }


  }

  dynamic message;

  String? _handleDefaultError(DioError error){
    // print("ERROR Handle: ${error.response?.data}");
    try{
      final response = error.response?.data as Map?;
      if(response != null){
        return "${response["message"]}";
        // return;
      }
      return error.message;
    }catch (_){
      return error.message;
    }
  }

  Object _handleError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized request';
      case 404:
        return 'The requested resource was not found';
      // if (value == clubs) {
      //   return ClubNotFoundExceptions();
      // } else {
      //   return EventNotFoundExceptions();
      // }
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
        // return const SomethingWrong();
    }
  }

  @override
  String toString() => message.toString();
}

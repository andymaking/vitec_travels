import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vitec_travels/util/snack_message.dart';

abstract class Remote {
  Future<String?> getTravelData();
}

void handleError(dynamic error) {
  var errorString = error.response.toString();
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.cancel:
        showCustomToast("Request to API server was cancelled");
        break;
      case DioErrorType.connectTimeout:
        showCustomToast("Connection timeout with API server");
        break;
      case DioErrorType.other:
        showCustomToast("Connection to API server failed due to internet connection");
        break;
      case DioErrorType.receiveTimeout:
        showCustomToast("Receive timeout in connection with API server");
        break;
      case DioErrorType.response:
        final errorMessage = "${error.response?.statusCode}, ${error.response?.statusMessage}";
        showCustomToast(errorMessage);
        break;
      case DioErrorType.sendTimeout:
        showCustomToast("Send timeout in connection with API server");
        break;
      default:
        showCustomToast("Something went wrong");
        break;
    }
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];
    throw nameJson;
  }
}
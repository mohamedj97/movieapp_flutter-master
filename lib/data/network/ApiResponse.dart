import 'package:dio/dio.dart';

class ApiResponse<T> {
  Status status;
  T data;
  String messageKey;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(DioError error)
      : status = Status.ERROR,
        messageKey = _handleError(error);

  @override
  String toString() {
    return "Status : $status \n Message : $messageKey \n Data : $data";
  }

  static String _handleError(DioError error) {
    String key = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          print("Request to API server was cancelled");
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          print("Connection timeout with API server");
          key = 'Internet_Error';
          break;
        case DioErrorType.SEND_TIMEOUT:
          print("Connection timeout with API server");
          key = 'Internet_Error';
          break;
        case DioErrorType.DEFAULT:
          key = 'Internet_Error';
          print("No internet connection");

          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          key = 'Internet_Error';
          print("Receive timeout in connection with API server");

          break;
        case DioErrorType.RESPONSE:
          print(
              "Received invalid status code: ${dioError.response.statusCode}");
          key = 'Server_Error';
          break;
      }
    } else {
      key = 'Unknown_network_error';
    }
    return key;
  }
}

enum Status { LOADING, COMPLETED, ERROR }

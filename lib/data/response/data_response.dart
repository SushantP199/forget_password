import 'package:forget_password/data/response/status.dart';

class DataResponse<T> {
  Status? status;
  T? data;
  String? message;

  DataResponse.loading() {
    status = Status.LOADING;
  }

  DataResponse.completed(this.data) : status = Status.COMPLETED;

  DataResponse.error(String errorMessage) {
    status = Status.ERROR;
    message = errorMessage;
  }

  @override
  String toString() {
    return "Status: $status.\tError: $message.";
  }
}

enum Status { Loading, Complete, Error }

class ApiResponse<T> {
  T? data;
  Status? status;
  String? message;
  int? statusCode;

  ApiResponse({this.status, this.data, this.message, this.statusCode});

  ApiResponse.loading() : status = Status.Loading;

  ApiResponse.completed(this.data) : status = Status.Complete;

  ApiResponse.error(this.message) : status = Status.Error;
}

import 'package:dio/dio.dart';

class FormattedResponse {
  final bool success;
  final bool? deviceRegistered;
  final dynamic data;
  final String? retryCode;
  final String? responseCodeError;
  final Headers? headers;

  FormattedResponse(
      {required this.success,
      this.deviceRegistered,
      this.retryCode,
      this.data,
      this.responseCodeError,
      this.headers});
}

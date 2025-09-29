import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yolanda/network/formatted_response.dart';
import 'package:yolanda/network/logger.dart';

import '../utils/app_helpers.dart';
import 'network.dart' as networkutils;

//An Error occured connecting this request, Please try again later!
//parsingError
abstract class ApiManager {
  late Dio _dio;

  late final String _baseURL;
  ApiManager({required String baseUrl}) {
    _baseURL = baseUrl;

    final options = BaseOptions(
      baseUrl: _baseURL,
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 90), // 90 seconds
    );

    _dio = Dio(options);
    if (kDebugMode) {
      // _dio.interceptors.add(PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: false,
      //   error: true,
      //   compact: true,
      // ));
    }
  }

  //GET
  Future<FormattedResponse> getHttp(String route,
      {Map<String, dynamic>? params,
      bool formdata = false,
      CancelToken? cancelToken,
      bool isResponseEncrypted = true,
      String? url,
      dynamic body}) async {
    setHeader(formdata: formdata);
    params?.removeWhere((key, value) => value == null);
    // if (params != null) {
    //   params = {"value": await cryptString(jsonEncode(params))};
    // }
    final fullRoute = url ?? '$_baseURL$route';
    return makeRequest(
        _dio.get(
          fullRoute,
          cancelToken: cancelToken,
          data: body,
          queryParameters: params,
        ),
        isResponseEncrypted: isResponseEncrypted);
  }

  //POST
  Future<FormattedResponse> postHttp(
    String route,
    dynamic body, {
    Map<String, dynamic>? params,
    bool formdata = false,
    bool formEncoded = false,
    String? url,
    CancelToken? cancelToken,
  }) async {
    setHeader(formdata: formdata, formEncoded: formEncoded);
    params?.removeWhere((key, value) => value == null);
    //body?.removeWhere((key, value) => value == null);
    final fullRoute = url ?? '$_baseURL$route';
    if (formdata) {
      body = FormData.fromMap(body as Map<String, dynamic>);
    }
    if (body != null) {
      // body = cryptString(jsonEncode(body));  //Encrypted response
      body = jsonEncode(body);
    }

    return makeRequest(_dio.post(
      fullRoute,
      data: body,
      cancelToken: cancelToken,
      onSendProgress: networkutils.showLoadingProgress,
      onReceiveProgress: networkutils.showLoadingProgress,
      queryParameters: params,
    ));
  }

  //PUT
  Future putHttp(
    String route,
    body, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    bool useBearer = true,
  }) async {
    setHeader();
    params?.removeWhere((key, value) => value == null);
    //body?.removeWhere((key, value) => value == null);
    final fullRoute = '$_baseURL$route';
    if (body != null) {
      // body = cryptString(jsonEncode(body));  //Encrypted response
      body = jsonEncode(body);
    }
    if (params != null) {
      // params = {"data": cryptString(jsonEncode(params))};
      params = {"data": jsonEncode(params)};
    }
    return makeRequest(_dio.put(
      fullRoute,
      data: body,
      cancelToken: cancelToken,
      onSendProgress: networkutils.showLoadingProgress,
      onReceiveProgress: networkutils.showLoadingProgress,
      queryParameters: params,
    ));
  }
  // An Error occured connecting this request, Please try again later!
  //DELETE
  Future<FormattedResponse> deleteHttp(
    String route, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    dynamic data,
  }) async {
    setHeader();
    params?.removeWhere((key, value) => value == null);
    final fullRoute = '$_baseURL$route';
    if (params != null) {
      // params = {"data": cryptString(jsonEncode(params))};
      params = {"data": jsonEncode(params)};
    }
    if (data != null) {
      // data = cryptString(jsonEncode(data));
      data = jsonEncode(data);
    }

    return makeRequest(_dio.delete(fullRoute,
        queryParameters: params, cancelToken: cancelToken, data: data));
  }

  Future<FormattedResponse> makeRequest(Future<Response> future,
      {bool isResponseEncrypted = true}) async {
    Response? response;
    try {
      response = await future;
    } on DioException catch (e) {
      if (kDebugMode) {
        AppLogger.logError('HTTP SERVICE ERROR MESSAGE: ${e.message}');
        AppLogger.logError('HTTP SERVICE ERROR URl: ${response?.realUri}');
        AppLogger.logError('HTTP SERVICE ERROR DATA: ${e.response?.data}');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Connection Timeout",
          retryCode: AppHelpers.retryCode,
          success: false,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        if (e.message != null && e.message!.contains('SocketException')) {
          return FormattedResponse(
            data: response?.data,
            retryCode: AppHelpers.retryCode,
            responseCodeError: "Oops! An error occurred. Please check your internet and try again.",
            success: false,
          );
        }
      } else if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 407) {
        // unAuthorizedSessionValueNotifier.value = true;
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Unauthorized Session",
          success: false,
        );
      } else if (e.response?.statusCode == 404) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Oops! Resource not found",
          success: false,
        );
      } else if (e.response?.statusCode == 403) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Access denied",
          success: false,
        );
      } else if (e.response?.statusCode == 500 ||
          e.response?.statusCode == 503) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Oops! It's not you, it's us. Give us a minute and then try again.",
          success: false,
        );
      } else if (e.response?.statusCode == 400) {
        if (e.response?.data != null && e.response?.data.isNotEmpty) {
          try {
            var plain = e.response?.data;
            e.response?.data = jsonDecode(plain);
            AppLogger.logError(
                'URl ${response?.realUri}\nresponse data  ${jsonEncode(e.response?.data)}');
            return FormattedResponse(
              data: e.response?.data,
              success: false,
            );
          } catch (e) {
            return FormattedResponse(
                data: null,
                success: false,
                responseCodeError: "Decryption Failed");
          }
        }
      } else if (e.type == DioExceptionType.unknown) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Oops! An error occurred.",
          success: false,
        );
      }
    } catch (err) {
      return FormattedResponse(
        data: null,
        responseCodeError: "An error has occurred, Give us a minute and then try again.",
        success: false,
      );
    }
    if (response?.data != null && response?.data.isNotEmpty) {
      print("encrypted response ${response?.data}");
      try {
        var plain = isResponseEncrypted
            ? response?.data
            : response?.data;
        response?.data = jsonDecode(plain);
        AppLogger.logSuccess(
            'URl ${response?.realUri}\nresponse data  ${jsonEncode(response?.data)}');
      } catch (e) {
        return FormattedResponse(
            data: null, success: false, responseCodeError: "Decryption Failed");
      }
    }

    return FormattedResponse(
      data: response?.data,
      headers: response?.headers,
      success: "${response?.statusCode}".startsWith('2'),
    );
  }

  setHeader({
    bool formdata = false,
    bool formEncoded = false,
  }) async {

    final userDetails = GetStorage();
    var userToken = userDetails.read('bearerToken');


    final Map<String, dynamic> header = {
      'content-type': formdata
          ? 'multipart/form-data'
          : formEncoded
              ? 'application/x-www-form-urlencoded'
              : 'application/json',
      'Accept': '*/*',
      'Authorization': "Bearer $userToken",
      'x-clientid': "altprov2mobile",
      'x-channel': "mobile",
      // 'x-appversion': "${AppNetworkUrl.appversion}",
      // 'x-csrf-token': User_Controller.userCrsfToken,
      // 'Cookie': "${User_Controller.userCrsfTokenFull}",
    };

    _dio.options.headers.addAll(header);
  }

  // void dispose() {
  //   _dio.clear();
  //   _dio.close(force: true);
  // }

  // clearHeaders() {
  //   _dio.options.headers.clear();
  // }
}

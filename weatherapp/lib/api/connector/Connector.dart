import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:weatherapp/api/result/Error.dart';
import 'package:weatherapp/api/result/Result.dart';

class ConnectorConstants {
  /// Status is ok
  static const int OK = 200;

  /// Status is created
  static const int CREATED = 201;

  /// Status is accepted
  static const int ACCEPTED = 202;

  /// Status is not content
  static const int NO_CONTENT = 204;

  /// Not found
  static const int NOT_FOUND = 404;

  /// Status is not internet
  static const int NO_INTERNET = -1;

  /// Status is bad request
  static const int BAD_REQUEST = 400;

  /// Status unauthorized
  static const int UNAUTHORIZED = 401;

  /// Status refresh token
  static const int REFRESH_TOKEN = 410;

  /// Token expire
  static const int EXPIRED = 411;
}

class Connector {

  Dio? _dio;

  /// Singleton pattern
  Connector._privateConstructor() {
    BaseOptions options = BaseOptions(
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000));
    _dio = Dio(options);
    _dio!.interceptors.add(LogInterceptor(responseBody: false));
    _dio!.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  }

  static final Connector _instance = Connector._privateConstructor();

  static Connector get instance {
    return _instance;
  }

  /// Handle error
  Result handleError(DioException e) {
    Result result = Result();
    if (e.response == null) {
      result.code = ConnectorConstants.NO_INTERNET;
      result.error = Error(code: ConnectorConstants.NO_INTERNET, message: '');
    } else if (e.response!.statusCode == ConnectorConstants.EXPIRED) {
      result.code = ConnectorConstants.EXPIRED;
      result.error = getErrorObj(e.response!);
    } else if (e.response!.statusCode == ConnectorConstants.NOT_FOUND) {
      result.code = ConnectorConstants.NOT_FOUND;
      result.error = Error(code: ConnectorConstants.NOT_FOUND, message: e.response!.data['message']);
    } else {
      result.code = e.response!.statusCode;
      result.error = getErrorObj(e.response!);
    }
    return result;
  }

  /// Get error object
  Error getErrorObj(Response response) {
//    try {
//      ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
//      if (errorResponse != null && errorResponse.error != null) {
//        return errorResponse.error;
//      }
//    }catch(Exception e){
    Map<String, dynamic> args = Map();
    args['code'] = response.statusCode;
    args['message'] = response.statusMessage;
    return Error.fromJson(args);
  }
}

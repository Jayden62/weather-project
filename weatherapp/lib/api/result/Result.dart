import 'package:weatherapp/api/connector/Connector.dart';
import 'package:weatherapp/api/result/Error.dart';

class Result<T> {
  int? code;
  Error? error;
  T? data;

  bool isOtherError() {
    if (code != ConnectorConstants.OK &&
        code != ConnectorConstants.CREATED &&
        code != ConnectorConstants.ACCEPTED &&
        code != ConnectorConstants.NO_INTERNET &&
        code != ConnectorConstants.EXPIRED) {
      return true;
    }
    return false;
  }

  bool isSuccess() {
    if (code == ConnectorConstants.OK) {
      return true;
    }
    return false;
  }

  bool isCreated() {
    if (code == ConnectorConstants.CREATED) {
      return true;
    }
    return false;
  }

  bool isBadRequest() {
    if (code == ConnectorConstants.BAD_REQUEST) {
      return true;
    }
    return false;
  }

  bool isNoInternet() {
    if (code == ConnectorConstants.NO_INTERNET) {
      return true;
    }
    return false;
  }

  bool isNoAuthentication() {
    if (code == ConnectorConstants.UNAUTHORIZED) {
      return true;
    }
    return false;
  }

  bool isNotFound() {
    if (code == ConnectorConstants.NOT_FOUND) {
      return true;
    }
    return false;
  }

  bool isRefreshToken() {
    if (code == ConnectorConstants.REFRESH_TOKEN) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'Code $code, message $error, data $data';
  }
}

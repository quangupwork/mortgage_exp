import '../../src/enums/enums.dart';

class ErrorModel {
  ResultType resultType;
  String message;

  ErrorModel(this.resultType, this.message);

  static ErrorModel warning(String message) {
    return ErrorModel(ResultType.warning, message);
  }

  static ErrorModel error(String message) {
    return ErrorModel(ResultType.error, message);
  }
}

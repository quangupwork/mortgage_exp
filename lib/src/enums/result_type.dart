enum ResultType { warning, error }
enum StatusCall { loading, success, successSync, error, reject, none }

extension StatusCallExtension on StatusCall? {
  bool get isLoading => this == StatusCall.loading;
  bool get isSuccess => this == StatusCall.success;
  bool get isSuccessSync => this == StatusCall.successSync;
  bool get isError => this == StatusCall.error;
  bool get isReject => this == StatusCall.reject;
  bool get isNone => this == null || this == StatusCall.none;
}

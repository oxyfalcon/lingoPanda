class AsyncValue<T extends Object?> {
  ApiStatusEnum status;
  T? value;
  AsyncValue({required this.status, this.value});
}

enum ApiStatusEnum { initial, loading, completed, error }

sealed class LoadState<T> {}

class Loading<T> extends LoadState<T> {}
class End<T> extends LoadState<T> {}

class Success<T> extends LoadState<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends LoadState<T> {
  final Object? exception;

  Error(this.exception);
}

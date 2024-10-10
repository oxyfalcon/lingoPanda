import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lingopanda/model/api_status_model.dart';
import 'package:lingopanda/utils/config.dart';
import 'package:provider/provider.dart';

class CustomFutureNotifier<T extends Object?> extends ChangeNotifier {
  final AsyncValue<T> asyncValue;
  final Future<T> Function() futureCallback;
  final Config _utils = Config.instance;
  final bool showErrorSnackbar;
  final bool showSuccussSnakbar;
  CustomFutureNotifier({
    required this.asyncValue,
    required this.futureCallback,
    this.showErrorSnackbar = true,
    this.showSuccussSnakbar = true,
  });

  void _apiStatusChange(
    ApiStatusEnum status, {
    String? errorMessage,
    String? successMessage,
    required bool callInstantly,
  }) {
    asyncValue.status = status;
    if (asyncValue.status == ApiStatusEnum.error && showErrorSnackbar) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _utils.showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(errorMessage ?? 'Error, Please try again',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ));
      });
    } else if (asyncValue.status == ApiStatusEnum.completed &&
        showSuccussSnakbar) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _utils.showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(successMessage ?? 'Done!',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ));
      });
    }
    if (callInstantly) notifyListeners();
  }

  Future<void> callFuture<E extends Object>({
    FutureOr<T> Function(E error, StackTrace stackTrace)? onError,
    String? successMessage,
    String? Function(E error, StackTrace stackTrace)? errorMessage,
    bool callInstantly = true,
  }) async {
    _apiStatusChange(ApiStatusEnum.loading, callInstantly: callInstantly);
    if (onError != null) {
      asyncValue.value = await futureCallback().onError<E>((error, stackTrace) {
        _apiStatusChange(ApiStatusEnum.error,
            errorMessage: errorMessage?.call(error, stackTrace),
            callInstantly: true);
        return onError.call(error, stackTrace);
      });
    } else {
      asyncValue.value = await futureCallback().catchError((error, stackTrace) {
        _apiStatusChange(ApiStatusEnum.error,
            errorMessage: errorMessage?.call(error, stackTrace),
            callInstantly: true);
        return Future<T>.error(error);
      });
    }

    if (asyncValue.status != ApiStatusEnum.error) {
      _apiStatusChange(ApiStatusEnum.completed,
          successMessage: successMessage, callInstantly: true);
    }
  }
}

class CustomFutureProvider<T extends Object?>
    extends ChangeNotifierProvider<CustomFutureNotifier<T>> {
  CustomFutureProvider({
    super.key,
    required Future<T> Function() futureCallback,
    bool showErrorSnackbar = true,
    bool showSuccussSnakbar = true,
    super.builder,
  }) : super(
            create: (context) => CustomFutureNotifier<T>(
                asyncValue: AsyncValue(status: ApiStatusEnum.initial),
                futureCallback: futureCallback,
                showErrorSnackbar: showErrorSnackbar,
                showSuccussSnakbar: showSuccussSnakbar));
}

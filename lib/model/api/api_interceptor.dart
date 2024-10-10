import 'package:dio/dio.dart';
import 'package:lingopanda/utils/config.dart';

class ApiInterceptor {
  static Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: "application/json"))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers
            .addAll({"Authorization": "Bearer ${Config.newsApiKey}"});
        handler.next(options);
      },
      onError: (error, handler) {
        handler.next(error.copyWith(
            message: error.response?.data["message"] ?? error.message));
      },
    ));
}

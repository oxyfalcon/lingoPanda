import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/firebase_options.dart';

class Config {
  Config._();
  static final Config _obj = Config._();
  static Config get instance => _obj;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const String newsApiKey = "188c92a89faa441aad00d5e70a862920";

  void showSnackBar(SnackBar snackBar) {
    if (scaffoldMessengerKey.currentState != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    }
  }

  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  static Uri uri =
      Uri(host: "newsapi.org", scheme: "https", path: "/v2/top-headlines");

  static String? handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return "Your request has been cancelled. Please try again!";
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please try again!";
      case DioExceptionType.unknown:
        return "Unknow error";
      case DioExceptionType.receiveTimeout:
        return "Request timed out. Please try again";
      case DioExceptionType.sendTimeout:
        return "Sending timeout. Please try again!";
      case DioExceptionType.connectionError:
        return "No internet connection";
      default:
        return null;
    }
  }

  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(const {"country": "us"});
    await remoteConfig.fetchAndActivate();
  }
}

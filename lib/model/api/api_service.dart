import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pingolearn/model/api/api_interceptor.dart';
import 'package:pingolearn/model/news_model.dart';
import 'package:pingolearn/utils/config.dart';
import 'package:pingolearn/utils/extension.dart';

class ApiService {
  static Future<List<NewsModel>?> getNews(String countryCode) async {
    Response<Map<String, dynamic>> response = await ApiInterceptor.dio
        .getUri<Map<String, dynamic>>(
            Config.uri.copyWith(queryParameters: {"country": countryCode}),
            options: Options(
                headers: {"Authorization": "Bearer ${Config.newsApiKey}"}));
    if (response.data != null && response.data!.isNotEmpty) {
      List<dynamic> articleList = response.data!["articles"];
      List<NewsModel> newsList = [];
      for (var articles in articleList) {
        newsList.add(NewsModel.fromJson(articles));
      }
      return newsList;
    }
    return null;
  }

  static Future<void> signIn({
    required String email,
    required String password,
  }) async =>
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

  static Future<void> createUser({
    required String email,
    required String password,
  }) async =>
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

  static Future<void> add({
    required String name,
    required String emailId,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(emailId)
        .set({"emailId": emailId, "name": name});
  }
}

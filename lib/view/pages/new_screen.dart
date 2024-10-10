import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/model/api/api_service.dart';
import 'package:lingopanda/model/api_status_model.dart';
import 'package:lingopanda/model/news_model.dart';
import 'package:lingopanda/utils/config.dart';
import 'package:lingopanda/view/viewUtils/news_card.dart';
import 'package:lingopanda/view/viewUtils/signout_button.dart';
import 'package:lingopanda/viewModel/form_validator_provider.dart';
import 'package:lingopanda/viewModel/future_provider.dart';
import 'package:provider/provider.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      CustomFutureProvider<List<NewsModel>?>(
          showSuccussSnakbar: false,
          futureCallback: () async => await ApiService.getNews(
              FirebaseRemoteConfig.instance.getString("country"))),
      ChangeNotifierProvider<CountryProvider>(
          create: (context) => CountryProvider(
              FirebaseRemoteConfig.instance.getString("country")))
    ], child: const NewsList());
  }
}

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
    context
        .read<CustomFutureNotifier<List<NewsModel>?>>()
        .callFuture<DioException>(
          callInstantly: false,
          errorMessage: (error, stackTrace) =>
              Config.handleDioException(error) ?? error.message,
        );

    FirebaseRemoteConfig.instance.onConfigUpdated.listen((value) async {
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      if (mounted) {
        context.read<CountryProvider>().value =
            FirebaseRemoteConfig.instance.getString("country");
        await context
            .read<CustomFutureNotifier<List<NewsModel>?>>()
            .callFuture<DioException>(
              errorMessage: (error, stackTrace) =>
                  Config.handleDioException(error) ?? error.message,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("MyNews",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(
              CupertinoIcons.location_fill,
              size: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Consumer<CountryProvider>(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(ref.value.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary)),
            );
          })
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => context
            .read<CustomFutureNotifier<List<NewsModel>?>>()
            .callFuture<DioException>(
              callInstantly: false,
              errorMessage: (error, stackTrace) =>
                  Config.handleDioException(error) ?? error.message,
            ),
        child: SingleChildScrollView(
          child: Consumer<CustomFutureNotifier<List<NewsModel>?>>(
              builder: (context, ref, child) {
            if (ref.asyncValue.status == ApiStatusEnum.loading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: CircularProgressIndicator.adaptive()));
            } else if (ref.asyncValue.status == ApiStatusEnum.completed) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Headlines",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SignoutButton(),
                        ],
                      ),
                    ),
                    ...ref.asyncValue.value!.map((value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: NewsCard(newsModel: value),
                      );
                    })
                  ]);
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width);
            }
          }),
        ),
      ),
    );
  }
}

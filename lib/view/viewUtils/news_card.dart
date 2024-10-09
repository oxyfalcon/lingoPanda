import 'package:flutter/material.dart';
import 'package:pingolearn/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.newsModel});
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        trailing: Image.asset(
          "assets/breaking_new.jpeg",
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
        onTap: () => (newsModel.articleUrl != null)
            ? launchUrl(Uri.parse(newsModel.articleUrl!))
            : null,
        tileColor: Colors.transparent,
        title: Text(newsModel.title ?? "Title not available"),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(newsModel.title ?? "Description not available"),
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
        subtitleTextStyle: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

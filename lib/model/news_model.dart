class NewsModel {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? articleUrl;

  NewsModel({this.description, this.title, this.articleUrl, this.imageUrl});
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      title: json["title"],
      description: json["description"],
      imageUrl: json["urlToImage"],
      articleUrl: json["url"]);
}

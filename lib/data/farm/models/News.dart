import 'dart:convert';

import 'package:intl/intl.dart';

class NewsApiResonse {
  String status;
  int totalResults;
  List<Article> articles;

  NewsApiResonse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsApiResonse.fromRawJson(String str) => NewsApiResonse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsApiResonse.fromJson(Map<String, dynamic> json) => NewsApiResonse(
        status: json["status"] == null ? null : json["status"],
        totalResults: json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source == null ? null : source.toJson(),
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt == null ? null : publishedAt.toIso8601String(),
        "content": content == null ? null : content,
      };
  String getTime() {
    var formatter = new DateFormat('dd MMMM yyyy h:m');
    String formatted = formatter.format(publishedAt);
    return formatted;
  }

  String getDateOnly() {
    var formatter = new DateFormat('dd MMMM yyyy');
    String formatted = formatter.format(publishedAt);
    return formatted;
  }
}

class Source {
  String id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

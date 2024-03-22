class CategoriesNewsModel {
  String status;
  num totalResults;
  List<Articles> articles;

  CategoriesNewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory CategoriesNewsModel.fromJson(Map<String, dynamic> json) {
    return CategoriesNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Articles>.from(json['articles'].map((article) => Articles.fromJson(article))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    data['articles'] = articles.map((article) => article.toJson()).toList();
    return data;
  }
}

class Articles {
  Source? source;
  String author;
  String title;
  String description;
  String url;
  dynamic urlToImage;
  String publishedAt;
  String content;

  Articles({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    return data;
  }
}

class Source {
  dynamic id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

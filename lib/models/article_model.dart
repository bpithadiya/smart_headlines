class Article {
  final String title;
  final String description;
  final String? content;
  final String? urlToImage;
  final String url;
  final String sourceName;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    this.content,
    this.urlToImage,
    required this.url,
    required this.sourceName,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'],
      urlToImage: json['urlToImage'],
      url: json['url'] ?? '',
      sourceName: json['source']?['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}

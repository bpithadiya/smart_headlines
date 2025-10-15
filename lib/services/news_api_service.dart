import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApi {
  final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  /// Fetch news with filters + pagination
  Future<List<Article>> fetchNews({
    String category = 'general',
    String country = 'us',
    String language = 'en',
    int page = 1,
    int pageSize = 20,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?country=$country&language=$language&category=$category&page=$page&pageSize=$pageSize&apiKey=$_apiKey',
    );

    return _fetchArticlesFromUrl(url);
  }

  /// Search news by keyword and/or source + pagination
  Future<List<Article>> searchNews({
    String query = '',
    String source = '',
    int page = 1,
    int pageSize = 20,
    String language = 'en',
  }) async {
    String urlString = 'https://newsapi.org/v2/everything?language=$language&page=$page&pageSize=$pageSize&apiKey=$_apiKey';

    if (query.isNotEmpty) urlString += '&q=${Uri.encodeQueryComponent(query)}';
    if (source.isNotEmpty) urlString += '&sources=${Uri.encodeQueryComponent(source)}';

    final url = Uri.parse(urlString);
    return _fetchArticlesFromUrl(url);
  }

  /// Helper function
  Future<List<Article>> _fetchArticlesFromUrl(Uri url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = (data['articles'] as List)
          .map((json) => Article.fromJson(json))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to fetch news: ${response.statusCode}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';
import '../services/news_api_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsApi _newsApi = NewsApi();

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _searchQuery = '';
  String _selectedSource = '';
  int _currentPage = 1;
  bool _hasMore = true;

  String _category = 'general';
  String _country = 'us';
  String _language = 'en';

  // keys for SharedPreferences
  static const String _kCountry = 'pref_country';
  static const String _kLanguage = 'pref_language';
  static const String _kCategory = 'pref_category';
  static const String _kQuery = 'pref_query'; // optional
  static const String _kSource = 'pref_source'; // optional

  // --- Preferences ---
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _country = prefs.getString(_kCountry) ?? _country;
    _language = prefs.getString(_kLanguage) ?? _language;
    _category = prefs.getString(_kCategory) ?? _category;

    // optional: restore last search query and source
    // _searchQuery = prefs.getString(_kQuery) ?? '';
    // _selectedSource = prefs.getString(_kSource) ?? '';

    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCountry, _country);
    await prefs.setString(_kLanguage, _language);
    await prefs.setString(_kCategory, _category);

    // optional: save search query/source
    // await prefs.setString(_kQuery, _searchQuery);
    // await prefs.setString(_kSource, _selectedSource);
  }

  // --- Fetch & Search with pagination ---
  Future<void> fetchNews({bool reset = true}) async {
    if (_isLoading) return;

    if (reset) {
      _currentPage = 1;
      _articles = [];
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final newArticles = await _newsApi.fetchNews(
        category: _category,
        country: _country,
        language: _language,
        page: _currentPage,
        pageSize: 20,
      );

      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(newArticles);
      }
    } catch (e) {
      debugPrint('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchNews({bool reset = true}) async {
    if (_isLoading) return;

    if (reset) {
      _currentPage = 1;
      _articles = [];
      _hasMore = true;
    }

    _isLoading = true;
    _isSearching = true;
    notifyListeners();

    try {
      final newArticles = await _newsApi.searchNews(
        query: _searchQuery,
        source: _selectedSource,
        page: _currentPage,
        language: _language,
        pageSize: 20,
      );

      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(newArticles);
      }
    } catch (e) {
      debugPrint('Error searching news: $e');
    } finally {
      _isLoading = false;
      _isSearching = false;
      notifyListeners();
    }
  }

  void loadMore() {
    if (_hasMore && !_isLoading) {
      _currentPage++;
      if ((_searchQuery.isNotEmpty) || (_selectedSource.isNotEmpty)) {
        searchNews(reset: false);
      } else {
        fetchNews(reset: false);
      }
    }
  }

  // update filters and persist them
  Future<void> updateFilters({
    String? category,
    String? country,
    String? language,
  }) async {
    var changed = false;
    if (category != null && category != _category) {
      _category = category;
      changed = true;
    }
    if (country != null && country != _country) {
      _country = country;
      changed = true;
    }
    if (language != null && language != _language) {
      _language = language;
      changed = true;
    }

    if (changed) {
      await _savePreferences();
      fetchNews();
    }
  }

  // update search params and optionally persist
  Future<void> updateSearch({String query = '', String source = ''}) async {
    _searchQuery = query;
    _selectedSource = source;

    // optionally persist search state:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString(_kQuery, _searchQuery);
    // await prefs.setString(_kSource, _selectedSource);

    searchNews();
  }

  // getters for UI
  String get selectedCountry => _country;
  String get selectedLanguage => _language;
  String get selectedCategory => _category;
  String get searchQuery => _searchQuery;
  String get selectedSource => _selectedSource;
  bool get hasMore => _hasMore;
}

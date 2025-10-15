import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/dropdown_filter.dart';
import '../widgets/news_card.dart';
import '../widgets/shimmer_news_card.dart';
import '../widgets/app_bar_widget.dart';
import '../models/article_model.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final Map<String, String> _countries = {
    'us': 'United States',
    'in': 'India',
    'gb': 'United Kingdom',
    'nl': 'Netherlands',
    'au': 'Australia',
  };

  final Map<String, String> _languages = {
    'en': 'English',
    'hi': 'Hindi',
    'nl': 'Dutch',
    'fr': 'French',
  };

  final Map<String, String> _categories = {
    'general': 'General',
    'business': 'Business',
    'sports': 'Sports',
    'technology': 'Technology',
    'health': 'Health',
    'science': 'Science',
    'entertainment': 'Entertainment',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NewsProvider>(context, listen: false);
      provider.fetchNews();
    });
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        final provider = Provider.of<NewsProvider>(context);
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown Filters
              DropdownFilter(
                title: "Country",
                selectedValue: provider.selectedCountry,
                options: _countries,
                onChanged: (val) => provider.updateFilters(country: val),
              ),
              DropdownFilter(
                title: "Language",
                selectedValue: provider.selectedLanguage,
                options: _languages,
                onChanged: (val) => provider.updateFilters(language: val),
              ),
              DropdownFilter(
                title: "Category",
                selectedValue: provider.selectedCategory,
                options: _categories,
                onChanged: (val) => provider.updateFilters(category: val),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: const AppBarWidget(title: 'Smart Headlines'),
      body: Column(
        children: [
          // Search bar with filter icon
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search news or source...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          provider.updateSearch(query: '');
                        },
                      ),
                    ),
                    onSubmitted: (_) =>
                        provider.updateSearch(query: _searchController.text),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _openFilterSheet,
                  tooltip: 'Filter news',
                ),
              ],
            ),
          ),

          // News List
          Expanded(
            child: provider.isLoading && provider.articles.isEmpty
                ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => const ShimmerNewsCard(),
            )
                : ListView.builder(
              itemCount: provider.articles.length + 1,
              itemBuilder: (context, index) {
                if (index < provider.articles.length) {
                  final Article article = provider.articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ArticleDetailScreen(article: article),
                        ),
                      );
                    },
                    child: NewsCard(article: article),
                  );
                } else {
                  if (provider.hasMore) {
                    provider.loadMore();
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox(height: 40);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



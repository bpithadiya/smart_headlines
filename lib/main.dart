import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:smart_headlines/screens/splash_screen.dart';
import 'providers/news_provider.dart';
import 'constants/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Safe check
  final apiKey = dotenv.env['NEWS_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    print("⚠️ API key not found! Check your .env file.");
  } else {
    print("✅ API key loaded successfully.");
  }

  final newsProvider = NewsProvider();
  await newsProvider.loadPreferences(); // load saved filters
  await newsProvider.fetchNews(); // load initial feed (based on saved prefs)

  runApp(
    ChangeNotifierProvider<NewsProvider>.value(
      value: newsProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Headlines',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


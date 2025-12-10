// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/screens/favorites.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/mealDetails.dart';
import 'package:lab2/screens/meals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("📩 Background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/meals': (context) {
          final category =
          ModalRoute.of(context)!.settings.arguments as Category;
          return MealsScreen(categoryName: category.name);
        },
        '/mealDetails': (context) {
          final mealId = ModalRoute.of(context)!.settings.arguments as String;
          return MealDetailsScreen(mealId: mealId);
        },
        "/favorites": (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          final favorites = args["favorites"] as List<MealSummary>;
          final onFavoriteToggle = args["onFavoriteToggle"] as Function(MealSummary);
          return FavoritesPage(favorites: favorites, onFavoriteToggle: onFavoriteToggle);
        },

      },
    );
  }
}

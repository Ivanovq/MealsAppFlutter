// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/mealDetails.dart';
import 'package:lab2/screens/meals.dart';

void main() {
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

      },
    );
  }
}

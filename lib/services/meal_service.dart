import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/meal.dart';
import 'package:lab2/models/mealDetail.dart';

class MealApiService {
  Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final meals = data['meals'] as List<dynamic>;
        return meals.map((e) => MealSummary.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }

  Future<List<MealSummary>> searchMealsByName(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final meals = data['meals'] as List<dynamic>?;

        if (meals != null) {
          return meals.map((e) => MealSummary.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to search meals');
      }
    } catch (e) {
      throw Exception('Error searching meals: $e');
    }
  }

  Future<Meal?> fetchMealDetails(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final meals = data['meals'] as List<dynamic>?;
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals.first);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }
  Future<Meal?> fetchRandomMeal() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final meals = data['meals'] as List<dynamic>?;
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals.first);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching random meal: $e');
    }
  }

}

import 'package:flutter/material.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/services/meal_service.dart';
import 'package:lab2/widgets/meal_grid.dart';

class MealsScreen extends StatefulWidget {
  final String categoryName;
  const MealsScreen({super.key, required this.categoryName});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  bool _isLoading = true;
  final MealApiService _apiService = MealApiService();
  String _searchQuery = '';

  List<MealSummary> _meals = [];
  List<MealSummary> _filteredMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meals.isEmpty
          ? const Center(child: Text("No meals found"))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search meal...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => _filterMeals(value),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: MealGrid(meals: _filteredMeals),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMeals() async {
    final mealList = await _apiService.searchMealsByName(widget.categoryName);
    setState(() {
      _meals = mealList;
      _filteredMeals = mealList;
      _isLoading = false;
    });
  }

  void _filterMeals(String query) async {
    setState(() {
      _searchQuery = query;
    });

    if (query.isEmpty) {
      setState(() {
        _filteredMeals = _meals;
      });
    } else {
      final searchResults = await _apiService.searchMealsByName(query);
      setState(() {
        _filteredMeals = searchResults;
      });
    }
  }
}

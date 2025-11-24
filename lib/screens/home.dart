import 'package:flutter/material.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/models/mealDetail.dart';
import 'package:lab2/screens/mealDetails.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/services/meal_service.dart';
import 'package:lab2/widgets/category_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  final CategoryApiService _apiService = CategoryApiService();
  final MealApiService _mealService = MealApiService();

  String _searchQuery = '';
  List<Category> _category = [];
  List<Category> _filteredCategory = [];

  Meal? _randomMeal;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadRandomMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _category.isEmpty
          ? const Center(child: Text("No categories found"))
          : Column(
        children: [
          if (_randomMeal != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailsScreen(mealId: _randomMeal!.idMeal),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      _randomMeal!.thumbnail,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Recipe of the Day: ${_randomMeal!.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search category...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => _filterCategories(value),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CategoryGrid(category: _filteredCategory),
            ),
          ),
        ],
      ),
    );
  }

  void _loadCategories() async {
    final categoryList = await _apiService.fetchCategories();
    setState(() {
      _category = categoryList;
      _filteredCategory = categoryList;
      _isLoading = false;
    });
  }

  void _loadRandomMeal() async {
    final meal = await _mealService.fetchRandomMeal();
    setState(() {
      _randomMeal = meal;
    });
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategory = _category;
      } else {
        _filteredCategory = _category
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}

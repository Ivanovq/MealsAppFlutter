import 'package:flutter/material.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/models/mealDetail.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/services/meal_service.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;
  const MealDetailsScreen({super.key, required this.mealId});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final MealApiService _apiService = MealApiService();
  Meal? _meal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  void _loadMeal() async {
    final meal = await _apiService.fetchMealDetails(widget.mealId);
    setState(() {
      _meal = meal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_meal?.name ?? "Meal Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? const Center(child: Text("Meal not found"))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(_meal!.thumbnail, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              _meal!.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Instructions",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(_meal!.instructions),
            const SizedBox(height: 16),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(_meal!.ingredients.length, (i) {
                return Text("- ${_meal!.ingredients[i]} (${_meal!.measures[i]})");
              }),
            ),
            const SizedBox(height: 16),
            if (_meal!.youtube != null && _meal!.youtube!.isNotEmpty)
              TextButton(
                onPressed: () {
                  // отвори YouTube линк
                  // можеш да користиш url_launcher пакет
                },
                child: Text("Watch on YouTube"),
              ),
          ],
        ),
      ),
    );
  }
}

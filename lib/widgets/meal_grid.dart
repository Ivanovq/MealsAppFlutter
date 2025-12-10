import 'package:flutter/material.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/widgets/meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<MealSummary> meals;
  final List<MealSummary> favorites;
  final void Function(MealSummary meal) onFavoriteToggle;

  const MealGrid({
    super.key,
    required this.meals,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];
        final isFavorite = favorites.contains(meal);

        return MealCard(
          meal: meal,
          isFavorite: isFavorite,
          onFavoriteToggle: () => onFavoriteToggle(meal),
        );
      },
    );
  }
}

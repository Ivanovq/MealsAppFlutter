import 'package:flutter/material.dart';
import 'package:lab2/models/meal.dart';
import 'package:lab2/widgets/meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<MealSummary> meals;
  const MealGrid({super.key, required this.meals});

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
        return MealCard(meal: meals[index]);
      },
    );
  }
}

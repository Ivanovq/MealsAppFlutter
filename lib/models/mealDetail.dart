class Meal {
  final String idMeal;
  final String name;
  final String instructions;
  final String thumbnail;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.idMeal,
    required this.name,
    required this.instructions,
    required this.thumbnail,
    this.youtube,
    required this.ingredients,
    required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final meas = json['strMeasure$i'];
      if (ing != null && ing.toString().isNotEmpty) {
        ingredients.add(ing.toString());
        measures.add(meas?.toString() ?? '');
      }
    }

    return Meal(
      idMeal: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      youtube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}

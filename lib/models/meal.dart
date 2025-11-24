class MealSummary {
  final String idMeal;
  final String name;
  final String thumbnail;

  MealSummary({
    required this.idMeal,
    required this.name,
    required this.thumbnail,
  });

  factory MealSummary.fromJson(Map<String, dynamic> json) {
    return MealSummary(
      idMeal: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }
}

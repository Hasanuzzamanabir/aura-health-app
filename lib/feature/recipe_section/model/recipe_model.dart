class RecipeModel {
  final String title;
  final String category;
  final String imageUrl;
  final String calories;
  final String time;
  final String difficulty;
  final String aiInsight;
  final List<String> ingredients;
  final List<String> instructions;

  const RecipeModel({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.calories,
    required this.time,
    required this.difficulty,
    required this.aiInsight,
    required this.ingredients,
    required this.instructions,
  });
}

class GroceryItem {
  final String name;
  final String category;
  final String quantity;
  bool isChecked;

  GroceryItem({
    required this.name,
    required this.category,
    required this.quantity,
    this.isChecked = false,
  });
}

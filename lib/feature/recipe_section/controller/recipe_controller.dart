import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aurahealth/feature/recipe_section/model/recipe_model.dart';

class RecipeController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0 for Recipes, 1 for Grocery
  final RxString selectedCategory = "All".obs;
  final RxString searchQuery = "".obs;
  final RxString selectedTimeFilter = "This Week".obs;

  final TextEditingController searchController = TextEditingController();

  final RxList<RecipeModel> recipes = <RecipeModel>[
    const RecipeModel(
      title: 'Greek Yogurt Bowl',
      category: 'Breakfast',
      imageUrl:
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=600&q=80',
      calories: '520kcal',
      time: '10 min',
      difficulty: 'Easy',
      aiInsight: 'High in protein and probiotics to support digestive health.',
      ingredients: [
        '1 cup Greek Yogurt',
        '1/4 cup Granola',
        '1 tbsp Honey',
        'Mixed Berries',
      ],
      instructions: [
        'Scoop Greek yogurt into a bowl',
        'Top with granola, honey, and mixed berries',
        'Serve chilled',
      ],
    ),
    const RecipeModel(
      title: 'Quinoa Chicken Bowl',
      category: 'Lunch',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
      calories: '600kcal',
      time: '30 min',
      difficulty: 'Medium',
      aiInsight: 'Excellent blend of complex carbs and lean protein.',
      ingredients: [
        '150g Chicken Breast',
        '1 cup Quinoa',
        '1/2 Avocado',
        'Mixed Greens',
      ],
      instructions: [
        'Cook quinoa as directed',
        'Grill chicken breast',
        'Assemble bowl with greens and avocado',
      ],
    ),
    const RecipeModel(
      title: 'Salmon & Veggies',
      category: 'Dinner',
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=600&q=80',
      calories: '560kcal',
      time: '25 min',
      difficulty: 'Medium',
      aiInsight: 'Rich in Omega-3 fatty acids for heart and brain health.',
      ingredients: [
        '200g Salmon Fillet',
        '1 cup Broccoli Florets',
        '1/2 cup Carrots',
        '1 tbsp Olive Oil',
      ],
      instructions: [
        'Season salmon with salt and pepper',
        'Steam broccoli and carrots',
        'Pan-sear salmon for 4 minutes on each side',
      ],
    ),
    const RecipeModel(
      title: 'Protein Smoothie',
      category: 'Snack',
      imageUrl:
          'https://images.unsplash.com/photo-1553530666-ba11a7da3888?auto=format&fit=crop&w=600&q=80',
      calories: '192kcal',
      time: '5 min',
      difficulty: 'Easy',
      aiInsight: 'Quick protein hit for afternoon energy slump.',
      ingredients: [
        '1 scoop Protein Powder',
        '1/2 Banana',
        '1 cup Almond Milk',
        'Ice',
      ],
      instructions: [
        'Blend all ingredients until smooth',
      ],
    ),
    const RecipeModel(
      title: 'Salmon & Veggies',
      category: 'Dinner',
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=600&q=80',
      calories: '560kcal',
      time: '25 min',
      difficulty: 'Medium',
      aiInsight: 'Rich in Omega-3 fatty acids for heart and brain health.',
      ingredients: [
        '200g Salmon Fillet',
        '1 cup Broccoli Florets',
        '1/2 cup Carrots',
        '1 tbsp Olive Oil',
      ],
      instructions: [
        'Season salmon with salt and pepper',
        'Steam broccoli and carrots',
        'Pan-sear salmon for 4 minutes on each side',
      ],
    ),
    const RecipeModel(
      title: 'Protein Smoothie',
      category: 'Snack',
      imageUrl:
          'https://images.unsplash.com/photo-1553530666-ba11a7da3888?auto=format&fit=crop&w=600&q=80',
      calories: '192kcal',
      time: '5 min',
      difficulty: 'Easy',
      aiInsight: 'Quick protein hit for afternoon energy slump.',
      ingredients: [
        '1 scoop Protein Powder',
        '1/2 Banana',
        '1 cup Almond Milk',
        'Ice',
      ],
      instructions: [
        'Blend all ingredients until smooth',
      ],
    ),
  ].obs;

  final RxList<GroceryItem> groceryItems = <GroceryItem>[
    // Proteins
    GroceryItem(
      name: "Chicken Breast",
      category: "Proteins",
      quantity: "1.5 kg",
    ),
    GroceryItem(name: "Eggs", category: "Proteins", quantity: "12 pcs"),
    GroceryItem(
      name: "Greek Yogurt",
      category: "Proteins",
      quantity: "1 kg",
      isChecked: true,
    ),
    GroceryItem(name: "Salmon", category: "Proteins", quantity: "600 g"),
    GroceryItem(name: "Tofu", category: "Proteins", quantity: "400 g"),
    GroceryItem(
      name: "Whey Protein",
      category: "Proteins",
      quantity: "1 kg",
      isChecked: true,
    ),

    // Vegetables
    GroceryItem(name: "Broccoli", category: "Vegetables", quantity: "500 g"),
    GroceryItem(name: "Spinach", category: "Vegetables", quantity: "300 g"),
    GroceryItem(name: "Tomatoes", category: "Vegetables", quantity: "1 kg"),
    GroceryItem(
      name: "Cucumber",
      category: "Vegetables",
      quantity: "2 pcs",
      isChecked: true,
    ),
    GroceryItem(
      name: "Bell Peppers",
      category: "Vegetables",
      quantity: "3 pcs",
    ),
    GroceryItem(name: "Lemon", category: "Vegetables", quantity: "4 pcs"),

    // Healthy Fats
    GroceryItem(name: "Avocado", category: "Healthy Fats", quantity: "3 pcs"),
    GroceryItem(name: "Almonds", category: "Healthy Fats", quantity: "200 g"),
    GroceryItem(
      name: "Olive Oil",
      category: "Healthy Fats",
      quantity: "500 ml",
    ),
    GroceryItem(
      name: "Chia Seeds",
      category: "Healthy Fats",
      quantity: "150 g",
      isChecked: true,
    ),
  ].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<RecipeModel> get filteredRecipes {
    return recipes.where((recipe) {
      final matchesCategory =
          selectedCategory.value == "All" ||
          recipe.category == selectedCategory.value;
      final matchesSearch = recipe.title.toLowerCase().contains(
        searchQuery.value,
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<GroceryItem> get filteredGroceryItems {
    if (searchQuery.value.isEmpty) return groceryItems;
    return groceryItems
        .where((item) => item.name.toLowerCase().contains(searchQuery.value))
        .toList();
  }

  Map<String, List<GroceryItem>> get groupedGroceryItems {
    final Map<String, List<GroceryItem>> groups = {};
    for (var item in filteredGroceryItems) {
      if (!groups.containsKey(item.category)) {
        groups[item.category] = [];
      }
      groups[item.category]!.add(item);
    }
    return groups;
  }



  void toggleGroceryItem(GroceryItem item) {
    item.isChecked = !item.isChecked;
    groceryItems.refresh();
  }

  void removeGroceryItem(GroceryItem item) {
    groceryItems.remove(item);
  }
}

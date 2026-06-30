import 'package:aurahealth/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/meal_section/view/meal_plan_details.dart';
import 'package:aurahealth/feature/recipe_section/controller/recipe_controller.dart';
import 'package:aurahealth/feature/recipe_section/model/recipe_model.dart';

class RecipeSectionScreen extends StatelessWidget {
  const RecipeSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.put(RecipeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const CustomAppBar(title: 'Recipes', isBack: false),
      body: SafeArea(
        child: Column(
          children: [
            _buildToggleSwitch(controller),
            Obx(
              () => controller.selectedTab.value == 0
                  ? Column(
                      children: [
                        _buildSearchBar(controller),
                        _buildCategorySelector(controller),
                      ],
                    )
                  : _buildGroceryHeader(controller),
            ),
            Expanded(
              child: Obx(
                () => controller.selectedTab.value == 0
                    ? _buildRecipesGrid(controller)
                    : _buildGroceryView(controller),
              ),
            ),
            Obx(
              () => controller.selectedTab.value == 1
                  ? _buildExportButton(controller)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(RecipeController controller) {
    return Container(
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Stack(
        children: [
          Obx(() {
            final isRecipes = controller.selectedTab.value == 0;
            return AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: isRecipes
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedTab.value = 0;
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Obx(
                      () => Text(
                        'Recipes',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: controller.selectedTab.value == 0
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: controller.selectedTab.value == 0
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedTab.value = 1;
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Obx(
                      () => Text(
                        'Grocery',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: controller.selectedTab.value == 1
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: controller.selectedTab.value == 1
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(RecipeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: controller.searchController,
        onChanged: (value) {
          controller.searchQuery.value = value.toLowerCase();
        },
        decoration: InputDecoration(
          hintText: 'Search recipes',
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textSecondary.withValues(alpha: 0.6),
            size: 20.sp,
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Color(0xFFE4E7EC), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector(RecipeController controller) {
    final categories = ["All", "Breakfast", "Lunch", "Dinner", "Snack"];
    return Container(
      height: 38.h,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == category;
            return GestureDetector(
              onTap: () {
                controller.selectedCategory.value = category;
              },
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE4E7EC),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475467),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildRecipesGrid(RecipeController controller) {
    final recipes = controller.filteredRecipes;
    if (recipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 12.h),
            Text(
              "No recipes found",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.78,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => MealPlanDetails(recipe: recipe));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: const Color(0xFFF1F5F9), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                          child: Image.network(
                            recipe.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.surface,
                                child: Icon(
                                  Icons.fastfood_outlined,
                                  color: AppColors.textSecondary.withValues(
                                    alpha: 0.3,
                                  ),
                                  size: 28.sp,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        left: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            recipe.category,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.local_fire_department_rounded,
                            size: 14.sp,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            recipe.calories,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.access_time_rounded,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            recipe.time,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroceryHeader(RecipeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => RichText(
              text: TextSpan(
                style: const TextStyle(fontFamily: 'Inter'),
                children: [
                  TextSpan(
                    text: '${controller.groceryItems.length} ',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text: 'items',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              controller.selectedTimeFilter.value = value;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'Today', child: Text('Today')),
              const PopupMenuItem<String>(
                value: 'This Week',
                child: Text('This Week'),
              ),
              const PopupMenuItem<String>(
                value: 'This Month',
                child: Text('This Month'),
              ),
              const PopupMenuItem<String>(
                value: 'This Year',
                child: Text('This Year'),
              ),
            ],
            child: Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFFEAECF0),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.selectedTimeFilter.value,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF344054),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: const Color(0xFF667085),
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroceryView(RecipeController controller) {
    final grouped = controller.groupedGroceryItems;
    if (controller.groceryItems.isEmpty) {
      return Center(
        child: Text(
          "Your grocery list is empty!",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    final orderedCategories = [
      "Proteins",
      "Vegetables",
      "Healthy Fats",
      "Carbs/Pantry",
    ];
    final availableCategories = grouped.keys.toList();
    final categories = orderedCategories
        .where((c) => availableCategories.contains(c))
        .toList();
    for (var c in availableCategories) {
      if (!categories.contains(c)) {
        categories.add(c);
      }
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      itemCount: categories.length,
      itemBuilder: (context, catIndex) {
        final category = categories[catIndex];
        final items = grouped[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 8.h),
              child: Text(
                category,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D2939),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFEAECF0), width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isLast = index == items.length - 1;
                  return Column(
                    children: [
                      _buildGroceryListItem(item, controller),
                      if (!isLast)
                        Padding(
                          padding: EdgeInsets.only(left: 54.w),
                          child: const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF2F4F7),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGroceryListItem(GroceryItem item, RecipeController controller) {
    return GestureDetector(
      onTap: () {
        controller.toggleGroceryItem(item);
      },
      onLongPress: () {
        controller.removeGroceryItem(item);
        Get.snackbar(
          "Item Removed",
          "${item.name} has been removed from your list.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          borderRadius: 10.r,
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 2),
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.isChecked
                      ? const Color(0xFF41B058)
                      : const Color(0xFFD0D5DD),
                  width: 1.5,
                ),
                color: item.isChecked
                    ? const Color(0xFF41B058)
                    : Colors.transparent,
              ),
              child: item.isChecked
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                item.name,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: item.isChecked
                      ? const Color(0xFF98A2B3)
                      : const Color(0xFF344054),
                ),
              ),
            ),
            Text(
              item.quantity,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                color: const Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportButton(RecipeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            "Export Successful",
            "Your grocery list has been exported to your device.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primary,
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
            duration: const Duration(seconds: 2),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF41B058),
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "Export List",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

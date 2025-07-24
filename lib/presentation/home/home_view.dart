import 'package:flutter/material.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/menu_item.dart';
import 'widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  final List<MenuData> menuItems = [
    MenuData('assets/images/sushi.png', 'Sushi'),
    MenuData('assets/images/chicken.png', 'Chicken'),
    MenuData('assets/images/spaghetti.png', 'Spaghetti'),
    MenuData('assets/images/hamburger.png', 'Sandwich'),
  ];

  final Map<String, List<FoodItem>> foodItemsByMenu = {
    'Sushi': [
      FoodItem('Sushi Roll', 'assets/images/food-image-1.png', 22.0, 4.8),
      FoodItem('Salmon Sushi', 'assets/images/food-image-2.png', 25.0, 4.9),
      FoodItem('Fish Sushi', 'assets/images/fish.png', 20.0, 4.7),
    ],
    'Chicken': [
      FoodItem(
        'Fried Chicken & Vegetables',
        'assets/images/food-image-3.png',
        34.0,
        5.0,
      ),
      FoodItem(
        'Fried Chicken & Garlic',
        'assets/images/food-image-4.png',
        28.0,
        4.7,
      ),
      FoodItem('Chicken Special', 'assets/images/chicken.png', 30.0, 4.8),
    ],
    'Spaghetti': [
      FoodItem(
        'Classic Spaghetti',
        'assets/images/food-image-5.png',
        18.0,
        4.5,
      ),
      FoodItem(
        'Spaghetti Bolognese',
        'assets/images/food-image-6.png',
        21.0,
        4.6,
      ),
      FoodItem('Spaghetti Special', 'assets/images/spaghetti.png', 19.0, 4.4),
    ],
    'Sandwich': [
      FoodItem('Hamburger', 'assets/images/hamburger.png', 15.0, 4.3),
      FoodItem('Sandwich Deluxe', 'assets/images/food-image-7.png', 17.0, 4.2),
      FoodItem('Veggie Sandwich', 'assets/images/food-image-8.png', 16.0, 4.1),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specials',
                          style: AppTypography.kLight16.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Menu Offers\n',
                                style: AppTypography.kBold24.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'For You',
                                style: AppTypography.kBold24.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24.w,
                    backgroundImage: AssetImage('assets/images/profilePic.png'),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Menu Row
              SizedBox(
                height: 90.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: menuItems.length,
                  separatorBuilder: (context, i) => SizedBox(width: 16.w),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });
                    },
                    child: MenuItem(
                      image: menuItems[i].image,
                      label: menuItems[i].label,
                      selected: selectedIndex == i,
                    ),
                  ),
                ),
              ),
              // Filtered food items
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  itemCount:
                      foodItemsByMenu[menuItems[selectedIndex].label]?.length ??
                      0,
                  separatorBuilder: (context, i) => SizedBox(height: 16.h),
                  itemBuilder: (context, i) {
                    final item =
                        foodItemsByMenu[menuItems[selectedIndex].label]![i];
                    return FoodCard(item: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuData {
  final String image;
  final String label;
  const MenuData(this.image, this.label);
}

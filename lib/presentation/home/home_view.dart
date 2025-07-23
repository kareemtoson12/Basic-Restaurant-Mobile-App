import 'package:flutter/material.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  final List<_MenuData> menuItems = [
    _MenuData('assets/images/sushi.png', 'Sushi'),
    _MenuData('assets/images/chicken.png', 'Chicken'),
    _MenuData('assets/images/spaghetti.png', 'Spaghetti'),
    _MenuData('assets/images/hamburger.png', 'Sandwich'),
  ];

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
                    child: _MenuItem(
                      image: menuItems[i].image,
                      label: menuItems[i].label,
                      selected: selectedIndex == i,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuData {
  final String image;
  final String label;
  const _MenuData(this.image, this.label);
}

class _MenuItem extends StatelessWidget {
  final String image;
  final String label;
  final bool selected;
  const _MenuItem({
    required this.image,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: selected
              ? AppTypography.kBold16.copyWith(color: Colors.black)
              : AppTypography.kLight14.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}

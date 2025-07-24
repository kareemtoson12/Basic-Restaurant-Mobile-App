import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/presentation/home/cubit/home_cubit.dart';

import 'package:task/presentation/cart/cart_view.dart';
import 'package:task/presentation/home/widgets/food_item.dart';
import 'widgets/menu_item.dart';
import 'widgets/food_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeCubit(), child: const HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void openCart(BuildContext context, List<FoodItem> cartItems) async {
    try {
      final updatedCart = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CartView(cart: cartItems)),
      );

      if (updatedCart != null) {
        context.read<HomeCubit>().updateCartItems(updatedCart);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error opening cart: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: AppColors.kBackground,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text('Menu', style: AppTypography.kBold36),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.menuItems.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final item = state.menuItems[index];
                        return MenuItem(
                          image: item.image,
                          title: item.title,
                          isSelected: index == state.selectedMenuIndex,
                          onTap: () =>
                              context.read<HomeCubit>().selectMenuIndex(index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: 24.h),
                      itemCount:
                          state
                              .foodItemsByMenu[state
                                  .menuItems[state.selectedMenuIndex]
                                  .title]
                              ?.length ??
                          0,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final items =
                            state.foodItemsByMenu[state
                                .menuItems[state.selectedMenuIndex]
                                .title]!;
                        final item = items[index];
                        return FoodCard(
                          item: item,
                          onAdd: () =>
                              context.read<HomeCubit>().addToCart(item),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: state.cartItems.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Price', style: AppTypography.kMedium14),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(2)}',
                            style: AppTypography.kBold24,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => openCart(context, state.cartItems),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Text(
                          'Go to Cart',
                          style: AppTypography.kBold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}

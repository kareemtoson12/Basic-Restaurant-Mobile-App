import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/home/widgets/food_item.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/presentation/cart/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  final List<FoodItem> cart;
  const CartView({required this.cart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..initializeCart(cart),
      child: const CartViewContent(),
    );
  }
}

class CartViewContent extends StatelessWidget {
  const CartViewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is! CartLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: AppColors.kBackground,
          appBar: AppBar(
            title: const Text('Your Cart'),
            backgroundColor: AppColors.kBackground,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(
                context,
                context.read<CartCubit>().getCurrentItems(),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: state.groupedItems.length,
                    separatorBuilder: (context, i) => SizedBox(height: 12.h),
                    itemBuilder: (context, i) {
                      final entry = state.groupedItems.entries.elementAt(i);
                      final item = entry.key;
                      final count = entry.value;

                      return Dismissible(
                        key: ValueKey(item.name + item.price.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 24.w),
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 32.sp,
                          ),
                        ),
                        onDismissed: (_) =>
                            context.read<CartCubit>().deleteItem(item),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8DCC6),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Image.asset(
                                    item.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: AppTypography.kBold16,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: AppTypography.kBold14.copyWith(
                                        color: AppColors.kPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => context
                                        .read<CartCubit>()
                                        .decreaseItemCount(item),
                                  ),
                                  Text(
                                    count.toString(),
                                    style: AppTypography.kBold16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state.items.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Total Price', style: AppTypography.kMedium14),
                            Text(
                              '\$${state.totalPrice.toStringAsFixed(2)}',
                              style: AppTypography.kBold24,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implement checkout functionality
                          },
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
                            'Checkout',
                            style: AppTypography.kBold16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

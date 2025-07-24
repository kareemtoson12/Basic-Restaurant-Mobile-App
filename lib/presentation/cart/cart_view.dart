import 'package:flutter/material.dart';
import 'package:task/presentation/home/widgets/food_item.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/constants/app_colors.dart';

class CartView extends StatefulWidget {
  final List<FoodItem> cart;
  const CartView({required this.cart, Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<FoodItem> cart;

  @override
  void initState() {
    super.initState();
    cart = List.from(widget.cart);
  }

  double get totalPrice => cart.fold(0, (sum, item) => sum + item.price);

  Map<FoodItem, int> get groupedItems {
    final map = <FoodItem, int>{};
    for (final item in cart) {
      map[item] = (map[item] ?? 0) + 1;
    }
    return map;
  }

  void decreaseCount(FoodItem item) {
    setState(() {
      final idx = cart.indexWhere((e) => e == item);
      if (idx != -1) {
        cart.removeAt(idx);
      }
    });
  }

  void deleteItem(FoodItem item) {
    setState(() {
      cart.removeWhere((e) => e == item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: AppColors.kBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, cart),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(25.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: groupedItems.length,
                separatorBuilder: (context, i) => SizedBox(height: 12.h),
                itemBuilder: (context, i) {
                  final entry = groupedItems.entries.elementAt(i);
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
                    onDismissed: (_) => deleteItem(item),
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
                            decoration: BoxDecoration(
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
                                  style: AppTypography.kBold16.copyWith(
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.green,
                                      size: 16.sp,
                                    ),
                                    Text(
                                      item.price.toStringAsFixed(1),
                                      style: AppTypography.kLight14.copyWith(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      item.rating.toStringAsFixed(1),
                                      style: AppTypography.kLight14.copyWith(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (count > 1)
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, top: 4.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'x$count',
                                      style: AppTypography.kMedium16,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 20.sp,
                                      ),
                                      onPressed: () => decreaseCount(item),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: AppTypography.kBold18),
                Text(
                  ' ${totalPrice.toStringAsFixed(2)}',
                  style: AppTypography.kBold18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

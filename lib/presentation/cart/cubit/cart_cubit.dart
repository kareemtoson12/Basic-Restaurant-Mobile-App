import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/presentation/home/widgets/food_item.dart';

// States
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<FoodItem> items;

  const CartLoaded({required this.items});

  double get totalPrice => items.fold(0, (sum, item) => sum + item.price);

  Map<FoodItem, int> get groupedItems {
    final map = <FoodItem, int>{};
    for (final item in items) {
      map[item] = (map[item] ?? 0) + 1;
    }
    return map;
  }

  @override
  List<Object?> get props => [items];

  CartLoaded copyWith({List<FoodItem>? items}) {
    return CartLoaded(items: items ?? this.items);
  }
}

// Cubit
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void initializeCart(List<FoodItem> items) {
    emit(CartLoaded(items: List.from(items)));
  }

  void decreaseItemCount(FoodItem item) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = List<FoodItem>.from(currentState.items);
      final index = updatedItems.indexWhere((e) => e == item);

      if (index != -1) {
        updatedItems.removeAt(index);
        emit(CartLoaded(items: updatedItems));
      }
    }
  }

  void deleteItem(FoodItem item) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = List<FoodItem>.from(currentState.items)
        ..removeWhere((e) => e == item);
      emit(CartLoaded(items: updatedItems));
    }
  }

  void clearCart() {
    emit(const CartLoaded(items: []));
  }

  List<FoodItem> getCurrentItems() {
    if (state is CartLoaded) {
      return (state as CartLoaded).items;
    }
    return [];
  }
}

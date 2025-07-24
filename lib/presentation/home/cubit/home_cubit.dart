import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/presentation/home/widgets/food_item.dart';
import 'package:task/presentation/home/models/menu_data.dart';

// States
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final int selectedMenuIndex;
  final List<MenuData> menuItems;
  final Map<String, List<FoodItem>> foodItemsByMenu;
  final List<FoodItem> cartItems;

  const HomeLoaded({
    required this.selectedMenuIndex,
    required this.menuItems,
    required this.foodItemsByMenu,
    required this.cartItems,
  });

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

  @override
  List<Object?> get props => [
    selectedMenuIndex,
    menuItems,
    foodItemsByMenu,
    cartItems,
  ];

  HomeLoaded copyWith({
    int? selectedMenuIndex,
    List<MenuData>? menuItems,
    Map<String, List<FoodItem>>? foodItemsByMenu,
    List<FoodItem>? cartItems,
  }) {
    return HomeLoaded(
      selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
      menuItems: menuItems ?? this.menuItems,
      foodItemsByMenu: foodItemsByMenu ?? this.foodItemsByMenu,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

// Cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _initializeData();
  }

  void _initializeData() {
    final menuItems = [
      MenuData('assets/images/sushi.png', 'Sushi'),
      MenuData('assets/images/chicken.png', 'Chicken'),
      MenuData('assets/images/spaghetti.png', 'Spaghetti'),
      MenuData('assets/images/hamburger.png', 'Sandwich'),
    ];

    final foodItemsByMenu = {
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
        FoodItem(
          'Sandwich Deluxe',
          'assets/images/food-image-7.png',
          17.0,
          4.2,
        ),
        FoodItem(
          'Veggie Sandwich',
          'assets/images/food-image-8.png',
          16.0,
          4.1,
        ),
      ],
    };

    emit(
      HomeLoaded(
        selectedMenuIndex: 0,
        menuItems: menuItems,
        foodItemsByMenu: foodItemsByMenu,
        cartItems: [],
      ),
    );
  }

  void selectMenuIndex(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(selectedMenuIndex: index));
    }
  }

  void addToCart(FoodItem item) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedCart = List<FoodItem>.from(currentState.cartItems)
        ..add(item);
      emit(currentState.copyWith(cartItems: updatedCart));
    }
  }

  void updateCartItems(List<FoodItem> updatedCart) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(cartItems: updatedCart));
    }
  }
}

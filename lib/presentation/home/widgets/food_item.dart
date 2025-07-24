class FoodItem {
  final String name;
  final String image;
  final double price;
  final double rating;
  const FoodItem(this.name, this.image, this.price, this.rating);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          price == other.price &&
          rating == other.rating;

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ price.hashCode ^ rating.hashCode;
} 
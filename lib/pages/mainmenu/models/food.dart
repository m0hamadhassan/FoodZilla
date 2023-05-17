class Food {
  String imageUrl;
  String restaurantName;
  String name;
  // num score;
  num price;
  num quantity;
  // bool highlight;
  Food(
    this.imageUrl,
    this.name,
    this.restaurantName,
    this.price,
    this.quantity,
  );
}

final List<Food> recommendedFoods = [
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'FoodZilla',
    12,
    0,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    'FoodZilla',
    15,
    0,
  ),
];

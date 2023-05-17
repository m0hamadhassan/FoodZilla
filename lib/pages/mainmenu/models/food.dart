class Food {
  String imageUrl;
  String restaurantName;
  String name;

  num score;
  num price;
  num quantity;
  bool highlight;
  Food(this.imageUrl, this.name, this.restaurantName, this.score, this.price,
      this.quantity,
      {this.highlight = false});
}

final List<Food> recommendedFoods = [
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'FoodZilla',
    4.8,
    12,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    'FoodZilla',
    4.6,
    15,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    'FoodZilla',
    4.6,
    15,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    'FoodZilla',
    4.6,
    15,
    0,
    highlight: true,
  ),
];

class Food {
  String imageUrl;
  String desc;
  String name;

  num score;
  num price;
  num quantity;
  bool highlight;
  Food(this.imageUrl, this.name, this.desc, this.score, this.price,
      this.quantity,
      {this.highlight = false});
}

final List<Food> recommendedFoods = [
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'No1. in Sales',
    4.8,
    12,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    '',
    4.6,
    15,
    0,
  ),
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'No1. in Sales',
    4.8,
    12,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    '',
    4.6,
    15,
    0,
  ),
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'No1. in Sales',
    4.8,
    12,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    '',
    4.6,
    15,
    0,
  ),
  Food(
    'assets/pictures/margritaPizza.jpg',
    'Margarita Pizza',
    'No1. in Sales',
    4.8,
    12,
    0,
    highlight: true,
  ),
  Food(
    'assets/pictures/pepperoniPizza.jpg',
    'Pepperoni Pizza',
    '',
    4.6,
    15,
    0,
  ),
];

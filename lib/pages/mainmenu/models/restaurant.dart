import 'food.dart';

class Restaurant {
  String name;
  String label;
  String logoUrl;
  String desc;
  num score;
  Map<String, List<Food>> menu;

  Restaurant(
      this.name, this.label, this.logoUrl, this.desc, this.score, this.menu);
}

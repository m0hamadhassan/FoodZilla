import 'dart:typed_data';

class Food {
  Uint8List? imageBytes;
  String desc;
  String name;
  String restName;
  num score;
  num price;
  num quantity;
  bool highlight;

  Food(this.imageBytes, this.name, this.restName, this.desc, this.score,
      this.price, this.quantity,
      {this.highlight = false});
}

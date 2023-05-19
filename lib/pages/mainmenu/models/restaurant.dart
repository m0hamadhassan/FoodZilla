import 'dart:typed_data';

class Restaurant {
  final int restId;
  final Uint8List? imageBytes;
  final String restName;

  Restaurant(
     this.restId,
     this.imageBytes,
     this.restName,
  );
}

class ShopProductModel {
  // Constructor
  ShopProductModel({
    required this.id,
    required this.brand,
    required this.caption,
    required this.gender,
    required this.image,
    required this.price,
    required this.type,
    required this.color,
  });

  final int id;
  final String brand;
  final String caption;
  final String gender;
  final List<String> image;
  final int price;
  final String type;
  final String color;

  // Factory constructor for creating a new product from a Map
  factory ShopProductModel.fromMap(Map<String, dynamic> map) {
    print('Masuk Products Models -------------');
    return ShopProductModel(
      id: map['id'],
      brand: map['brand'],
      caption: map['caption'],
      gender: map['gender'],
      image: List<String>.from(
          map['image'] ?? []), // Ensure image is a list of strings
      price: map['price'],
      type: map['type'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    return {
      'id': id,
      'brand': brand,
      'caption': caption,
      'gender': gender,
      'image': image, // Ensure image is a list of strings
      'price': price,
      'type': type,
      'color': color,
    };
  }
}

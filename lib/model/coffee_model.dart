class CoffeeModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath; // Local image path

  CoffeeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  // Factory method to create a CoffeeModel from Firestore document
  factory CoffeeModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CoffeeModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'].toDouble() ?? 0.0,
      // Assuming Firestore has just the image name (e.g., "coffee_image.png")
      imagePath: 'images/${data['name'] ?? 'default_image'}.jpg', // Image stored locally
    );
  }
}

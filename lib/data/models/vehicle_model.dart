class VehicleModel {
  final String name;
  final String description;
  final String type;
  final int price;
  final List<String> images;
  final bool isAvailable;
  final String color;
  // final String ownerId = '';
  final List<String> categories;
  VehicleModel({
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.images,
    required this.isAvailable,
    required this.color,
    // required String ownerId,
    required this.categories,
  });

  // factory VehicleModel.fromJson(Map<String, dynamic> json) {
  //   return VehicleModel(
  //     id: json['_id'] ?? json['id'] ?? '',
  //     name: json['name'] ?? '',
  //     description: json['description'] ?? '',
  //     type: json['type'] ?? '',
  //     price: (json['price'] ?? 0).toDouble(),
  //     images: List<String>.from(json['images'] ?? []),
  //     isAvailable: json['isAvailable'] ?? true,
  //     ownerId: json['owner'] ?? '',
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'description': description,
  //     'type': type,
  //     'price': price,
  //     'images': images,
  //     'isAvailable': isAvailable,
  //     'owner': ownerId,
  //   };
  // }
}

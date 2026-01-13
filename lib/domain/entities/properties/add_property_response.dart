class AddPropertyResponse {
  String? type;
  String? status;
  String? name;
  String? description;
  String? address;
  num? price;
  int? buildingArea;
  int? landArea;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? imageUrl;

  AddPropertyResponse({
    this.type,
    this.status,
    this.name,
    this.description,
    this.address,
    this.price,
    this.buildingArea,
    this.landArea,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.imageUrl,
  });

  // Manual deserialisasi dari JSON
  factory AddPropertyResponse.fromJson(Map<String, dynamic> json) {
    return AddPropertyResponse(
      type: json['type'] as String?,
      status: json['status'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      price: json['price'] != null
          ? (json['price'] is String
                ? num.tryParse(json['price'] as String)
                : json['price'] as num)
          : null,
      buildingArea: json['building_area'] != null
          ? (json['building_area'] is String
                ? num.tryParse(json['building_area'] as String)?.toInt()
                : json['building_area'] as int)
          : null,
      landArea: json['land_area'] != null
          ? (json['land_area'] is String
                ? num.tryParse(json['land_area'] as String)?.toInt()
                : json['land_area'] as int)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      id: (json['id'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'status': status,
      'name': name,
      'description': description,
      'address': address,
      'price': price,
      'building_area': buildingArea,
      'land_area': landArea,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'id': id,
      'image_url': imageUrl,
    };
  }

  num? getPriceAsNum() {
    return price != null ? price : 0;
  }
}

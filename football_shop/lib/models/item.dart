import 'dart:convert';

List<Item> itemFromJson(String str) => 
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    final int? id;
    final String name;
    final int price; 
    final String description;
    final String thumbnail;
    final String category;
    final bool isFeatured;
    final String owner;

    Item({
        this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.owner,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"] is String ? int.parse(json["price"]) : json["price"], // Handle jika angka terkirim sbg string
        description: json["description"],
        thumbnail: json["thumbnail"] ?? "", 
        category: json["category"] ?? "Uncategorized",
        isFeatured: json["is_featured"] ?? false,
        owner: json["owner"] ?? "Unknown",
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
    };
}
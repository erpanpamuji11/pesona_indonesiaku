import 'package:flutter/widgets.dart';

class Wisata {
  final String name;
  final String address;
  final String provincy;
  final String category;
  final String description;
  final String imgUrl;

  Wisata({
    required this.name,
    required this.address,
    required this.provincy,
    required this.category,
    required this.description,
    required this.imgUrl,
  });

  Wisata.fromJson(Map<String, dynamic> json)
      : this(
          name: json["name"] as String,
          address: json["address"] as String,
          provincy: json["provincy"] as String,
          category: json["category"] as String,
          description: json["description"] as String,
          imgUrl: json["imgUrl"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "address": this.address,
      "provincy": this.provincy,
      "category": this.category,
      "description": this.description,
      "imgUrl": this.imgUrl,
    };
  }
}

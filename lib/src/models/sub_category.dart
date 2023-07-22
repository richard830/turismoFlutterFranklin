// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  String id;
  String name;
  String description;
  int idCategory;
  int quantity;
  List<SubCategory> toList = [];


  SubCategory({
    this.name,
    this.id,
    this.description,
    this.idCategory,
    this.quantity,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    idCategory: json["id_category"] is String ? int.parse(json['id_category']) : json['id_category'],
    quantity: json["quantity"],
  );

  SubCategory.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      SubCategory subCategory = SubCategory.fromJson(item);
      toList.add(subCategory);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "id_category": idCategory,
    "quantity": quantity,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();
  
}
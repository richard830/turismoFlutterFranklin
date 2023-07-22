import 'dart:convert';

//import 'package:hotel3/src/models/sub_category.dart';
import 'package:quenetur/src/models/sub_category.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {

  String id;
  String name;
  String description;
  String icon;
  List<Category> toList = [];

  Category({
    this.id,
    this.name,
    this.description,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
  );
  
  Category.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) { 
      Category category = Category.fromJson(item);
      toList.add(category);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "icon" : icon,
  };
}
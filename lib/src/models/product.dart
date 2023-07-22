import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {

  String id;
  String name;
  String description;
  //String logo;
  String image1;
  String image2;
  String image3;
  double price;
  int idSubcategory;
  int idCategory;
  String address;
  String phone;
  String whatsapp;
  String location;
  int quantity;
  List<Product> toList = [];

  Product({
    this.id,
    this.name,
    this.description,
    //this.logo,
    this.image1,
    this.image2,
    this.image3,
    this.price,
    this.idSubcategory,
    this.idCategory,
    this.address,
    this.phone,
    this.whatsapp,
    this.location,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    name: json["name"],
    description: json["description"],
    //logo: json["logo"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    price: json['price'] is String ? double.parse(json["price"]) : isInteger(json["price"]) ? json["price"].toDouble() : json["price"],
    idSubcategory: json["id_sub_category"] is String ? int.parse(json['id_sub_category']) : json['id_sub_category'],
    idCategory: json["id_category"] is String ? int.parse(json['id_category']) : json['id_category'],
    address: json["address"],
    phone: json["phone"],
    whatsapp: json["whatsapp"],
    location: json["location"],
    quantity: json["quantity"],
  );

  //NOTA: CUANDO SE PASAN LOS IDS HAY QUE IMPLEMENTAR ESTA LINEA SINO NO LEE LOS DATOS
  // LA LINEA DE IDCATEGORY EN EL FACTORY DECIA QUE NO ES COMPATIBLE STRING CON INT

  Product.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Product product = Product.fromJson(item);
      toList.add(product);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    //"logo": logo,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "price": price,
    "id_sub_category": idSubcategory,
    "id_category": idCategory,
    "address": address,
    "phone": phone,
    "whatsapp": whatsapp,
    "location": location,
    "quantity": quantity,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();
}

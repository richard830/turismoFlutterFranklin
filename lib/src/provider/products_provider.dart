import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:quenetur/src/api/environment.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/models/user.dart';


import 'package:http/http.dart' as http;

import 'package:path/path.dart';

class ProductsProvider {

  final String _url = Environment.API_QUENETUR;
  final String _api = '/api/products';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Product>> listProductsRecentAdd() async {
    try{
      Uri url = Uri.http(_url, '$_api/listProductsRecentAdd');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> listProductsRandom() async {
    try{
      Uri url = Uri.http(_url, '$_api/listProductsRandom');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> getBySubcategory(String idSubcategory) async {
    try{
      Uri url = Uri.http(_url, '$_api/findBySubcategory/$idSubcategory');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> getByCategory(String idCategory) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> ListahOTEL() async {
    try{
      Uri url = Uri.http(_url, '$_api/habitacion');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Product> eliminarHotel(String id)async{
  
    
    try {
      Uri url = Uri.http(_url, '$_api/eliminar/$id');
     
      final res = await http.delete(url);
      
      final data = json.decode(res.body);
      Product user = Product.fromJson(data);
      return user;

    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


  Future<List<Product>> getByCategoryAndProductName(String idCategory, String productName) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByCategoryAndProductName/$idCategory/$productName');
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.get(url, headers: headers);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */
      final data = json.decode(response.body);
      Product product = Product.fromJsonList(data);
      return product.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream> create(Product product, List<File> images) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }

      request.fields['product'] = json.encode(product);
      final response = await request.send(); // ENVIAR LA PETICION
      return response.stream.transform(utf8.decoder);
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }


}
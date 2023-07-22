import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:quenetur/src/api/environment.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/models/response_api.dart';
import 'package:quenetur/src/models/user.dart';
import 'package:http/http.dart' as http;


class CategoriesProvider {

  final String _url = Environment.API_QUENETUR;
  final String _api = '/api/categories';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async {
    try{
      Uri url = Uri.http(_url, '$_api/getAll');
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
      Category category = Category.fromJsonList(data);
      return category.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Category>> listCategory() async {
    try{
      Uri url = Uri.http(_url, '$_api/categoria');
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
      Category category = Category.fromJsonList(data);
      return category.toList;
    }
    catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json'
        //'Authorization': sessionUser.sessionToken
      };
      final response = await http.post(url, headers: headers, body: bodyParams);
      /*
      if(res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
       */

      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

}
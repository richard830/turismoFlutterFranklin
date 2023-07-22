import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/models/user.dart';
import 'package:quenetur/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:quenetur/src/provider/categories_provider.dart';
import 'package:quenetur/src/provider/products_provider.dart';
import 'package:quenetur/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/sub_category.dart';
import '../../../../provider/sub_categories_provider.dart';


class ClientProductsListController {

  BuildContext context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
  final SubCategoriesProvider _subCategoriesProvider = SubCategoriesProvider();

  List<Category> categories = [];
  List<SubCategory> subcategories = [];
  List<Product> product = [];
  List<Product> productRandom = [];
  //productRandom.shuffle(Random()); // Mezclar aleatoriamente los elementos


  Timer searchOnStoppedTyping;
  String productName = '';
  String categoryName = '';


  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
    getProductsRecentAdd();
    getProductsRandom();
    refresh();
  }

  void getProductsRecentAdd() async{
    product = await _productsProvider.listProductsRecentAdd();
    refresh();
  }

  void getProductsRandom() async{
    productRandom = await _productsProvider.listProductsRandom();
    refresh();
  }

  void getSubCategories() async {
    subcategories = await _subCategoriesProvider.getAll();
    refresh();

  }

  void onChangeText (String text) {
    Duration duration = const Duration(milliseconds: 800);

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      refresh();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName = text;

      refresh();
      print('TEXTO COMPLETO: $productName');
    });
  }

  void onChangeTextCategory (String text) {
    Duration duration = const Duration(milliseconds: 800);

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      refresh();
    }

    searchOnStoppedTyping = Timer(duration, () {
      categoryName = text;

      refresh();
      print('TEXTO COMPLETO: $categoryName');
    });
  }

  Future<List<Product>> getProductsBySubcategory(String idSubcategory, String productName) async {

    if (productName.isEmpty) {
      return await _productsProvider.getByCategory(idSubcategory);
    }
    else {
      return await _productsProvider.getByCategoryAndProductName(idSubcategory, productName);

    }

  }

  Future<List<Product>> getProducts(String idCategory, String productName) async {

    if (productName.isEmpty) {
      return await _productsProvider.getByCategory(idCategory);
    }
    else {
      return await _productsProvider.getByCategoryAndProductName(idCategory, productName);

    }

  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),),
        context: context,
        builder: (context) => ClientsProductsDetailPage(product: product,)
    );
  }

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void goToHomePage() {
    Navigator.pushNamed(context, 'home');
  }

  void goToCategoriesClientPage() {
    Navigator.pushNamed(context, 'client/categories/list');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/list');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

}
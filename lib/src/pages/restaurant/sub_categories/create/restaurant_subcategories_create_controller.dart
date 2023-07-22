import 'package:flutter/material.dart';
import 'package:quenetur/src/models/response_api.dart';
import 'package:quenetur/src/models/user.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/utils/my_snackbar.dart';
import 'package:quenetur/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../../models/sub_category.dart';
import '../../../../provider/categories_provider.dart';
import '../../../../provider/sub_categories_provider.dart';



class RestaurantSubCategoriesCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final SubCategoriesProvider _subCategoriesProvider = SubCategoriesProvider();

  User user;
  SharedPref sharedPref = SharedPref();

  List<Category> categories = [];
  String idCategory; //ALMACENAR EL ID DE LA CATEGORIA SELECCIONADA
  //ProgressDialog _progressDialog;


  final CategoriesProvider _categoriesProvider = CategoriesProvider();

  SubCategory get subCategory => null;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //_progressDialog = ProgressDialog(context: context);
    user =User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _subCategoriesProvider.init(context, user);
    getCategories();
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void createSubCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona la categoria del producto');
      return;
    }

    SubCategory subcategory = SubCategory(
      name: name,
      description: description,
      idCategory: int.parse(idCategory)

    );

    //_progressDialog.show(max: max, msg: msg)

    //Stream stream = (await _subCategoriesProvider.create(subCategory)) as Stream;
    // stream.listen((event) {
    //
    // });

    ResponseApi responseApi = await _subCategoriesProvider.create(subcategory);

    MySnackbar.show(context, responseApi.message);

    if (responseApi.success) {
      nameController.text = '';
      descriptionController.text = '';
    }

    print('Formulario Subcategoria, ${subcategory.toJson()}');

  }


}
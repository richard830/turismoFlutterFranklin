import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:quenetur/src/utils/my_colors.dart';



import '../../../../models/category.dart';
import '../../../../models/sub_category.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({Key key}) : super(key: key);

  @override
  State<RestaurantProductsCreatePage> createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {

  final RestaurantProductsCreateController _con = RestaurantProductsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  bool displayCategory = false;
  bool displaySubCategory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Habitación'),
      ),
      body: ListView( // EL LISTVIEW ES PARA HACER SCROOLL EN DIMENSIONES MAS PEQUENAS DE CELULARES
        children:[
          const SizedBox(height: 30),
          _textFieldName(),
          _textFieldDescription(),
          _textFieldPrice(),
          _textFieldAddress(),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3),
                //_cardImage(_con.imageLogo, 4),
              ],
            ),
          ),
          _dropDownCategories(_con.categories),
          _dropDownSubCat(_con.subcategories),
          _textFieldPhone(),
          _textFieldWhatsapp(),
          _textFieldLocation(),
        ],
      ),
      bottomNavigationBar:  _buttonCreate(),
    );
  }

  Widget _textFieldName() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 2,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Nombre del producto',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(5),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.local_hotel_rounded,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  }

  Widget _textFieldPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: MyColors.primarycolor,)
        ),
      ),
    );
  }



  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    for (var category in categories) {
      list.add(DropdownMenuItem(
          child: Text(category.name),
          value: category.id,
      ));
    }

    return list;
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        borderRadius:  const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primarycolor,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Categorias',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),

                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primarycolor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: const Text(
                    'Selecciona la categoria',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(categories),
                  value: _con.idCategory,
                  onChanged: (option) {
                    setState(() {
                      _con.idCategory = option; //ESTABLECIENDO EL VALOR SELECIONADO
                      print('Categoria seleccionada $option');
                      _con.getSubCategoriesById(option);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  List<DropdownMenuItem<String>> _dropDownItemsSubCat(List<SubCategory> subcategories) {
    List<DropdownMenuItem<String>> list = [];
    _con.getSubCategoriesById;
    for (var subcategory in subcategories) {
      list.add(DropdownMenuItem(
        child: Text(subcategory.name),
        value: subcategory.id,
      ));
    }

    return list;
  }

  Widget _dropDownSubCat(List<SubCategory> subcategories) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 33, vertical:10),
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        borderRadius:  const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primarycolor,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'SubCategorias',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),

                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primarycolor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: const Text(
                    'Selecciona la SubCategoria',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  ),
                  //items: _dropDownItems(categories),
                  items: _dropDownItemsSubCat(subcategories),
                  value: _con.idSubCategory,
                  onChanged: (option) {
                    setState(() {
                      _con.idSubCategory = option; //ESTABLECIENDO EL VALOR SELLECIONADO
                      print('SubCategoria seleccionada $option');
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget _textFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
          hintText: 'Descripción del servicio o establecimiento',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.description,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.addressController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
          hintText: 'Dirección del establecimiento',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.location_city,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldWhatsapp() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.whatsappController,
        maxLines: 2,
        maxLength: 255,
        decoration: InputDecoration(
          hintText: 'Link de Whatsapp',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.whatsapp_sharp,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Teléfono',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.phone,
              color: MyColors.primarycolor,)
        ),
      ),
    );
  }

  Widget _textFieldLocation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.locationController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
          hintText: 'Link Google Maps ',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(5),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
      ? Card(
        elevation: 5.0,
        child: SizedBox(
          height: 140,
            width: MediaQuery.of(context).size.width * 0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
      : Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: const Image(
              image: AssetImage('assets/img/add_image.png'),
          ),
        ),
      ),
    );
  }

  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        child: const Text('Crear producto'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primarycolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh() {
    setState(() {
    });
  }
}

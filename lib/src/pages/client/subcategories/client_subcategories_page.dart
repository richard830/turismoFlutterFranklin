import 'dart:convert';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/models/sub_category.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'package:quenetur/src/widgets/no_data_widget.dart';
import '../../../provider/sub_categories_provider.dart';
import '../../../utils/myBottomNavigationBar.dart';
import 'client_subcategories_controller.dart';

class ClientSubcategoriesListPage extends StatefulWidget {
  const ClientSubcategoriesListPage({Key key, Product product }) : super(key: key);

  @override
  _ClientSubcategoriesListPageState createState() => _ClientSubcategoriesListPageState();
  static const String routeName = 'client/subcategories/list';

}

class _ClientSubcategoriesListPageState extends State<ClientSubcategoriesListPage> {
  final ClientSubcategoriesController _con = ClientSubcategoriesController();
  List<Color> coloresAleatorios = List.filled(10, Colors.grey);
  //SubCategory subcategories;
  final SubCategoriesProvider _subCategoriesProvider = SubCategoriesProvider();
  List<Category> categories = [];
  List<SubCategory> subcategories = [];
  String idCategory;//ALMACENAR EL ID DE LA CATEGORIA SELECCIONADA
  String idSubCategory;
  String option;
  //String categoryName;

  final List<Color> colores = [
    Colors.red,       Colors.blue,
    Colors.green,     Colors.brown,
    Colors.orange,    Colors.purple,
    Colors.pink,      Colors.indigo,
    Colors.teal,
    //Colors.cyanAccent, Colors.yellow,
  ];
  int _current = 0;


  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for(var i=0; i<list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String option = ModalRoute.of(context).settings.arguments;
    //String categoryName = ModalRoute.of(context).settings.arguments;
    setState(() {
      _con.idCategory = option;
      //_con.categoryName = categoryName;
      print('Categoria seleccionada $option');
      _con.getSubCategoriesById(option);
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.subcategories?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            //actions: [_shoppingBag()],
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    Padding(
                    padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_back_ios, size: 28, color: MyColors.primarycolor,)),
                    Divider(),
                    Text(_con.idCategory, style: TextStyle(
                      color: MyColors.primarycolor ,fontSize: 30, fontWeight: FontWeight.w500,
                    ),
                    ),
                  ],
                ),
                _textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primarycolor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.subcategories.length, (index) {
                return Tab(
                  child: Text(_con.subcategories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: _con.subcategories.map((
              SubCategory subcategory,
              ) {
            return FutureBuilder(
              future: _con.getProductsBySubcategory(subcategory.id, _con.productName),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return GridView.builder(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.70),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return _cardProduct(snapshot.data[index]);
                        });
                  } else {
                    return const NoDataWidget();
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }


  Widget _listgetlistitem(List<SubCategory> subcategories) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return ListTile(
                  title: Text(subcategory.name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(product);
        print('Hola producto $product');
      },
      child: SizedBox(
        //height: 235,
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            elevation: 20.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 265,
              //color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //esta funcion los textos se ubican en la parte izquiera de la pantalla
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        height: 175,
                        width: double.maxFinite,
                        image: product.image1 != null
                            ? NetworkImage(product.image1)
                            : const AssetImage('assets/img/pizza2.png' ),
                        fit: BoxFit.cover,
                        // el fit cover me ayuda a que se posiscione en todo el container es mejor este
                        fadeInDuration: const Duration(milliseconds: 50),
                        placeholder: const AssetImage('assets/img/no-image.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //margin: const EdgeInsets.symmetric(horizontal: 20,),
                            child:Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                product.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NimbusSans'),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: MyColors.primaryOpacityColor,
                                ),
                                Container(
                                  width: 125,
                                  //color: Colors.blue,
                                  child: Text(
                                    product.address ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NimbusSans'),
                                  ),
                                ),
                                // Spacer(),
                                // Container(
                                //   alignment: Alignment.centerRight,
                                //   child: const Icon(
                                //     Icons.remove_red_eye,
                                //     color: Colors.green,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }


  Widget _textVerTodo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'Ver Todo', style:
      TextStyle(
        fontSize: 17,
        fontWeight:  FontWeight.w500,
        color: Colors.green,
      ),
      ),
    );
  }

  Widget _textCualquiera(String textApp, double fontSize) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Text(
        textApp,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight:  FontWeight.bold,
          color: Colors.black87,
        ),textAlign: TextAlign.start,
      ),
    );
  }


  Widget _textFieldSearch() {
    return Container(
      padding: EdgeInsets.only(bottom: 15, top: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: _con.onChangeText,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xfff6f8fe),
            hintText: 'Buscar...',
            suffixIcon: Icon(Icons.search_sharp,size: 30, color: Color(0xff9ca4ab)),
            hintStyle: TextStyle(fontSize: 19, color: Color(0xff9ca4ab)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)),
            //borderSide: BorderSide(color: Colors.grey[300])),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color:Colors.white)),
            //borderSide: BorderSide(color: Colors.grey[300])),
            contentPadding:  EdgeInsets.all(15)),
      ),
    );
  }

  Widget _titleQuenetur() {
    return  Container(
      margin: const EdgeInsets.only(left: 20, top: 15 ),
      alignment: Alignment.centerLeft,
      child: Padding(padding: EdgeInsets.only(left: 5,),
        //child: Padding(padding: EdgeInsets.only(left: 45,),
        child: Text("SubCategorias",
          style: TextStyle(fontSize: 25,
            fontWeight: FontWeight.bold,
            color: MyColors.primarycolor,
          ),
        ),
      ),
      //child: Icon(Icons.sort, size: 40, color: Colors.indigo,),

      // Image.asset(
      //   'assets/img/menu.png',
      //   width: 20,
      //   height: 20,
      // ),
    );
  }

  // widegt de busqyeda de hotele
  /*
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Buscar aquí..",
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      //Icons.camera_alt,
                      size: 27,
                      color: MyColors.primarycolor,
                    )
                  ],
                ),
              ),
              */



  void refresh() {
    setState(() {
      // CTRL+ S
    });
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/models/carousel.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/models/sub_category.dart';
import 'package:quenetur/src/pages/client/subcategories/client_subcategories_page.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'package:quenetur/src/widgets/no_data_widget.dart';
import '../../../utils/icono_string_util.dart';
import '../../../utils/myBottomNavigationBar.dart';
import 'client_categories_list_controller.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _ClientCategoriesPageState createState() => _ClientCategoriesPageState();
}

class _ClientCategoriesPageState extends State<CategoryPage> {
  final ClientCategoriesListController _con = ClientCategoriesListController();
  final List<String> datos = ['Dato 1', 'Dato 2', 'Dato 3', 'Dato 4', 'Dato 5'];

  List<Color> coloresAleatorios = List.filled(10, Colors.grey);
  List<SubCategory> subcategories = [];


  final List<Color> colores = [
    Colors.red,       Colors.blue,
    Colors.green,     Colors.brown,
    Colors.orange,    Colors.purple,
    Colors.pink,      Colors.indigo,
    Colors.teal,
    //Colors.cyanAccent, Colors.yellow,
  ];

  int _current = 0;

  get option => null;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for(var i=0; i<list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.arrow_back_ios, size: 23, color: MyColors.primarycolor,),
        ),
        title: Text('Categorias', style: TextStyle(
          color: MyColors.primarycolor ,fontSize: 20, fontWeight: FontWeight.w500,
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 60,),
                    ),
                    const SizedBox(height: 30,),
                    // const Text('Categorias', style: TextStyle(
                    //   color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500,
                    // ),
                    // )
                  ],
                ),

              ),
              */
              onChangeTextCategory(),
              //_categoryExpansionTile(_con.categories),
              //_subCategoryExpansionTile(_con.subcategories),
              //_dropDownCategories(_con.categories),
              //_dropDownSubCat(_con.subcategories),
              _listarCategories()
              //Container(child: _listarCategories()),

              //_listarCategories(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar()
    );
  }


  Widget _listarCategories() {
    //final random = Random();
    //final color = colores[random.nextInt(colores.length)];
    return Column(
      children: List<Widget>.generate(_con.categories.length, (index) {
        coloresAleatorios[index] = _generarColorAleatorio();
        String opt;
        return SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric (horizontal: 25),
            child: Padding(padding: EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                        var option = _con.categories[index].id; //ESTABLECIENDO EL VALOR SELECIONADO
                        var categoryName = _con.categories[index].name; //ESTABLECIENDO EL VALOR SELECIONADO
                        print('Categoria seleccionada $option');
                        print('Categoria seleccionada $categoryName');
                        _con.getSubCategoriesById(option);
                        // Navigator.of(context).pushNamed(ClientSubcategoriesListPage.routeName,
                        //     arguments: jsonEncode(subcategories[index].idCategory));
                        Navigator.pushNamed(context, 'client/subcategories/list', arguments: option);
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 60, width: 60,
                            color: Color(0xfff6f8fe),
                            //color: coloresAleatorios[index],
                            //color: MyColors.primarycolor,
                            child: getIconCategories(_con.categories[index].icon ?? '')),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        width: 230,
                        child: Text(_con.categories[index].name ?? '',
                          maxLines: 2,
                          //soverflow: TextOverflow.ellipsis,
                          semanticsLabel: opt = _con.categories[index].id,
                          style: TextStyle(
                              fontSize: 16, color: Colors.black
                          )),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: MyColors.primaryOpacityColor ,size: 23,),
                    ],
                  ),
                ),
              ),

              /*
              Text(
                _con.categories[index].name ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),



              */



            /*
            Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 60, width: 60,
                                  color: coloresAleatorios[index],
                                  //color: MyColors.primarycolor,
                                  child: getIconCategories(_con.categories[index].icon ?? '')),
                        ),
                        SizedBox(width: 20,),
                        Text(_con.categories[index].name ?? '',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black
                          ),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.green[400], size: 23,),
                      ],
                    ),
                ),
                Divider(color: Colors.green[300]),
              ],

            ),
            */
          ),

          //scrollDirection: Axis.vertical,

          /*
                child: Row(
                  children: [
                    //for(int i=1; i < 8; i++)
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      padding: EdgeInsets.symmetric( horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: getIcon(_con.categories[index].icon ?? ''),
                          ),
                          //Icon(Icons.home, size: 25,color: Colors.black,),


                          // Image.asset(
                          //   //use i variable to change pictures in loop
                          //   "assets/img/waze.png",
                          //   width: 40,
                          //   height: 40,
                          // ),
                          Text(_con.categories[index].name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blueGrey,
                              ),textAlign: TextAlign.end)
                        ],),
                    )
                  ],
                ),
                */

        );
      }),
    );

    //length: _con.categories?.length,
  }

  Widget _listarsubCategories() {
    //final random = Random();
    //final color = colores[random.nextInt(colores.length)];
    return Column(
      children: List<Widget>.generate(_con.subcategories.length, (index) {
        coloresAleatorios[index] = _generarColorAleatorio();
        return SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric (horizontal: 15),
            child: ExpansionTile(
              title: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: 60, width: 60,
                          color: coloresAleatorios[index],
                          //color: MyColors.primarycolor,
                          //child: getIconCategories(_con.categories[index].icon ?? '')
                        ),
                    ),
                    SizedBox(width: 20,),
                    Text(_con.categories[index].name ?? '',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black
                      ),),
                    // Spacer(),
                    // Icon(Icons.arrow_forward_ios, color: Colors.green[400], size: 23,),
                  ],
                ),
              ),

              /*
              Text(
                _con.categories[index].name ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              */
              children: [

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _con.categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_con.categories[index].name),
                    );
                  },
                ),
              ],
            ),



            /*
            Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 60, width: 60,
                                  color: coloresAleatorios[index],
                                  //color: MyColors.primarycolor,
                                  child: getIconCategories(_con.categories[index].icon ?? '')),
                        ),
                        SizedBox(width: 20,),
                        Text(_con.categories[index].name ?? '',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black
                          ),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.green[400], size: 23,),
                      ],
                    ),
                ),
                Divider(color: Colors.green[300]),
              ],

            ),
            */
          ),

          //scrollDirection: Axis.vertical,

          /*
                child: Row(
                  children: [
                    //for(int i=1; i < 8; i++)
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      padding: EdgeInsets.symmetric( horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: getIcon(_con.categories[index].icon ?? ''),
                          ),
                          //Icon(Icons.home, size: 25,color: Colors.black,),


                          // Image.asset(
                          //   //use i variable to change pictures in loop
                          //   "assets/img/waze.png",
                          //   width: 40,
                          //   height: 40,
                          // ),
                          Text(_con.categories[index].name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blueGrey,
                              ),textAlign: TextAlign.end)
                        ],),
                    )
                  ],
                ),
                */

        );
      }),
    );

    //length: _con.categories?.length,
  }

  Widget testdatoslist() {
    return Scaffold(
      body: _con.categories.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _con.categories.length,
        itemBuilder: (context, index) {
          final categoria = _con.categories[index];
          var idcategory = _con.categories[index].id;

          //final subcategoria = _con.subcategories[index];
          return ExpansionTile(
            title: GestureDetector(
              onTap: () {
                var option = _con.idCategory ; //ESTABLECIENDO EL VALOR SELECIONADO
                print('Categoria seleccionada $option');
                _con.getSubCategoriesById(option);
              },
                child: Text(categoria.name + categoria.id)),
            children: [
              Column(
                children: [
                  Container(child: popo()),


                  // for (var subcategoria in _con.subcategories)
                  // //for (var subcategoria in categoria.toList)
                  //   Text(subcategoria.id),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget popo () {
    _con.getSubCategoriesById;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _con.subcategories.length,
      itemBuilder: (context, index) {
        final item = subcategories[index];

        return ListTile(
          title: Text(item.name),
          onTap: () {
            //item.llamarFuncion();
          },
        );
      },
    );
  }

  void _mostrarListaDatos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Lista de datos'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: datos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(datos[index]),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Color _generarColorAleatorio() {
    final random = Random();
    return colores[random.nextInt(colores.length)];
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


  Widget _shoppingBag() {
    return GestureDetector(
      onTap: _con.goToOrderCreatePage,
      child: Stack(
        // UN ELEMENTO ENCIMA DEL OTRO ( STACK)
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 13),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
              right: 16,
              top: 15,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ))
        ],
      ),
    );
  }

  Widget onChangeTextCategory() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      margin:  EdgeInsets.symmetric(horizontal: 20),
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
        child: Text("QUENETUR",
          style: TextStyle(fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
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

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 15 ),
        alignment: Alignment.centerLeft,
        child: Padding(padding: EdgeInsets.only(left: 45,),
          child: Text("QUENETUR",
            style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ),
        //child: Icon(Icons.sort, size: 40, color: Colors.indigo,),

        // Image.asset(
        //   'assets/img/menu.png',
        //   width: 20,
        //   height: 20,
        // ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primarycolor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : const AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: _con.goToUpdatePage,
            title: const Text('Editar perfil'),
            trailing: const Icon(Icons.edit_outlined),

          ),
          /* ListTile(
            onTap: _con.goToOrderCreatePage,
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ), */
          _con.user != null
              ? _con.user.roles.length > 1
              ? ListTile(
            onTap: _con.goToRoles,
            title: const Text('Seleccionar rol'),
            trailing: const Icon(Icons.person_outline),
          )
              : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  Widget _bannerAds() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16, right: 16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 400,
            //width: MediaQuery.of(context).size.width,
            height: 190,
            //color: Colors.blue,
            child: Swiper(
              onIndexChanged: (index) {
                setState(() {
                  _current = index ;
                });
              },
              autoplay: true,
              layout: SwiperLayout.DEFAULT,
              itemCount: carousels.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(
                            carousels[index].image,
                          ),
                          fit: BoxFit.cover)
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: map<Widget> (
                    carousels, (index, image) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 6, width: 6,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Colors.indigo
                            : Colors.grey),
                  );
                }),
              ),

              Text('Más..')
            ],
          )

        ],
      ),
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

  Widget _bannerAdsTest() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: Swiper(
        onIndexChanged: (index){
          refresh();
        },
        autoplay: true,
        layout: SwiperLayout.DEFAULT,
        //itemCount: ,
        itemBuilder: (BuildContext context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('assets/img/burger2.png'),
                  fit: BoxFit.cover,
                )
            ),
          );
        },
      ),
    );
  }

  Widget _categoriesTitles() {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i=1; i < 8; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    //use i variable to change pictures in loop
                    "assets/images/$i.png",
                    width: 40,
                    height: 40,
                  ),
                  Text("Sandal", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: MyColors.primarycolor,
                  ),)
                ],),
            )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {
      // CTRL+ S
    });
  }
}

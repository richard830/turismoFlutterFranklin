import 'dart:convert';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/models/carousel.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'package:quenetur/src/utils/utils.dart';
import 'package:quenetur/src/widgets/no_data_widget.dart';

import '../../../../utils/icono_string_util.dart';
import '../../../../utils/myBottomNavigationBar.dart';
import '../../../../widgets/home_app_bar.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  final ClientProductsListController _con = ClientProductsListController();
  List<Color> coloresAleatorios = List.filled(10, Colors.grey);

  final List<Color> colores = [
    Colors.red,       Colors.blue,
    Colors.green,     Colors.brown,
    Colors.orange,    Colors.purple,
    Colors.pink,      Colors.indigo,
    Colors.teal,
    //Colors.cyanAccent, Colors.yellow,
  ];
  int _current = 0;

  Product get productRandom => null;
  Product get product => null;


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

      /*appBar: AppBar(
        //automaticallyImplyLeading: true,
        // leading: Icon(Icons.sort, size: 40, color: Colors.indigo,),
        backgroundColor: Colors.white,
        //actions: [_shoppingBag()],
        flexibleSpace: Column(
          children: [
            const SizedBox(height: 20),

            _titleQuenetur()
            //_menuDrawer(),
            //_textFieldSearch()
          ],
        ),
      ),
      */
      //drawer: _drawer(),
      body: ListView(children: [
        SafeArea(child: _header()),
        Container(
        // altura temporal
          //height: 700,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
          color: Colors.white,
          //color: Color(0xFFEDECF2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
          child: Column(
            children: [
              //_principal123(),

              // Buscar WIDGET
              Container(child: _textFieldSearch(),),

              // Baner Ads
              _bannerAds(),
               _categoriesIcons(),
               SizedBox(height: 20,),

              //_frequently(),
               //SizedBox(height: 20,),
               //_travel(),
              // SizedBox(height: 20,),

              //Text Categories
              //_textCualquiera('Categorias', 20),
              //_textCualquiera('Vamos a Encontrar!', 20),

              //Tabs y categories widget
             //_tabControllerCategories(),

              //text services
              //text ver todo
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textCualquiera('Servicios', 18.5),
                  _textVerTodo(),
                ],
              ),

               */

              // items de subactegorias o servicios
              //_tabControllerServices(),
              _textRecentAdd(),
              _listProductRecentAdd(product),
              SizedBox(height: 23,),
              _textGetProducts(),
              _listProductGetAllRandom(productRandom),
              //_travel()
              //Container(child: _tabControllerServices()),

              // Items Widget
              //ItemsWidget(),
            ],
          ),
      ),
      ]),
      bottomNavigationBar: MyBottomNavigationBar()
    );
  }

  Widget _textCualquiera(String textApp, double fontSize) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Container(
        // frequentlyvisitedPNu (1:446)
        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 80*fem, 0*fem),
        child: Text(
          textApp,
          textAlign: TextAlign.center,
          // style: SafeGoogleFont (
          //   'Plus Jakarta Sans',
          //   fontSize: fontSize,
          //   //fontSize: 18*ffem,
          //   fontWeight: FontWeight.w700,
          //   height: 1.4444444444*ffem/fem,
          //   letterSpacing: 0.09*fem,
          //   color: Color(0xff111111),
          // ),
        ),
      ),
    );
  }

  Widget _textRecentAdd() {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // titlefC1 (1:445)
      margin: EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 20*fem),
      width: double.infinity,
      height: 26*fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // frequentlyvisitedPNu (1:446)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 80*fem, 0*fem),
            child: Text(
              'Recientes agregados',
              textAlign: TextAlign.center,
              // style: SafeGoogleFont (
              //   'Plus Jakarta Sans',
              //   fontSize: 18*ffem,
              //   fontWeight: FontWeight.w700,
              //   height: 1.4444444444*ffem/fem,
              //   letterSpacing: 0.09*fem,
              //   color: Color(0xff111111),
              // ),
            ),
          ),
          Container(
            // slidertKf (1:447)
            margin: EdgeInsets.fromLTRB(0*fem, 9*fem, 0*fem, 9*fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // dotDcq (1:448)
                  width: 24*fem,
                  height: 8*fem,
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(100*fem),
                    color: Color(0xff009b8d),
                  ),
                ),
                SizedBox(
                  width: 8*fem,
                ),
                Container(
                  // dotYf7 (1:449)
                  width: 8*fem,
                  height: 8*fem,
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(4*fem),
                    color: Color(0xffd1d8dd),
                  ),
                ),
                SizedBox(
                  width: 8*fem,
                ),
                Container(
                  // dotgFX (1:450)
                  width: 8*fem,
                  height: 8*fem,
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(4*fem),
                    color: Color(0xffd1d8dd),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listProductRecentAdd(Product product) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    //final random = Random();
    //final color = colores[random.nextInt(colores.length)];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(_con.product.length, (index) {
            coloresAleatorios[index] = _generarColorAleatorio();
            String opt;
            return GestureDetector(
              onTap: () {
                var product = jsonEncode(_con.product[index]);
                print(product);
                _con.openBottomSheet(_con.product[index]);
                print(product);
              },
              child: Column(
                children: [
                  Container(
                    // frequentlyvisited9UZ (1:407)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    width: 172*fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // itemspsX (1:408)
                          width: double.infinity,
                          height: 232*fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // listNPF (1:409)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                width: 156*fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8*fem),
                                      child: FadeInImage(
                                        width: double.infinity,
                                        height: 150*fem,
                                        image: _con.product[index].image1 != null
                                            ? NetworkImage(_con.product[index].image1)
                                            : const AssetImage('assets/img/pizza2.png' ),
                                        fit: BoxFit.cover,
                                        // el fit cover me ayuda a que se posiscione en todo el container es mejor este
                                        fadeInDuration: const Duration(milliseconds: 50),
                                        placeholder: const AssetImage('assets/img/no-image.png'),
                                      ),
                                    ),
                                    Container(
                                      //color: Color(0xfff6f8fe),
                                      // autogrouptn5kH8q (h4qteTpQQGEPtLCJjtN5K)
                                      padding: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 0*fem),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // group1000003467cwo (1:416)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                            width: 150*fem,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  //color: Colors.blue,
                                                  // tahitibeachxEy (1:417)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                                  child: Text(
                                                    _con.product[index].name ?? '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    // style: SafeGoogleFont (
                                                    //   'Plus Jakarta Sans',
                                                    //   fontSize: 14*ffem,
                                                    //   fontWeight: FontWeight.w600,
                                                    //   height: 1.5714285714*ffem/fem,
                                                    //   letterSpacing: 0.07*fem,
                                                    //   color: Color(0xff111111),
                                                    // ),
                                                  ),
                                                ),
                                                Container(
                                                  // group1000003465FUy (1:418)
                                                  padding: EdgeInsets.fromLTRB(2.33*fem, 0*fem, 0*fem, 0*fem),
                                                  width: double.infinity,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        // bxsmap11aXF (1:420)
                                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.33*fem, 0*fem),
                                                        width: 9.33*fem,
                                                        height: 11.67*fem,
                                                        child: Image.asset(
                                                          'assets/img/bxs-map-1-1.png',
                                                          width: 9.33*fem,
                                                          height: 11.67*fem,
                                                        ),

                                                      ),
                                                      Container(
                                                        width: 132*fem,
                                                        child: Text(
                                                          _con.product[index].address ?? '',
                                                          //maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          // style: SafeGoogleFont (
                                                          //   'Plus Jakarta Sans',
                                                          //   fontSize: 10*ffem,
                                                          //   fontWeight: FontWeight.w500,
                                                          //   height: 1.8*ffem/fem,
                                                          //   letterSpacing: 0.05*fem,
                                                          //   color: Color(0xff78828a),
                                                          // ),
                                                        ),
                                                      ),
                                                      /*

                                                        EL RinchText ME permite tener algunas modelos de texto en
                                                        una sola linea que sea vea mas elegante usando
                                                              TextSpan()

                                                        RichText(
                                                          // polynesiafrench5yo (1:419)
                                                          text: TextSpan(
                                                            //text: _con.product[index].address ?? '',
                                                            style: SafeGoogleFont (
                                                              'Plus Jakarta Sans',
                                                              fontSize: 10*ffem,
                                                              fontWeight: FontWeight.w500,
                                                              height: 1.8*ffem/fem,
                                                              letterSpacing: 0.05*fem,
                                                              color: Color(0xff78828a),
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: _con.product[index].address ?? '',
                                                                style: SafeGoogleFont (
                                                                  'Plus Jakarta Sans',
                                                                  fontSize: 10*ffem,
                                                                  fontWeight: FontWeight.w500,
                                                                  height: 1.8*ffem/fem,
                                                                  letterSpacing: 0.05*fem,
                                                                  color: Color(0xff78828a),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                //text: _con.product[index].address ?? '',
                                                                //text: 'French ',
                                                                style: SafeGoogleFont (
                                                                  'Plus Jakarta Sans',
                                                                  fontSize: 10*ffem,
                                                                  fontWeight: FontWeight.w500,
                                                                  height: 1.8*ffem/fem,
                                                                  letterSpacing: 0.05*fem,
                                                                  color: Color(0xff78828a),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        */
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // group1000003466Tcy (1:422)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 0*fem),
                                            width: double.infinity,
                                            height: 22*fem,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // PFj (1:423)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 57*fem, 0*fem),
                                                  child: Text(
                                                    '\$235',
                                                    // style: SafeGoogleFont (
                                                    //   'Plus Jakarta Sans',
                                                    //   fontSize: 14*ffem,
                                                    //   fontWeight: FontWeight.w700,
                                                    //   height: 1.5714285714*ffem/fem,
                                                    //   letterSpacing: 0.07*fem,
                                                    //   color: Color(0xff111111),
                                                    // ),
                                                  ),
                                                ),
                                                Container(
                                                  // group1000003429gkd (1:424)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 1*fem),
                                                  height: double.infinity,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        // starb6u (1:425)
                                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                        width: 14*fem,
                                                        height: 14*fem,
                                                        child: Image.asset(
                                                          'assets/img/star.png',
                                                          width: 14*fem,
                                                          height: 14*fem,
                                                        ),
                                                      ),
                                                      RichText(
                                                        // type166JZ (1:426)
                                                        text: TextSpan(
                                                          // style: SafeGoogleFont (
                                                          //   'Plus Jakarta Sans',
                                                          //   fontSize: 12*ffem,
                                                          //   fontWeight: FontWeight.w600,
                                                          //   height: 1.6666666667*ffem/fem,
                                                          //   letterSpacing: 0.06*fem,
                                                          //   color: Color(0xffffcd19),
                                                          // ),
                                                          children: [
                                                            TextSpan(
                                                              text: '4.4 ',
                                                            ),
                                                            TextSpan(
                                                              text: '(32)',
                                                              // style: SafeGoogleFont (
                                                              //   'Plus Jakarta Sans',
                                                              //   fontSize: 12*ffem,
                                                              //   fontWeight: FontWeight.w600,
                                                              //   height: 1.6666666667*ffem/fem,
                                                              //   letterSpacing: 0.06*fem,
                                                              //   color: Color(0xff78828a),
                                                              // ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _textGetProducts() {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      //color: Colors.blue,
      //padding:EdgeInsets.symmetric(vertical: 20),
      // titlefC1 (1:445)
      //margin: EdgeInsets.fromLTRB(0*fem, 32*fem, 0*fem, 32*fem),
      margin: EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 20*fem),
      width: double.infinity,
      height: 26*fem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // frequentlyvisitedPNu (1:446)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 115*fem, 0*fem),
            child: Text(
              'Multiples servicios',
              textAlign: TextAlign.center,
              // style: SafeGoogleFont (
              //   'Plus Jakarta Sans',
              //   fontSize: 18*ffem,
              //   fontWeight: FontWeight.w700,
              //   height: 1.4444444444*ffem/fem,
              //   letterSpacing: 0.09*fem,
              //   color: Color(0xff111111),
              // ),
            ),
          ),
          Container(
            // slidertKf (1:447)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 30*fem, 0*fem),
            height: double.infinity,
            child: Text(
              // seeallvgD (1:498)
              'See All',
              // style: SafeGoogleFont (
              //   'Plus Jakarta Sans',
              //   fontSize: 14*ffem,
              //   fontWeight: FontWeight.w500,
              //   height: 1.5714285714*ffem/fem,
              //   letterSpacing: 0.07*fem,
              //   color: Color(0xff009b8d),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listProductGetAllRandom(Product productRandom) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: List<Widget>.generate(_con.productRandom.length, (index) {
        var proRand = _con.productRandom[index].name;
        print('robando el prin de random  $proRand');
        coloresAleatorios[index] = _generarColorAleatorio();
        String opt;
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              _con.openBottomSheet(_con.productRandom[index]);
            },
            child: Padding(padding: EdgeInsets.symmetric (horizontal: 25),
              child: Padding(padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    //color: Colors.orange,
                    // listBc9 (1:500)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                    width: double.infinity,
                    height: 86*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // contenedor de las imagenes
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8*fem),
                          child: FadeInImage(
                            width: 86*fem,
                            height: 86*fem,
                            image: _con.productRandom[index].image1 != null
                                ? NetworkImage(_con.product[index].image1)
                                : const AssetImage('assets/img/pizza2.png' ),
                            fit: BoxFit.cover,
                            // el fit cover me ayuda a que se posiscione en todo el container es mejor este
                            fadeInDuration: const Duration(milliseconds: 50),
                            placeholder: const AssetImage('assets/img/no-image.png'),
                          ),
                        ),
                        Container(
                          //color: Colors.teal,
                          // autogroupngvzE4d (h4sJwS2mn6gbnGYQKngvZ)
                          padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 0*fem, 5*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //color: Colors.blue,
                                // group10000034849hP (1:502)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                width: 157*fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Contenedor del nombre
                                    Container(
                                      // group1000003483gBX (1:507)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // ledadubeachc5B (1:508)
                                            _con.productRandom[index].name ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //'Ledadu Beach',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 16*ffem,
                                            //   fontWeight: FontWeight.w700,
                                            //   height: 1.5*ffem/fem,
                                            //   letterSpacing: 0.08*fem,
                                            //   color: Color(0xff111111),
                                            // ),
                                          ),
                                          // Texto del telefono
                                          Text(
                                            // days2nightsXT3 (1:509)
                                            //'3 days 2 nights',
                                            _con.productRandom[index].phone ?? '',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 12*ffem,
                                            //   fontWeight: FontWeight.w500,
                                            //   height: 1.6666666667*ffem/fem,
                                            //   letterSpacing: 0.06*fem,
                                            //   color: Color(0xff78828a),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // group1000003465TrV (1:503)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                      padding: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 0*fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // bxsmap11NTf (1:505)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                            width: 12*fem,
                                            height: 15*fem,
                                            child: Image.asset(
                                              'assets/img/bxs-map-1-1-kVB.png',
                                              width: 12*fem,
                                              height: 15*fem,
                                            ),
                                          ),
                                          Container(
                                            width: 130,
                                            //color: Colors.red,
                                            child: Text(
                                              // australiaHKj (1:504)
                                              _con.productRandom[index].address ?? '',
                                              //'Australia12345678',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              // style: SafeGoogleFont (
                                              //   'Plus Jakarta Sans',
                                              //   fontSize: 12*ffem,
                                              //   fontWeight: FontWeight.w500,
                                              //   height: 1.6666666667*ffem/fem,
                                              //   letterSpacing: 0.06*fem,
                                              //   color: Color(0xff78828a),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // texto de los precios
                              RichText(
                                // personDUH (1:510)
                                text: TextSpan(
                                  // style: SafeGoogleFont (
                                  //   'Plus Jakarta Sans',
                                  //   fontSize: 12*ffem,
                                  //   fontWeight: FontWeight.w500,
                                  //   height: 1.6666666667*ffem/fem,
                                  //   letterSpacing: 0.06*fem,
                                  //   color: Color(0xff000000),
                                  // ),
                                  children: [
                                    TextSpan(
                                      //'${_con.product[index].price ?? 0}\$',
                                      text: '\$20',
                                      // style: SafeGoogleFont (
                                      //   'Plus Jakarta Sans',
                                      //   fontSize: 14*ffem,
                                      //   fontWeight: FontWeight.w700,
                                      //   height: 1.5714285714*ffem/fem,
                                      //   letterSpacing: 0.07*fem,
                                      //   color: Color(0xff111111),
                                      // ),
                                    ),
                                    TextSpan(
                                      text: '/Person',
                                      // style: SafeGoogleFont (
                                      //   'Plus Jakarta Sans',
                                      //   fontSize: 12*ffem,
                                      //   fontWeight: FontWeight.w500,
                                      //   height: 1.6666666667*ffem/fem,
                                      //   letterSpacing: 0.06*fem,
                                      //     color: Color(0xff009b8d),
                                      //   //color: Color(0xff78828a),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _categoriesIcons() {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // serviceeoP (1:362)
      margin: EdgeInsets.fromLTRB(30*fem, 0*fem, 4*fem, 0*fem),
      width: double.infinity,
      height: 97*fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // listNjP (1:379)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 21*fem, 0*fem),
            width: 64*fem,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupnf7bzVs (h4qSKtLjPrWuRd6aoNF7B)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                  padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 16*fem),
                  width: double.infinity,
                  decoration: BoxDecoration (
                    color: Color(0xfff6f8fe),
                    borderRadius: BorderRadius.circular(32*fem),
                  ),
                  child: Center(
                    // flight1VSd (1:382)
                    child: SizedBox(
                      width: 32*fem,
                      height: 32*fem,
                      child: Image.asset(
                        'assets/img/flight-1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // airportRbB (1:381)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                  child: Text(
                    'Viajes',
                    textAlign: TextAlign.center,
                    // style: SafeGoogleFont (
                    //   'Plus Jakarta Sans',
                    //   fontSize: 14*ffem,
                    //   fontWeight: FontWeight.w500,
                    //   height: 1.5714285714*ffem/fem,
                    //   letterSpacing: 0.07*fem,
                    //   color: Color(0xff78828a),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // listvnq (1:375)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 21*fem, 0*fem),
            width: 64*fem,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupww6vsCH (h4qHuxh53iZyj9eLqww6V)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                  padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 16*fem),
                  width: double.infinity,
                  decoration: BoxDecoration (
                    color: Color(0xfff6f8fe),
                    borderRadius: BorderRadius.circular(32*fem),
                  ),
                  child: Center(
                    // car1n4M (1:378)
                    child: SizedBox(
                      width: 32*fem,
                      height: 32*fem,
                      child: Image.asset(
                        'assets/img/car-1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // taxiXGq (1:377)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                  child: Text(
                    'Taxi',
                    textAlign: TextAlign.center,
                    // style: SafeGoogleFont (
                    //   'Plus Jakarta Sans',
                    //   fontSize: 14*ffem,
                    //   fontWeight: FontWeight.w500,
                    //   height: 1.5714285714*ffem/fem,
                    //   letterSpacing: 0.07*fem,
                    //   color: Color(0xff78828a),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // list2UV (1:371)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 21*fem, 0*fem),
            width: 64*fem,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupj2vkmBB (h4q9AiGGs7tgNttQiJ2VK)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                  padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 16*fem),
                  width: double.infinity,
                  decoration: BoxDecoration (
                    color: Color(0xfff6f8fe),
                    borderRadius: BorderRadius.circular(32*fem),
                  ),
                  child: Center(
                    // hotel1U5b (1:374)
                    child: SizedBox(
                      width: 32*fem,
                      height: 32*fem,
                      child: Image.asset(
                        'assets/img/hotel-1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // hotel15X (1:373)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                  child: Text(
                    'Hotel',
                    textAlign: TextAlign.center,
                    // style: SafeGoogleFont (
                    //   'Plus Jakarta Sans',
                    //   fontSize: 14*ffem,
                    //   fontWeight: FontWeight.w500,
                    //   height: 1.5714285714*ffem/fem,
                    //   letterSpacing: 0.07*fem,
                    //   color: Color(0xff78828a),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // listiEq (1:363)
            width: 64*fem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupbme5rrq (h4pvvZfZQgYTgwRhjBMe5)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                  padding: EdgeInsets.fromLTRB(18.67*fem, 18.67*fem, 18.67*fem, 18.67*fem),
                  width: double.infinity,
                  decoration: BoxDecoration (
                    color: Color(0xfff6f8fe),
                    borderRadius: BorderRadius.circular(32*fem),
                  ),
                  child: Center(
                    // categoryLGD (1:365)
                    child: SizedBox(
                      width: 26.67*fem,
                      height: 26.67*fem,
                      child: Image.asset(
                        'assets/img/category.png',
                        width: 26.67*fem,
                        height: 26.67*fem,
                      ),
                    ),
                  ),
                ),
                Container(
                  // moreenh (1:370)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                  child: Text(
                    'More',
                    textAlign: TextAlign.center,
                    // style: SafeGoogleFont (
                    //   'Plus Jakarta Sans',
                    //   fontSize: 12*ffem,
                    //   fontWeight: FontWeight.w600,
                    //   height: 1.6666666667*ffem/fem,
                    //   letterSpacing: 0.06*fem,
                    //   color: Color(0xff78828a),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget  _tabControllerCategories() {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Container(
        //color: Colors.green[100],
        //margin: EdgeInsets.symmetric(vertical: 10),
        width: double.maxFinite,
        height: 370,
        child: Scaffold(
          //backgroundColor: Colors.green[100],
          key: _con.key,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: MyColors.secondyColorOpacity,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3.0,
                  indicatorColor: MyColors.primarycolor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  tabs: List<Widget>.generate(_con.categories.length, (index) {
                    coloresAleatorios[index] = _generarColorAleatorio();
                    return Tab(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //for(int i=1; i < 8; i++)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0,),
                                padding: EdgeInsets.symmetric( horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //color: coloresAleatorios[index],
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
                                      color: Colors.green[600],
                                    ),textAlign: TextAlign.end)
                                  ],),
                              )
                          ],
                        ),
                      ),
                      //Text(_con.categories[index].name ?? ''),
                    );
                  }),
                ),
              ),

            ),
          drawer: _drawer(),
          body: Container(
            color: MyColors.primaryOpacityColor,
            //color: MyColors.primaryOpacityColor,
            width: double.maxFinite,
            height: 300,
            child: TabBarView(
              children: _con.categories.map((
                  Category category,
                  ) {
                return FutureBuilder(
                  future: _con.getProducts(category.id, _con.productName),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isNotEmpty) {
                        return GridView.builder(
                            padding:
                            const EdgeInsets.only(left: 8, bottom: 25, top: 5),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                //crossAxisCount: 2,
                                crossAxisCount: 1,
                                childAspectRatio: 1.2),
                                //childAspectRatio: 1.2),
                            itemCount: snapshot.data?.length ?? 0,
                            scrollDirection: Axis.horizontal,
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
          ),
        ),
      ),
    );

  }

  Color _generarColorAleatorio() {
    final random = Random();
    return colores[random.nextInt(colores.length)];
  }

  Widget _travel () {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // onbudgettour9X3 (1:496)
      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 5*fem),
      width: 328*fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // titleGrZ (1:497)
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // onbudgettourdh7 (1:499)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 144*fem, 0*fem),
                  child: Text(
                    'On Budget Tour',
                    // style: SafeGoogleFont (
                    //   'Plus Jakarta Sans',
                    //   fontSize: 18*ffem,
                    //   fontWeight: FontWeight.w700,
                    //   height: 1.4444444444*ffem/fem,
                    //   letterSpacing: 0.09*fem,
                    //   color: Color(0xff111111),
                    // ),
                  ),
                ),
                Text(
                  // seeallvgD (1:498)
                  'See All',
                  // style: SafeGoogleFont (
                  //   'Plus Jakarta Sans',
                  //   fontSize: 14*ffem,
                  //   fontWeight: FontWeight.w500,
                  //   height: 1.5714285714*ffem/fem,
                  //   letterSpacing: 0.07*fem,
                  //   color: Color(0xff009b8d),
                  // ),
                ),
              ],
            ),
          ),
          Container(
            // autogrouplnahrpm (h4s9n2dZJRbLNHerULnaH)
            padding: EdgeInsets.fromLTRB(0*fem, 16*fem, 0*fem, 0*fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // listBc9 (1:500)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 16*fem),
                  width: double.infinity,
                  height: 86*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // rectangle224697Eu (1:501)
                        width: 86*fem,
                        height: 86*fem,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(8*fem),
                          color: Color(0xffd9d9d9),
                          image: DecorationImage (
                            fit: BoxFit.cover,
                            image: AssetImage (
                              'assets/img/rectangle-22469-bg.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // autogroupngvzE4d (h4sJwS2mn6gbnGYQKngvZ)
                        padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 0*fem, 5*fem),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group10000034849hP (1:502)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 43*fem, 0*fem),
                              width: 112*fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // group1000003483gBX (1:507)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // ledadubeachc5B (1:508)
                                          'Ledadu Beach',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 16*ffem,
                                          //   fontWeight: FontWeight.w700,
                                          //   height: 1.5*ffem/fem,
                                          //   letterSpacing: 0.08*fem,
                                          //   color: Color(0xff111111),
                                          // ),
                                        ),
                                        Text(
                                          // days2nightsXT3 (1:509)
                                          '3 days 2 nights',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 12*ffem,
                                          //   fontWeight: FontWeight.w500,
                                          //   height: 1.6666666667*ffem/fem,
                                          //   letterSpacing: 0.06*fem,
                                          //   color: Color(0xff78828a),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group1000003465TrV (1:503)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 39*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 0*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // bxsmap11NTf (1:505)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                          width: 12*fem,
                                          height: 15*fem,
                                          child: Image.asset(
                                            'assets/img/bxs-map-1-1-kVB.png',
                                            width: 12*fem,
                                            height: 15*fem,
                                          ),
                                        ),
                                        Text(
                                          // australiaHKj (1:504)
                                          'Australia',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 12*ffem,
                                          //   fontWeight: FontWeight.w500,
                                          //   height: 1.6666666667*ffem/fem,
                                          //   letterSpacing: 0.06*fem,
                                          //   color: Color(0xff78828a),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              // personDUH (1:510)
                              text: TextSpan(
                                // style: SafeGoogleFont (
                                //   'Plus Jakarta Sans',
                                //   fontSize: 12*ffem,
                                //   fontWeight: FontWeight.w500,
                                //   height: 1.6666666667*ffem/fem,
                                //   letterSpacing: 0.06*fem,
                                //   color: Color(0xff000000),
                                // ),
                                children: [
                                  TextSpan(
                                    text: '\$20',
                                    // style: SafeGoogleFont (
                                    //   'Plus Jakarta Sans',
                                    //   fontSize: 14*ffem,
                                    //   fontWeight: FontWeight.w700,
                                    //   height: 1.5714285714*ffem/fem,
                                    //   letterSpacing: 0.07*fem,
                                    //   color: Color(0xff111111),
                                    // ),
                                  ),
                                  TextSpan(
                                    text: '/Person',
                                    // style: SafeGoogleFont (
                                    //   'Plus Jakarta Sans',
                                    //   fontSize: 12*ffem,
                                    //   fontWeight: FontWeight.w500,
                                    //   height: 1.6666666667*ffem/fem,
                                    //   letterSpacing: 0.06*fem,
                                    //   color: Color(0xff78828a),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // listVq7 (1:511)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 3*fem, 0*fem),
                  width: double.infinity,
                  height: 86*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // rectangle22469Dm7 (1:512)
                        width: 86*fem,
                        height: 86*fem,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(8*fem),
                          color: Color(0xffd9d9d9),
                          image: DecorationImage (
                            fit: BoxFit.cover,
                            image: AssetImage (
                              'assets/img/rectangle-22469-bg-mRX.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // autogrouptonuLqj (h4sn6KTHNfE2NRuMhtoNu)
                        padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 0*fem, 5*fem),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group100000348452d (1:513)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 28*fem, 0*fem),
                              width: 127*fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // group1000003483bFs (1:518)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // endigadabeachvZ3 (1:519)
                                          'Endigada Beach',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 16*ffem,
                                          //   fontWeight: FontWeight.w700,
                                          //   height: 1.5*ffem/fem,
                                          //   letterSpacing: 0.08*fem,
                                          //   color: Color(0xff111111),
                                          // ),
                                        ),
                                        Text(
                                          // days4nights3tZ (1:520)
                                          '5 days 4 nights',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 12*ffem,
                                          //   fontWeight: FontWeight.w500,
                                          //   height: 1.6666666667*ffem/fem,
                                          //   letterSpacing: 0.06*fem,
                                          //   color: Color(0xff78828a),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group1000003465Bzm (1:514)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 54*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 0*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // bxsmap11hiD (1:516)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                          width: 12*fem,
                                          height: 15*fem,
                                          child: Image.asset(
                                            'assets/img/bxs-map-1-1-V1F.png',
                                            width: 12*fem,
                                            height: 15*fem,
                                          ),
                                        ),
                                        Text(
                                          // australiacqB (1:515)
                                          'Australia',
                                          // style: SafeGoogleFont (
                                          //   'Plus Jakarta Sans',
                                          //   fontSize: 12*ffem,
                                          //   fontWeight: FontWeight.w500,
                                          //   height: 1.6666666667*ffem/fem,
                                          //   letterSpacing: 0.06*fem,
                                          //   color: Color(0xff78828a),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              // personZEd (1:521)
                              text: TextSpan(
                                // style: SafeGoogleFont (
                                //   'Plus Jakarta Sans',
                                //   fontSize: 12*ffem,
                                //   fontWeight: FontWeight.w500,
                                //   height: 1.6666666667*ffem/fem,
                                //   letterSpacing: 0.06*fem,
                                //   color: Color(0xff000000),
                                // ),
                                children: [
                                  TextSpan(
                                    text: '\$25',
                                    // style: SafeGoogleFont (
                                    //   'Plus Jakarta Sans',
                                    //   fontSize: 14*ffem,
                                    //   fontWeight: FontWeight.w700,
                                    //   height: 1.5714285714*ffem/fem,
                                    //   letterSpacing: 0.07*fem,
                                    //   color: Color(0xff111111),
                                    // ),
                                  ),
                                  TextSpan(
                                    text: '/Person',
                                    // style: SafeGoogleFont (
                                    //   'Plus Jakarta Sans',
                                    //   fontSize: 12*ffem,
                                    //   fontWeight: FontWeight.w500,
                                    //   height: 1.6666666667*ffem/fem,
                                    //   letterSpacing: 0.06*fem,
                                    //   color: Color(0xff78828a),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _frequently () {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            // frequentlyvisited9UZ (1:407)
            margin: EdgeInsets.fromLTRB(4*fem, 0*fem, 0*fem, 0*fem),
            width: 328*fem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // titlefC1 (1:445)
                  margin: EdgeInsets.fromLTRB(1.5*fem, 0*fem, 0*fem, 16*fem),
                  width: double.infinity,
                  height: 26*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // frequentlyvisitedPNu (1:446)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 111.5*fem, 0*fem),
                        child: Text(
                          'Recientes agrega\n',
                          textAlign: TextAlign.center,
                          // style: SafeGoogleFont (
                          //   'Plus Jakarta Sans',
                          //   fontSize: 18*ffem,
                          //   fontWeight: FontWeight.w700,
                          //   height: 1.4444444444*ffem/fem,
                          //   letterSpacing: 0.09*fem,
                          //   color: Color(0xff111111),
                          // ),
                        ),
                      ),
                      Container(
                        // slidertKf (1:447)
                        margin: EdgeInsets.fromLTRB(0*fem, 9*fem, 0*fem, 9*fem),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // dotDcq (1:448)
                              width: 24*fem,
                              height: 8*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(100*fem),
                                color: Color(0xff009b8d),
                              ),
                            ),
                            SizedBox(
                              width: 8*fem,
                            ),
                            Container(
                              // dotYf7 (1:449)
                              width: 8*fem,
                              height: 8*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(4*fem),
                                color: Color(0xffd1d8dd),
                              ),
                            ),
                            SizedBox(
                              width: 8*fem,
                            ),
                            Container(
                              // dotgFX (1:450)
                              width: 8*fem,
                              height: 8*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(4*fem),
                                color: Color(0xffd1d8dd),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // itemspsX (1:408)
                  width: double.infinity,
                  height: 232*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // listNPF (1:409)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                        width: 156*fem,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group1000003468tMb (1:410)
                              padding: EdgeInsets.fromLTRB(120*fem, 13*fem, 8*fem, 13*fem),
                              width: double.infinity,
                              height: 150*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(8*fem),
                                image: DecorationImage (
                                  fit: BoxFit.cover,
                                  image: AssetImage (
                                    'assets/img/rectangle-22468-bg.png',
                                  ),
                                ),
                              ),
                              child: Align(
                                // group1000003464BLh (1:412)
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 28*fem,
                                  height: 28*fem,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 96*fem),
                                    child: Image.asset(
                                      'assets/img/group-1000003464.png',
                                      width: 28*fem,
                                      height: 28*fem,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // autogrouptn5kH8q (h4qteTpQQGEPtLCJjtN5K)
                              padding: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 0*fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // group1000003467cwo (1:416)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                    width: 105*fem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // tahitibeachxEy (1:417)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                          child: Text(
                                            'Tahiti Beach',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 14*ffem,
                                            //   fontWeight: FontWeight.w600,
                                            //   height: 1.5714285714*ffem/fem,
                                            //   letterSpacing: 0.07*fem,
                                            //   color: Color(0xff111111),
                                            // ),
                                          ),
                                        ),
                                        Container(
                                          // group1000003465FUy (1:418)
                                          padding: EdgeInsets.fromLTRB(2.33*fem, 0*fem, 0*fem, 0*fem),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // bxsmap11aXF (1:420)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.33*fem, 0*fem),
                                                width: 9.33*fem,
                                                height: 11.67*fem,
                                                child: Image.asset(
                                                  'assets/img/bxs-map-1-1.png',
                                                  width: 9.33*fem,
                                                  height: 11.67*fem,
                                                ),
                                              ),
                                              RichText(
                                                // polynesiafrench5yo (1:419)
                                                text: TextSpan(
                                                  // style: SafeGoogleFont (
                                                  //   'Plus Jakarta Sans',
                                                  //   fontSize: 10*ffem,
                                                  //   fontWeight: FontWeight.w500,
                                                  //   height: 1.8*ffem/fem,
                                                  //   letterSpacing: 0.05*fem,
                                                  //   color: Color(0xff78828a),
                                                  // ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Polynesia, ',
                                                      // style: SafeGoogleFont (
                                                      //   'Plus Jakarta Sans',
                                                      //   fontSize: 10*ffem,
                                                      //   fontWeight: FontWeight.w500,
                                                      //   height: 1.8*ffem/fem,
                                                      //   letterSpacing: 0.05*fem,
                                                      //   color: Color(0xff78828a),
                                                      // ),
                                                    ),
                                                    TextSpan(
                                                      text: 'French ',
                                                      // style: SafeGoogleFont (
                                                      //   'Plus Jakarta Sans',
                                                      //   fontSize: 10*ffem,
                                                      //   fontWeight: FontWeight.w500,
                                                      //   height: 1.8*ffem/fem,
                                                      //   letterSpacing: 0.05*fem,
                                                      //   color: Color(0xff78828a),
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group1000003466Tcy (1:422)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 0*fem),
                                    width: double.infinity,
                                    height: 22*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // PFj (1:423)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 57*fem, 0*fem),
                                          child: Text(
                                            '\$235',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 14*ffem,
                                            //   fontWeight: FontWeight.w700,
                                            //   height: 1.5714285714*ffem/fem,
                                            //   letterSpacing: 0.07*fem,
                                            //   color: Color(0xff111111),
                                            // ),
                                          ),
                                        ),
                                        Container(
                                          // group1000003429gkd (1:424)
                                          margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 1*fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // starb6u (1:425)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                width: 14*fem,
                                                height: 14*fem,
                                                child: Image.asset(
                                                  'assets/img/star.png',
                                                  width: 14*fem,
                                                  height: 14*fem,
                                                ),
                                              ),
                                              RichText(
                                                // type166JZ (1:426)
                                                text: TextSpan(
                                                  // style: SafeGoogleFont (
                                                  //   'Plus Jakarta Sans',
                                                  //   fontSize: 12*ffem,
                                                  //   fontWeight: FontWeight.w600,
                                                  //   height: 1.6666666667*ffem/fem,
                                                  //   letterSpacing: 0.06*fem,
                                                  //   color: Color(0xffffcd19),
                                                  // ),
                                                  children: [
                                                    TextSpan(
                                                      text: '4.4 ',
                                                    ),
                                                    TextSpan(
                                                      text: '(32)',
                                                      // style: SafeGoogleFont (
                                                      //   'Plus Jakarta Sans',
                                                      //   fontSize: 12*ffem,
                                                      //   fontWeight: FontWeight.w600,
                                                      //   height: 1.6666666667*ffem/fem,
                                                      //   letterSpacing: 0.06*fem,
                                                      //   color: Color(0xff78828a),
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // listFam (1:427)
                        width: 156*fem,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group1000003468QTf (1:428)
                              padding: EdgeInsets.fromLTRB(120*fem, 13*fem, 8*fem, 13*fem),
                              width: double.infinity,
                              height: 150*fem,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(8*fem),
                                image: DecorationImage (
                                  fit: BoxFit.cover,
                                  image: AssetImage (
                                    'assets/img/rectangle-22468-bg-txV.png',
                                  ),
                                ),
                              ),
                              child: Align(
                                // group1000003464uQR (1:430)
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 28*fem,
                                  height: 28*fem,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 96*fem),
                                    child: Image.asset(
                                      'assets/img/group-1000003464-qBT.png',
                                      width: 28*fem,
                                      height: 28*fem,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // autogroup81ghPaV (h4rUNzcLFRhh6AqC781Gh)
                              padding: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 0*fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // group10000034678HB (1:434)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                                    width: 125*fem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // stluciamountain3uw (1:435)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                          child: Text(
                                            'St. Lucia Mountain',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 14*ffem,
                                            //   fontWeight: FontWeight.w600,
                                            //   height: 1.5714285714*ffem/fem,
                                            //   letterSpacing: 0.07*fem,
                                            //   color: Color(0xff111111),
                                            // ),
                                          ),
                                        ),
                                        Container(
                                          // group1000003465MQq (1:436)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 36*fem, 0*fem),
                                          padding: EdgeInsets.fromLTRB(2.33*fem, 0*fem, 0*fem, 0*fem),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // bxsmap11fAd (1:438)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.33*fem, 0*fem),
                                                width: 9.33*fem,
                                                height: 11.67*fem,
                                                child: Image.asset(
                                                  'assets/img/bxs-map-1-1-fWm.png',
                                                  width: 9.33*fem,
                                                  height: 11.67*fem,
                                                ),
                                              ),
                                              Text(
                                                // southamericaN53 (1:437)
                                                'South America',
                                                // style: SafeGoogleFont (
                                                //   'Plus Jakarta Sans',
                                                //   fontSize: 10*ffem,
                                                //   fontWeight: FontWeight.w500,
                                                //   height: 1.8*ffem/fem,
                                                //   letterSpacing: 0.05*fem,
                                                //   color: Color(0xff78828a),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group1000003466tp5 (1:440)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                    width: double.infinity,
                                    height: 22*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // DrM (1:441)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 59*fem, 0*fem),
                                          child: Text(
                                            '\$182',
                                            // style: SafeGoogleFont (
                                            //   'Plus Jakarta Sans',
                                            //   fontSize: 14*ffem,
                                            //   fontWeight: FontWeight.w700,
                                            //   height: 1.5714285714*ffem/fem,
                                            //   letterSpacing: 0.07*fem,
                                            //   color: Color(0xff111111),
                                            // ),
                                          ),
                                        ),
                                        Container(
                                          // group1000003429jJu (1:442)
                                          margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 1*fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // starFY9 (1:443)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                                width: 14*fem,
                                                height: 14*fem,
                                                child: Image.asset(
                                                  'assets/img/star-TE5.png',
                                                  width: 14*fem,
                                                  height: 14*fem,
                                                ),
                                              ),
                                              RichText(
                                                // type16mWV (1:444)
                                                text: TextSpan(
                                                  // style: SafeGoogleFont (
                                                  //   'Plus Jakarta Sans',
                                                  //   fontSize: 12*ffem,
                                                  //   fontWeight: FontWeight.w600,
                                                  //   height: 1.6666666667*ffem/fem,
                                                  //   letterSpacing: 0.06*fem,
                                                  //   color: Color(0xffffcd19),
                                                  // ),
                                                  children: [
                                                    TextSpan(
                                                      text: '4.4 ',
                                                    ),
                                                    TextSpan(
                                                      text: '(41)',
                                                      // style: SafeGoogleFont (
                                                      //   'Plus Jakarta Sans',
                                                      //   fontSize: 12*ffem,
                                                      //   fontWeight: FontWeight.w600,
                                                      //   height: 1.6666666667*ffem/fem,
                                                      //   letterSpacing: 0.06*fem,
                                                      //   color: Color(0xff78828a),
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _header() {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      //color: Colors.white,
      // user4so (1:383)
      margin: EdgeInsets.only(top: 15, left: 20, bottom: 10),
      width: double.infinity,
      height: 46*fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // profileN7o (1:399)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 139*fem, 0*fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // 6Zb (1:400)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15*fem, 0*fem),
                  width: 40*fem,
                  height: 40*fem,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100*fem),
                    child: Image.asset(
                      'assets/img/logoQuenetur.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  // group1000003474bmF (1:401)
                  width: 92*fem,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // hiandyjsT (1:402)
                        'Quenetur',
                        //'Hi, Andy',
                        // style: SafeGoogleFont (
                        //   'Plus Jakarta Sans',
                        //   fontSize: 18*ffem,
                        //   fontWeight: FontWeight.w700,
                        //   height: 1.4444444444*ffem/fem,
                        //   letterSpacing: 0.09*fem,
                        //   color: Color(0xff111111),
                        // ),
                      ),
                      Container(
                        // group1000003473THf (1:403)
                        padding: EdgeInsets.fromLTRB(2.67*fem, 0*fem, 0*fem, 0*fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // bxsmap11PBK (1:405)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.67*fem, 0*fem),
                              width: 10.67*fem,
                              height: 13.33*fem,
                              child: Image.asset(
                                'assets/img/bxs-map-1-1-rpm.png',
                                width: 10.67*fem,
                                height: 13.33*fem,
                              ),
                            ),
                            Text(
                              // netherlandsGku (1:404)
                              'Quevedo',
                              //'Netherlands',
                              // style: SafeGoogleFont (
                              //   'Plus Jakarta Sans',
                              //   fontSize: 12*ffem,
                              //   fontWeight: FontWeight.w500,
                              //   height: 1.6666666667*ffem/fem,
                              //   letterSpacing: 0.06*fem,
                              //   color: Color(0xff78828a),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // actionboB (1:384)
            width: 46*fem,
            height: 46*fem,
            child: Image.asset(
              'assets/img/action.png',
              width: 46*fem,
              height: 46*fem,
            ),
          ),
        ],
      ),
    );
  }


  Widget _tabControllerServices() {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 40),
        width: double.maxFinite,
        height: 200,
        child: Scaffold(
          body: Container(
            color: MyColors.primaryOpacityColor,
            width: double.maxFinite,
            height: 200,
            child: TabBarView(
              children: _con.categories.map((
                  Category category,
                  ) {
                return FutureBuilder(
                  future: _con.getProducts(category.id, _con.productName),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isNotEmpty) {
                        return GridView.builder(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                //crossAxisCount: 3,
                                //childAspectRatio: 0.81),
                                 crossAxisCount: 1,
                                 childAspectRatio: 1.3),
                            itemCount: snapshot.data?.length ?? 0,
                            //scrollDirection: Axis.vertical,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return _cardServices(snapshot.data[index]);
                            });
                      } else {
                        return SizedBox(
                          height: 50, width: 50,
                            child: const NoDataWidget());
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }).toList(),
            ),
          ),
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

  Widget _cardProduct(Product product) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(product);
      },
      child: SizedBox(
        //height: 235,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          elevation: 12.0,
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
                    padding: const EdgeInsets.symmetric(vertical: 5,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 3),
                        child:Text(
                          product.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NimbusSans'),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            Text(
                              product?.address ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NimbusSans'),
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

  Widget _cardServices(Product product) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(product);
      },
      child: SizedBox(
        //height: 235,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
          elevation: 6.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, //esta funcion los textos se ubican en la parte izquiera de la pantalla
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(
                        height: 80,
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
                    Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          product.name ?? '',
                          maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NimbusSans'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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

  Widget _textFieldSearch() {
    return Container(
      height: 65,
      padding: EdgeInsets.only(bottom: 15),
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
      margin: const EdgeInsets.only(left: 20, top: 20 ),
      alignment: Alignment.centerLeft,
      child: Padding(padding: EdgeInsets.only(left: 5,),
      //child: Padding(padding: EdgeInsets.only(left: 45,),
        child: Text("QUENETUR",
          style: TextStyle(fontSize: 19,
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
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
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
              // Este metodo de abajo me actualiza la pagina entera modificando todos
              // widgtes de la pagina
              //onIndexChanged: (index) {
              //   setState(() {
              //     _current = index ;
              //   });
              // },
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

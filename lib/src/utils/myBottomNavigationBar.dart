import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quenetur/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:quenetur/src/pages/client/products/list/client_products_list_page.dart';

import '../pages/client/categories/client_categories_list_page.dart';
import 'my_colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  // final items = const [
  //   Icon(Icons.home, size: 25,color: Colors.white,),
  //   Icon(Icons.list, size: 25,color: Colors.white,),
  //   Icon(Icons.favorite, size: 25,color: Colors.white,),
  //   Icon(Icons.search_outlined, size: 25,color: Colors.white,)
  // ];
  //
  // int index = 1;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        // onTap: (selectedIndex) {
        //   setState((){
        //     index = selectedIndex;
        //   });
        // },
        height: 50,
        color: MyColors.secondyColor,
        //color: Color(0xff009b8d),
        //color: MyColors.secondyColorOpacity,
        // items: items,
        // index: index,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          InkWell(
              onTap: (){
                Navigator.pushNamed(context, 'client/categories/list');
              },
              //onTap: _con.goToCategoriesClientPage,
              child: Icon(Icons.list, size: 25,color: Colors.white,)),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'client/products/list');
            },
              child: Icon(Icons.home, size: 25,color: Colors.white,)),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'client/orders/list');
            },
            //onTap: _con.goToHomePage,
            child: Icon(Icons.favorite, size: 25,color: Colors.white,),
          )
          //Icon(CupertinoIcons.cart_fill, size: 30,color: Colors.white,),
        ],
      );
      //body: getSelectedWidget(index: index),
  }

  Widget getSelectedWidget({int index}) {
    Widget widget;
    switch(index) {
      case 0 :
        widget = const ClientProductsListPage();
        break;
      case 1 :
        widget = const CategoryPage();
        break;
      case 2 :
        widget = const ClientOrdersCreatePage();
        break;
      default :
        widget = const ClientProductsListPage();
        break;
    }
    return widget;
  }

}

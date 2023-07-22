import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../pages/client/products/list/client_products_list_controller.dart';
import '../utils/my_colors.dart';

class HomeAppBar extends StatelessWidget{
  final ClientProductsListController _con = ClientProductsListController();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.sort, size: 30, color: Colors.indigo,),
          Padding(padding: EdgeInsets.only(left: 20,),
            child: Text("QUENETUR",
              style: TextStyle(fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),),
          Spacer(),
          Badge(
            badgeColor: Colors.red,
            padding: EdgeInsets.all(7),
            badgeContent: Text(
              "3",
              style:  TextStyle(
                  color: Colors.white
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "cartPage");
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 32,
                color: Colors.indigo,
              ),
            ),
          )
        ],
      ),
    );
  }
}
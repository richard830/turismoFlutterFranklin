import 'package:flutter/material.dart';
import 'package:quenetur/src/models/address.dart';
import 'package:quenetur/src/models/order.dart';
import 'package:quenetur/src/provider/address_provider.dart';
import 'package:quenetur/src/utils/shared_pref.dart';



import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';

class RestaurantOrdersPaymentsController {

  BuildContext context;
  Function refresh;

  Order order;

  //Address from;
  List<Address> address = [];
  final AddressProvider _addressProvider = AddressProvider();
  User user;
  final SharedPref _sharedPref = SharedPref();
  final OrdersProvider _ordersProvider = OrdersProvider();


  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
    _ordersProvider.init(context, user);

  }

  Future<List<Address>> getAddress() async{
    address = await _addressProvider.getByUser(user.id);
    return address;
  }

}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quenetur/src/pages/client/address/create/client_address_create_page.dart';
import 'package:quenetur/src/pages/client/categories/client_categories_list_page.dart';
import 'package:quenetur/src/pages/client/home/client_home_page.dart';
import 'package:quenetur/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:quenetur/src/pages/client/payments/create/client_payments_create_page.dart';
import 'package:quenetur/src/pages/client/products/list/client_products_list_page.dart';
import 'package:quenetur/src/pages/client/subcategories/client_subcategories_page.dart';
import 'package:quenetur/src/pages/client/update/client_update_page.dart';
import 'package:quenetur/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:quenetur/src/pages/login/login_page.dart';
import 'package:quenetur/src/pages/register/register_page.dart';
import 'package:quenetur/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:quenetur/src/pages/restaurant/lista_habitaciones/listahabitacion.dart';
import 'package:quenetur/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:quenetur/src/pages/restaurant/pdf/lista.dart';
import 'package:quenetur/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:quenetur/src/pages/restaurant/sub_categories/create/restaurant_subcategories_create_page.dart';
import 'package:quenetur/src/pages/roles/roles_page.dart';
import 'package:quenetur/src/provider/push_notifications_provider.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'dart:typed_data';



PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initNotifications();
   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QueNeTur",
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'client/home': (BuildContext context) => const ClientHomePage(),
        'register': (BuildContext context) => const RegisterPage(),
        'client/categories/list': (BuildContext context) => const CategoryPage(),
        'client/subcategories/list': (BuildContext context) => const ClientSubcategoriesListPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) => const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'client/orders/list': (BuildContext context) => const ClientOrdersCreatePage(),
        'client/payments/create': (BuildContext context) => const ClientPaymentsCreatePage(),
        'client/address/create': (BuildContext context) => const ClientAddressCreatePage(),
        'restaurant/orders/list': (BuildContext context) => const RestaurantOrdersListPage(),
        'restaurant/categories/list': (BuildContext context) => const RestaurantCategoriesCreatePage(),
        'restaurant/subcategories/list': (BuildContext context) => const RestaurantSubCategoriesCreatePage(),
        'restaurant/products/list': (BuildContext context) => const RestaurantProductsCreatePage(),
        'delivery/orders/list': (BuildContext context) => const DeliveryOrdersListPage(),
        'listaHabitacion': (BuildContext context) => const ListaHabiatcion(),
        'irapdf': (BuildContext context) => const Lista(),
      },


      // YA NO FUNCIONA PRIMARYCOLOR POR FUNCIONES DE FLUTER
      // AHORA COLORSCHEME

      theme: ThemeData(
        //fontFamily: 'NimbusSans',
          colorScheme: const ColorScheme.light().copyWith(primary:  MyColors.secondyColor,),
          appBarTheme: const AppBarTheme(elevation: 0)
      ),
    );
  }
}

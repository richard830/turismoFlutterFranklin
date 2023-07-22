import 'package:card_swiper/card_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/models/carousel.dart';
import 'package:quenetur/src/models/category.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'package:quenetur/src/widgets/no_data_widget.dart';



class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ClientHomePage> {
  //final ClientProductsListController _con = ClientProductsListController();

  int _current = 0;

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

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   _con.init(context, refresh);
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        //HomeAppBar(),
        Column(
          children: [
            // Baner Ads
            _bannerAds(),

            //Text Descubre quevedo
            Container(
                padding: EdgeInsets.all(20),
                child: _textInicio('Descubre Quevedo \ncon Nosotros', 30)),
            _textCualquiera('Experimente lugares comerciales y servicios\n de la ciudad del río - Quevedo', 18),
            _buttonNext(),
            //_textVerTodo(),

          ],
        ),
      ]),
    );
  }

  Widget _textInicio(String textApp, double fontSize) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only( left: 20, bottom: 5),
      child: Text(
        textApp,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight:  FontWeight.w500,
          color: Colors.black,
        ),textAlign: TextAlign.center,
      ),
    );
  }

  Widget _textCualquiera(String textApp, double fontSize) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only( left: 20),
      child: Text(
        textApp,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey,
        ),textAlign: TextAlign.center,

      ),
    );
  }


  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60, top: 30),
      height: 50,
      child: ElevatedButton(
        onPressed:() {
          Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
          //Navigator.pushNamed(context, 'client/products/list');
        },
        //_con.goToAddress,
        style: ElevatedButton.styleFrom(
            primary: MyColors.secondyColor,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child:  Text(
                  'Comienza Tu Aventura',
                  style: TextStyle(
                    color: Colors.white,
                    //color: MyColors.primarycolorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerAds() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //width: 400, es lo mismo de abajo
            width: MediaQuery.of(context).size.width,
            height: 430,
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
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(
                            carousels[index].image,
                          ),
                          fit: BoxFit.contain)
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: map<Widget> (
                    carousels, (index, image) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 6, width: 25,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        color: _current == index
                            ? Colors.indigo
                            : Colors.grey),
                  );
                }),
              ),
            ],
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

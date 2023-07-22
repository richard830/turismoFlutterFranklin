import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:quenetur/src/models/product.dart';
import 'package:quenetur/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:quenetur/src/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ClientsProductsDetailPage extends StatefulWidget {

  Product product;

  ClientsProductsDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  State<ClientsProductsDetailPage> createState() => _ClientsProductsDetailPageState();
}

class _ClientsProductsDetailPageState extends State<ClientsProductsDetailPage> {

  final ClientsProductsDetailController _con = ClientsProductsDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.965,
      //height: MediaQuery.of(context).size.height * 0.97,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _back(),
          _imageSlideshow(),
          _textNameAndFavorite(),
          _address(),
          _textDescription(),
          _description(),
          _priceAndWhatsapp()
        ],
      ),

    );
  }
  Widget _back(){
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: _con.close,
            icon: Icon(Icons.arrow_back_ios),),
          Text('Atrás', style: TextStyle(fontSize: 18, color: MyColors.primaryOpacityColor),)
        ],
      ),
    );
  }

  Widget _textNameAndFavorite() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left: 30,),
      child: Row(
        children: [
          Text(
            _con.product?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:  const TextStyle(
                fontSize: 19,
                //fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          GestureDetector(
              onTap: _con.addToBag,
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.red,size: 20,),
                Text(' Agregar a Favoritos', style: TextStyle(color: MyColors.primaryOpacityColor))
              ],
            ),
          )
        ],
      ),

    );
  }

  Widget _description() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left: 30),
      child: Text(
        _con.product?.description ?? '',
        //maxLines: 4,
        //overflow: TextOverflow.ellipsis,
        style:  TextStyle(
          fontSize: 16,
          color: MyColors.primaryOpacityColor
      ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left: 30),
      child: Text(
        'Descripción',
        style:  TextStyle(
            fontSize: 18,
            //fontWeight: FontWeight.bold
        ),
      ),

    );
  }

  Widget _address() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  child: Icon(
                    Icons.location_on_outlined, color: MyColors.primarycolorDark, size: 20,
                  )
              ),
              Text(
              _con.product?.address ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  color: MyColors.primaryOpacityColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),InkWell(
            onTap: () {
              launch(_con.product.location);
            },
            child: Row(
              children: [
                Icon(Icons.my_location, color: Colors.red, size:20,),
                Text(
                  ' Google Map',
                  //_con.product?.address ?? '',
                  style:  TextStyle(
                    color: MyColors.primaryOpacityColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buttonShoppingBag() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.addToBag,
        style: ElevatedButton.styleFrom(
          primary: MyColors.primarycolor,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'AÑADIR A LA CESTA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50,top: 5),
                height: 35,
                child: Image.asset('assets/img/bag_shop.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _priceAndWhatsapp() {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 55,
          width: 160,
          margin: const EdgeInsets.only(left: 30, right: 5, top: 10, bottom: 20),
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),      // Radius of the border
                //border: Border.all(width: 2.0, color: MyColors.secondyColor,) // borde color y tamano
            ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
                '${_con.productPrice ?? 0}\$',
                style:  TextStyle(
                    fontSize: 25,
                    color: MyColors.primarycolor,
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center
            ),
          ),
        ),
        Container(
          height: 55,
          width: 160,
          margin: const EdgeInsets.only(left: 5, right:30, top: 10, bottom: 10),
          child: ElevatedButton(
              onPressed: () {
                launch(_con.product.whatsapp);
              },
              //onPressed: _con.addToBag,
              style: ElevatedButton.styleFrom(
                  primary: MyColors.secondyColor,
                  //padding: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  )
              ),
              child: Row(
                children: [
                  Text('Contácta ahora! ', style: TextStyle(fontSize: 14, color: MyColors.primarycolorDark),),
                  Icon(Icons.whatsapp, color: MyColors.primarycolorDark,),
                ],
              )
          ),
        ),
      ],
    );
  }

  Widget _standarDelivery() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/img/buy-shopping-store.png',
            height: 17,
          ),
          const SizedBox(width: 7,), //SEPARA LOS ELEMENTOS CON PIXELES
          const Text(
            'Reserva Standar',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green
            ),
          )
        ],
      ),
    );
  }

  Widget _addOrRemoveItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
              onPressed: _con.addItem,
              icon: Icon(Icons.add_circle_outline,
              color: MyColors.primarycolor,
              size: 30,
              )
          ),
          Text(
            '${_con.counter}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: MyColors.primarycolorDark,
            ),
          ),
          IconButton(
              onPressed: _con.removeItem,
              icon: const Icon(Icons.remove_circle_outline,
                color: Colors.red,
                size: 30,
              )
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              '${_con.productPrice ?? 0}\$',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _imageSlideshow() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ImageSlideshow(
              width: double.infinity, //OCUPA TODO EL ANCHO DE LA IMAGEN
              // el MEDIAQUERY ES PARA LOS DIFERENTES DIMENSIONES DE LOS TELEFONOS
              height: MediaQuery.of(context).size.height * 0.5 ,
              //height: 200,
              initialPage: 0,
              indicatorColor: MyColors.primarycolor,
              indicatorBackgroundColor: Colors.grey,
              children: [
                FadeInImage(
                  image: _con.product?.image1 != null
                      ? NetworkImage(_con.product.image1)
                      : const AssetImage('assets/img/pizza2.png'),
                  fit: BoxFit.cover, // o tambien puede ser fill, pero mejor cover
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                ),FadeInImage(
                  image: _con.product?.image2 != null
                      ? NetworkImage(_con.product.image2)
                      : const AssetImage('assets/img/pizza2.png'),
                  fit: BoxFit.cover,// o tambien puede ser fill, pero mejor cover
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                ),FadeInImage(
                  image: _con.product?.image3 != null
                      ? NetworkImage(_con.product.image3)
                      : const AssetImage('assets/img/pizza2.png'),
                  fit: BoxFit.cover,// o tambien puede ser fill, pero mejor cover
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                ),
              ],
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              autoPlayInterval: 10000,
                isLoop: true,
            ),
          ),
        ),
        /*
        Positioned(
          left: 10,
            top: 5,
            child: IconButton(
              onPressed: _con.close,
              icon: Icon(
                  Icons.arrow_back_ios,
                color: MyColors.primarycolor,
              ),
            )
        )
        */
      ],
    );
  }

  void refresh() {
    setState(() {
  });}
}

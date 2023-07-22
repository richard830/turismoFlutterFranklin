class Carousel {
  String image;

  Carousel(this.image);
}

List<Carousel> carousels =
    carouselsData.map((item) => Carousel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/img/quenetur.png"},
  {"image": "assets/img/carousel_netcritech.png"},
  {"image": "assets/img/carousel_vespublicidad.png"},
  {"image": "assets/img/carousel_bambu_del_rio.png"},
];
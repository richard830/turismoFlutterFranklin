import 'package:flutter/material.dart';
import 'package:quenetur/src/utils/my_colors.dart';

final _icons = <String, IconData>{
  //ALOJAMIENTOS
  'hotel': Icons.hotel,

  //ALIMENTOS Y BEBEIDAS
  'restaurant': Icons.restaurant,
  'restaurant_menu': Icons.restaurant_menu,
  'fastfood': Icons.fastfood,
  'coffee': Icons.coffee,
  'set_meal': Icons.set_meal,
  'outdoor_grill': Icons.outdoor_grill,
  'icecream': Icons.icecream,
  'local_bar': Icons.local_bar,

  //ATRACTIVOS CULTURALES
  'map': Icons.map,
  'museum': Icons.museum,
  'man_rounded': Icons.man_rounded,
  'church': Icons.church,
  'celebration': Icons.celebration,

  //ESPARCIMIENTOS
  'sports_handball': Icons.sports_handball,
  'kayaking': Icons.kayaking,
  'directions_bike': Icons.directions_bike,
  'park': Icons.park,
  'attractions': Icons.attractions,
  'nightlife': Icons.nightlife,
  'fitness_center': Icons.fitness_center,
  'spa': Icons.spa,


  //COMPRAS
  'shopping_bag': Icons.shopping_bag,
  'shopify_sharp': Icons.shopify_sharp,
  'store': Icons.store,

  //SERVICIOS PROFESIONALES
  'engineering' : Icons.engineering,

  //SALUD
  'medical_information_outlined' : Icons.medical_information_outlined,

  //ASISTENCIA TECNICA
  'construction': Icons.construction,


  //ESPACIOS DE ATENCIO PUBLICA
  'assured_workload': Icons.assured_workload,

  //TRANSPORTES
  'directions_bus': Icons.directions_bus,
  'directions_bus_sharp': Icons.directions_bus_sharp,


  //DIRECTORIO TELEFÓNICO
  'phone': Icons.phone,
  'military_tech': Icons.military_tech,
  'medical_services': Icons.medical_services,
  'local_police': Icons.local_police,
  'fire_extinguisher': Icons.fire_extinguisher,

  // RUTAS
  'location_pin': Icons.location_pin,

  //AGENCIAS DE VIAJES
  'flight': Icons.flight,
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.green, size: 20.0,);
}

Icon getIconCategories(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: MyColors.secondyColor, size: 35.0,);
}

// Image(image: NetworkImage(category!.establishments[index].image.toString()),fit: BoxFit.cover,),
//

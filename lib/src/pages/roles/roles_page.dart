import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quenetur/src/models/rol.dart';
import 'package:quenetur/src/pages/roles/roles_controller.dart';



class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {

  final RolesController _con = RolesController();

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
        title: const Text('Selecciona un rol'),
      ),
      body: 
      
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        child: ListView(
          children: _con.user != null ? _con.user.roles.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : []
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route);
      },
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: FadeInImage(
              image: rol.image != null
                  ? NetworkImage(rol.image)
                  : const AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png',),
            ),
          ),
          const SizedBox(height: 15),
          Text(
              rol.name ?? '',
              style:const TextStyle(
                fontSize: 16,
                color: Colors.black
              )
          ),
          const SizedBox(height: 55),
        ],
      ),
    );
  }

  void refresh () {
    setState(() {});
  }
}

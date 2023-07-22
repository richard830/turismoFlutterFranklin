import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quenetur/src/models/response_api.dart';
import 'package:quenetur/src/models/user.dart';
import 'package:quenetur/src/provider/users_provider.dart';
import 'package:quenetur/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterControler {
  BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }



  Future<void> register() async {
     loading(context);
    String email = emailController.text;
    String name = nameController.text;
    String lastname = lastNameController.text;
    String phone = phoneController.text;
    String cedula = cedulaController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;


print(email);
print(name);
print(lastname);
print(phone);
print(cedula);
print(password);


    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        cedula.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

   if (phone.length <=9 ) {
      MySnackbar.show(
          context, 'El telefono icorrecto ingrese 10 Digitos');
      return;
    }
  

    if (password.length < 6) {
      MySnackbar.show(
          context, 'Las contraseñas debe tener al menos 6 caracteres');
      return;
    }


    User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        cedula: cedula,
        password: password);


         ResponseApi  responseApi =await usersProvider.createWithImage(user);
      //MySnackbar.show(context, responseApi.message);
     Navigator.of(context).pop();
    if(responseApi.success){
     MySnackbar.show(context, responseApi.message);
    
    // Future.delayed(Duration(seconds: 2), (){
    //     Navigator.pushReplacementNamed(context, 'login');
    //   });
  
     
    }else{
      MySnackbar.show(context, responseApi.message);
      //Fluttertoast.showToast(msg: responseApi.message);
     
    }
  
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }




void loading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
            child: Container(
                margin: EdgeInsets.all(10),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                )));
      });
}




  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: const Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: const Text('CÁMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}

import 'package:flutter/cupertino.dart';

class FormularioFromProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  validateFrom() {
    if (formkey.currentState.validate()) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static showToast(String text) {
    Fluttertoast.showToast(msg: text);
  }
}

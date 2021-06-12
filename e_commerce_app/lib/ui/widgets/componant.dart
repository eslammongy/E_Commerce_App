import 'package:e_commerce_app/remote/local/cash_helper.dart';
import 'package:e_commerce_app/ui/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// move bitween screens
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// show toast message..
void showToast({String message, ToastColor toastColor}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: setToastColor(toastColor: toastColor),
      fontSize: 20,
      textColor: Colors.white);
}

enum ToastColor { SUCCESS, ERROR, WARNING }

Color setToastColor({ToastColor toastColor}) {
  Color color;

  switch (toastColor) {
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//sign out
void signOut(context) {
  CacheHelper.clearUserData(key: 'token').then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  });
}

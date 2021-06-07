import 'package:e_commerce_app/remote/local/cash_helper.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:e_commerce_app/ui/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('E7ECEF'),
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            CacheHelper.clearUserData(key: 'token').then((value) {
              if (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              }
            });
          },
          child: Text(
            "Sign Out",
            style: TextStyle(
                fontSize: 50,
                fontFamily: "Pacifico",
                fontWeight: FontWeight.w600,
                color: defaultColor),
          ),
        ),
      ),
    );
  }
}

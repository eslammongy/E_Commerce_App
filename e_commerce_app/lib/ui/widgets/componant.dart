import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/model/favorite_model.dart';
import 'package:e_commerce_app/remote/local/cash_helper.dart';
import 'package:e_commerce_app/style/color.dart';
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

Widget buildListOfProduct(favoritesData, BuildContext context,
    {bool isOldPrice = true}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25))),
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(10),
    width: double.infinity,
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(favoritesData.image),
              fit: BoxFit.fill,
              width: 120,
              height: 120,
            ),
          ),
          if (favoritesData.discount != 0 && isOldPrice)
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              padding: EdgeInsets.all(5),
              child: Text(
                "Discount",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
        ]),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                favoritesData.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      "${favoritesData.price.round()}",
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (favoritesData.discount != 0 && isOldPrice)
                      Text(
                        "${favoritesData.oldPrice.round()}",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough),
                        textAlign: TextAlign.start,
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: BottomBarCubit.get(context)
                              .favoriteProducts[favoritesData.id]
                          ? defaultColor
                          : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            print(favoritesData.id.toString());
                            BottomBarCubit.get(context)
                                .getFcavoritesProducts(favoritesData.id);
                          },
                          icon: Icon(Icons.favorite_border)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

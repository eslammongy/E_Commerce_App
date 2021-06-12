import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget buildBottomBarContainer(BottomBarCubit myCubit) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            blurRadius: 60,
            color: Colors.black.withOpacity(0.8),
            offset: Offset(0, 15),
          )
        ]),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GNav(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 600),
        tabs: [
          GButton(
            gap: 10,
            icon: Icons.home,
            iconColor: Colors.black87,
            iconActiveColor: Color(0xffE55800),
            text: "Home",
            textColor: Color(0xffE55800),
            backgroundColor: Colors.deepOrange.withOpacity(0.2),
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          GButton(
              gap: 10,
              icon: Icons.apps,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Category",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
          GButton(
              gap: 10,
              icon: Icons.favorite,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Favorite",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
          GButton(
              gap: 10,
              icon: Icons.settings,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Setting",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
        ],
        selectedIndex: myCubit.currentPageIndex,
        onTabChange: (index) {
          myCubit.changeBottom(index);
        },
      ),
    ),
  );
}

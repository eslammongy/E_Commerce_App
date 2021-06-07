import 'package:e_commerce_app/model/onboarding_item.dart';
import 'package:flutter/material.dart';

Widget buildOnBaordingItem(BuildContext context, OnBoardingItem onBoardingItem,
        PageController PageController, index) =>
    Column(
      children: [
        Expanded(child: Image(image: AssetImage("${onBoardingItem.image}"))),
        SizedBox(
          height: 30,
        ),
        Text(
          "${onBoardingItem.title}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${onBoardingItem.desc}",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "assets/fonts/RobotoCondensed-Light.ttf"),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );

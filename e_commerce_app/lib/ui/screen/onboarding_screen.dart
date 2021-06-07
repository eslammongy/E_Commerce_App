import 'package:e_commerce_app/model/onboarding_item.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:e_commerce_app/ui/screen/login_screen.dart';
import 'package:e_commerce_app/ui/widgets/indicator_container.dart';
import 'package:e_commerce_app/ui/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  int currentIndex = 0;

  bool lastPage = false;

  List<OnBoardingItem> items = [
    OnBoardingItem(
        title: "Welcome To App",
        desc:
            "When you are overwhelmed by the amount of the work you have on your plate , stop and rethink",
        image: "assets/images/img1.png"),
    OnBoardingItem(
        title: "Welcome To App",
        desc:
            "When you are overwhelmed by the amount of the work you have on your plate , stop and rethink",
        image: "assets/images/img2.png"),
    OnBoardingItem(
        title: "Welcome To App",
        desc:
            "When you are overwhelmed by the amount of the work you have on your plate , stop and rethink",
        image: "assets/images/img3.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IndicatorCircle(currentIndex),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (lastPage) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    } else {
                      pageController.nextPage(
                          duration: Duration(microseconds: 700),
                          curve: Curves.bounceInOut);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildOnBaordingItem(
                    context, items[index], pageController, index),
                itemCount: items.length,
                onPageChanged: (int index) {
                  if (index == items.length - 1) {
                    setState(() {
                      lastPage = true;
                      currentIndex = index;
                    });
                  } else {
                    setState(() {
                      currentIndex = index;
                      lastPage = false;
                    });
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment(0.1, 0.9),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: defaultColor,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "G0",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

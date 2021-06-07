import 'package:e_commerce_app/style/color.dart';
import 'package:flutter/material.dart';

class IndicatorCircle extends StatelessWidget {
  final int index;
  IndicatorCircle(this.index);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildContainer(index == 0 ? defaultColor : Colors.deepOrange),
          buildContainer(index == 1 ? defaultColor : Colors.deepOrange),
          buildContainer(index == 2 ? defaultColor : Colors.deepOrange),
        ],
      ),
    );
  }

  Widget buildContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(5),
        height: 10,
        width: 20,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

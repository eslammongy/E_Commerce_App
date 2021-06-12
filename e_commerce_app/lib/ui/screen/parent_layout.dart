import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:e_commerce_app/ui/screen/search_screen.dart';
import 'package:e_commerce_app/ui/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ParentLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          var bottomBarBloc = BottomBarCubit();
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                "Bay it",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Pacifico",
                    fontWeight: FontWeight.w600,
                    color: defaultColor),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            backgroundColor: HexColor('E7ECEF'),
            body: bottomBarBloc.bottomBarPages[bottomBarBloc.currentPageIndex],
            bottomNavigationBar: buildBottomBarContainer(bottomBarBloc),
          );
        });
  }
}

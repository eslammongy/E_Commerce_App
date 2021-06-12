import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/model/home_model.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:e_commerce_app/ui/screen/category_screen.dart';
import 'package:e_commerce_app/ui/screen/favorite_screen.dart';
import 'package:e_commerce_app/ui/screen/home_screen.dart';
import 'package:e_commerce_app/ui/screen/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarCubit extends Cubit<BottomBarStatus> {
  BottomBarCubit() : super(BottomBarInitialStatus());

  static BottomBarCubit get(context) => BlocProvider.of(context);

  int currentPageIndex = 0;
  HomeModel homeModel;
  List<Widget> bottomBarPages = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    currentPageIndex = index;
    emit(BottomBarChangeStatus());
  }

  void getHomeData() {
    emit(ShopLoadingHomeStatus());
    DioServices.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data.banners[0].image);
      print(homeModel.status);
      emit(ShopSuccessHomeStatus());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeStatus());
    });
  }
}

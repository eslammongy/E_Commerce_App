import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/model/favorite_model.dart';
import 'package:e_commerce_app/model/favorite_product.dart';
import 'package:e_commerce_app/model/home_model.dart';
import 'package:e_commerce_app/model/login_model.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:e_commerce_app/ui/screen/category_screen.dart';
import 'package:e_commerce_app/ui/screen/favorite_screen.dart';
import 'package:e_commerce_app/ui/screen/home_screen.dart';
import 'package:e_commerce_app/ui/screen/settimg_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarCubit extends Cubit<BottomBarStatus> {
  BottomBarCubit() : super(BottomBarInitialStatus());

  static BottomBarCubit get(context) => BlocProvider.of(context);

  int currentPageIndex = 0;
  Map<int, bool> favoriteProducts = {};
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
      print(token);
      homeModel.data.products.forEach((element) {
        favoriteProducts.addAll({element.id: element.inFavorites});
      });
      print(favoriteProducts.toString());
      emit(ShopSuccessHomeStatus());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeStatus());
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    DioServices.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);
      emit(ShopSuccessCategoryStatus());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoryStatus());
    });
  }

  FavoriteProducts getMyfavoriteProducts;
  void getFcavoritesProducts(int productID) {
    favoriteProducts[productID] = !favoriteProducts[productID];
    emit(ShopSuccessChangeFavoritStatus(
        favoriteProducts: getMyfavoriteProducts));
    DioServices.postData(
      url: FAVORITES,
      data: {
        'product_id': productID,
      },
      token: token,
    ).then((value) {
      getMyfavoriteProducts = FavoriteProducts.formJson(value.data);
      if (!getMyfavoriteProducts.status) {
        favoriteProducts[productID] = !favoriteProducts[productID];
      } else {
        getFavoriteProductsData();
      }
      print(value.data);
      emit(ShopSuccessSaveFavoritStatus());
    }).catchError((onError) {
      print(onError.toString());
      favoriteProducts[productID] = !favoriteProducts[productID];
      emit(ShopErrorChangeFavoritStatus());
    });
  }

  FavoritesModel favoritesModel;
  void getFavoriteProductsData() {
    emit(ShopLoadingGetFavoritStatus());
    DioServices.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritStatus());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetFavoritStatus());
    });
  }

  UserLoginModel userModel;
  void getUserInfo() {
    emit(ShopLoadingGetUserInfoStatus());
    DioServices.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserLoginModel.fromJson(value.data);
      //print(homeModel.data.banners[0].image);
      print("name :" + userModel.data.name);
      emit(ShopSuccessGetUserInfoStatus(loginModel: userModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetUserInfoStatus());
    });
  }

  void updateUserInfo({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserInfoStatus());
    DioServices.putData(
      url: UPDATE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserLoginModel.fromJson(value.data);
      //print(homeModel.data.banners[0].image);
      print("name :" + userModel.data.name);
      emit(ShopSuccessUpdateUserInfoStatus(loginModel: userModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUpdateUserInfoStatus());
    });
  }
}

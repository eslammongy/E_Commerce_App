import 'package:e_commerce_app/model/favorite_product.dart';
import 'package:e_commerce_app/model/login_model.dart';
import 'package:flutter/cupertino.dart';

abstract class BottomBarStatus {}

class BottomBarInitialStatus extends BottomBarStatus {}

class BottomBarChangeStatus extends BottomBarStatus {}

class ShopLoadingHomeStatus extends BottomBarStatus {}

class ShopSuccessHomeStatus extends BottomBarStatus {}

class ShopErrorHomeStatus extends BottomBarStatus {}

class ShopLoadingCategoryStatus extends BottomBarStatus {}

class ShopSuccessCategoryStatus extends BottomBarStatus {}

class ShopErrorCategoryStatus extends BottomBarStatus {}

class ShopSuccessChangeFavoritStatus extends BottomBarStatus {
  final FavoriteProducts favoriteProducts;
  ShopSuccessChangeFavoritStatus({this.favoriteProducts});
}

class ShopSuccessSaveFavoritStatus extends BottomBarStatus {}

class ShopErrorChangeFavoritStatus extends BottomBarStatus {}

class ShopLoadingGetFavoritStatus extends BottomBarStatus {}

class ShopSuccessGetFavoritStatus extends BottomBarStatus {}

class ShopErrorGetFavoritStatus extends BottomBarStatus {}

class ShopLoadingGetUserInfoStatus extends BottomBarStatus {}

class ShopSuccessGetUserInfoStatus extends BottomBarStatus {
  final UserLoginModel loginModel;
  ShopSuccessGetUserInfoStatus({@required this.loginModel});
}

class ShopErrorGetUserInfoStatus extends BottomBarStatus {}

class ShopLoadingUpdateUserInfoStatus extends BottomBarStatus {}

class ShopSuccessUpdateUserInfoStatus extends BottomBarStatus {
  final UserLoginModel loginModel;
  ShopSuccessUpdateUserInfoStatus({@required this.loginModel});
}

class ShopErrorUpdateUserInfoStatus extends BottomBarStatus {}

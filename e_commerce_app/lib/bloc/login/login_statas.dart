import 'package:e_commerce_app/model/login_model.dart';

abstract class UserLoginStates {}

class UserLoginIntialState extends UserLoginStates {}

class UserLoginLoadingState extends UserLoginStates {}

class UserLoginSuccessState extends UserLoginStates {
  final UserLoginModel loginModel;
  UserLoginSuccessState({this.loginModel});
}

class UserChangePasswordVisibiltyState extends UserLoginStates {}

class UserLoginErrorState extends UserLoginStates {
  final String errorMessage;
  UserLoginErrorState({this.errorMessage});
}

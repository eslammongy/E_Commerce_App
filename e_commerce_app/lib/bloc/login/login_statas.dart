import 'package:e_commerce_app/model/login_model.dart';

abstract class UserRegisterStates {}

class UserRegisterIntialState extends UserRegisterStates {}

class UserRegisterLoadingState extends UserRegisterStates {}

class UserRegisterSuccessState extends UserRegisterStates {
  final UserLoginModel RegisterModel;
  UserRegisterSuccessState({this.RegisterModel});
}

class UserChangePasswordVisibiltyState extends UserRegisterStates {}

class UserRegisterErrorState extends UserRegisterStates {
  final String errorMessage;
  UserRegisterErrorState({this.errorMessage});
}

import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/model/login_model.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginIntialState());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  UserLoginModel loginModel;
  void userLogin({@required String email, @required String password}) {
    emit(UserLoginLoadingState());
    DioServices.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = UserLoginModel.fromJson(value.data);
      // print(loginModel.message);
      // print(loginModel.status);
      // print(loginModel.userLoginData.email);
      emit(UserLoginSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(UserLoginErrorState(errorMessage: onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShowing = true;
  void changePasswordVisibility() {
    isPasswordShowing = !isPasswordShowing;
    suffix = isPasswordShowing
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(UserChangePasswordVisibiltyState());
  }
}

import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/model/login_model.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterCubit extends Cubit<UserRegisterStates> {
  UserRegisterCubit() : super(UserRegisterIntialState());
  static UserRegisterCubit get(context) => BlocProvider.of(context);

  UserLoginModel RegisterModel;
  void userLogin({@required String email, @required String password}) {
    emit(UserRegisterLoadingState());
    DioServices.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      RegisterModel = UserLoginModel.fromJson(value.data);

      emit(UserRegisterSuccessState(RegisterModel: RegisterModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(UserRegisterErrorState(errorMessage: onError.toString()));
    });
  }

  void userRegister(
      {@required String name,
      @required String phone,
      @required String email,
      @required String password}) {
    emit(UserRegisterLoadingState());
    DioServices.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      RegisterModel = UserLoginModel.fromJson(value.data);

      emit(UserRegisterSuccessState(RegisterModel: RegisterModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(UserRegisterErrorState(errorMessage: onError.toString()));
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

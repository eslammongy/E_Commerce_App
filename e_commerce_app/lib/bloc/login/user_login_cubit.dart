import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginIntialState());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required String password}) {
    emit(UserLoginLoadingState());
    DioServices.postData(
        path: LOGIN,
        data: {'email': email, 'password': password}).then((value) {
      print(value.data);
      emit(UserLoginSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UserLoginErrorState(errorMessage: onError.toString()));
    });
  }
}

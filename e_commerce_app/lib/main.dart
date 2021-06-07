import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/bloc/login/user_login_cubit.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/style/app_theme.dart';
import 'package:e_commerce_app/ui/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioServices.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserLoginCubit(),
        child: BlocConsumer<UserLoginCubit, UserLoginStates>(
          listener: (context, State) {},
          builder: (context, State) => MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            home: OnBoardingScreen(),
          ),
        ));
  }
}

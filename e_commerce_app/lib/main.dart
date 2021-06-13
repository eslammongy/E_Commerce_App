import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/bloc/login/user_login_cubit.dart';
import 'package:e_commerce_app/remote/api/dio_servic.dart';
import 'package:e_commerce_app/remote/api/end_point.dart';
import 'package:e_commerce_app/remote/local/cash_helper.dart';
import 'package:e_commerce_app/style/app_theme.dart';
import 'package:e_commerce_app/ui/screen/login_screen.dart';
import 'package:e_commerce_app/ui/screen/onboarding_screen.dart';
import 'package:e_commerce_app/ui/screen/parent_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioServices.init();
  await CacheHelper.init();
  Widget widget;
  bool isFirstRun = CacheHelper.getUserPreferences(key: "OnBoarding");
  token = CacheHelper.getUserPreferences(key: "token");

  if (isFirstRun != null) {
    if (token != null)
      widget = ParentLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  print(isFirstRun);

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startingWidget;
  MyApp(this.startingWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserLoginCubit(),
          ),
          BlocProvider(
              create: (BuildContext context) => BottomBarCubit()
                ..getHomeData()
                ..getCategoriesData())
        ],
        child: BlocConsumer<UserLoginCubit, UserLoginStates>(
          listener: (context, State) {},
          builder: (context, State) => MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startingWidget,
          ),
        ));
  }
}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/remote/local/cash_helper.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:e_commerce_app/ui/screen/login_screen.dart';
import 'package:e_commerce_app/ui/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarStatus>(
        listener: (context, state) {
      if (state is ShopSuccessGetUserInfoStatus) {
        print(state.loginModel.data.name);
        nameController.text = state.loginModel.data.name;
        print(state.loginModel.data.phone);
        phoneController.text = state.loginModel.data.phone;
        print(state.loginModel.data.email);
        emailController.text = state.loginModel.data.email;
      }
    }, builder: (context, state) {
      var userModel = BottomBarCubit.get(context).userModel;
      print(userModel.data.name);
      nameController.text = userModel.data.name;
      print(userModel.data.phone);
      phoneController.text = userModel.data.phone;
      print(userModel.data.email);
      emailController.text = userModel.data.email;

      return ConditionalBuilder(
        condition: BottomBarCubit.get(context).userModel != null,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    if (state is ShopLoadingUpdateUserInfoStatus)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 50,
                    ),
                    textInputField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "name must be not empty";
                          }
                          return null;
                        },
                        label: "Your Name",
                        prefix: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    textInputField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "phone must be not empty";
                          }
                          return null;
                        },
                        label: "Your Phone",
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    textInputField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "email must be not empty";
                          }
                          return null;
                        },
                        label: "Your Email",
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: defaultColor),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            BottomBarCubit.get(context).updateUserInfo(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Pacifico",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: defaultColor),
                      child: TextButton(
                        onPressed: () {
                          CacheHelper.clearUserData(key: 'token').then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                            }
                          });
                        },
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Pacifico",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

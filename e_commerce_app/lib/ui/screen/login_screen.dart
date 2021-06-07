import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_app/bloc/login/login_statas.dart';
import 'package:e_commerce_app/bloc/login/user_login_cubit.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:e_commerce_app/ui/screen/register_screen.dart';
import 'package:e_commerce_app/ui/widgets/componant.dart';
import 'package:e_commerce_app/ui/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailTextController = TextEditingController();
    var passwordTextController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => UserLoginCubit(),
        child: BlocConsumer<UserLoginCubit, UserLoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                backgroundColor: HexColor('E7ECEF'),
                body: SingleChildScrollView(
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                color: defaultColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Login now to browse our hot offers ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: textInputField(
                              controller: emailTextController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter email address";
                                }
                              },
                              label: "Email Address",
                              prefix: Icons.email_rounded),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: textInputField(
                              controller: passwordTextController,
                              suffix: Icons.visibility_off_outlined,
                              suffixPressed: () {},
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your password";
                                }
                              },
                              label: "password",
                              prefix: Icons.lock),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(15),
                          child: ConditionalBuilder(
                            condition: state is! UserLoginLoadingState,
                            builder: (context) => MaterialButton(
                                padding: EdgeInsets.all(12),
                                color: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  if (formGlobalKey.currentState.validate()) {
                                    UserLoginCubit.get(context).userLogin(
                                        email: emailTextController.text,
                                        password: passwordTextController.text);
                                  }
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don\'t have an account ?",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                "Sign Up ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

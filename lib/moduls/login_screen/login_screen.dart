import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/moduls/login_screen/cubit/login_cubit.dart';
import 'package:shop_app/moduls/register_screen/cubit/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.userLoginModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.userLoginModel.data!.token,
              ).then((value) {
                navigateAndReplace(context, LayoutScreen());
                token=state.userLoginModel.data!.token;
                print('token login =$token');
              });
            } else {
              showToast(
                text: state.userLoginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.welcome.tr(),
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    child: Text(
                                      LocaleKeys.signUp.tr(),
                                      style: TextStyle(
                                          fontSize: 18.0, color: defaultColor),
                                    ),
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                  )
                                ],
                              ),
                              Text(LocaleKeys.textContinue.tr(),
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(
                                height: 40.0,
                              ),
                              TextFormField(
                                validator: (text) {

                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffC9C9C9), width: 1.0),
                                  ),
                                  errorStyle: TextStyle(fontSize: 18),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF00C569), width: 1.0),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: LocaleKeys.email.tr(),
                                  labelStyle: TextStyle(
                                    fontSize: 21,
                                    color: const Color(0xff6A6A6A),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 21,
                                  ),
                                  prefixIcon: const Icon(Icons.email, size: 20),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 0.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'password is not correct';
                                  }
                                  return null;
                                },
                                obscureText: LoginCubit.get(context).isVisibility,
                                controller: passwordController,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(LoginCubit.get(context).suffix),
                                    onPressed: () {
                                      LoginCubit.get(context).changeVisibility();
                                    },
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffC9C9C9), width: 1.0),
                                  ),
                                  errorStyle: TextStyle(fontSize: 18),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF00C569), width: 1.0),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  labelText: LocaleKeys.password.tr(),
                                  labelStyle: TextStyle(
                                    fontSize: 21,
                                    color: const Color(0xff6A6A6A),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 21,
                                  ),
                                  prefixIcon: const Icon(Icons.lock, size: 20),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 0.0),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton(
                                  child: Text(
                                    LocaleKeys.forget.tr(),
                                    style: TextStyle(),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              ConditionalBuilder(
                                condition: states is! LoginLoadingState,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text:LocaleKeys.signIn.tr()),
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

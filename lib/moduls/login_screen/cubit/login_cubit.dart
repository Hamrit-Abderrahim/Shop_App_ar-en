import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  //*********UserLogin*********
//************visibilityPassword***************
  IconData suffix=Icons.visibility_outlined;
bool isVisibility=false;
void changeVisibility(){
  isVisibility=!isVisibility;
  suffix=isVisibility? Icons.visibility_outlined
      : Icons.visibility_off_outlined;
  emit(LoginShowPasswordState());
}
//********************userLogin-*****************
  UserModel? userModelLogin;
void userLogin({
  required String email,
  required String password,
}){
  emit(LoginLoadingState());
  DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      }
  ).then((value){
   userModelLogin=UserModel.fromJson(value!.data);
    emit(LoginSuccessState(userModelLogin!));
  }).catchError((error){
    print(error.toString());
    emit(LoginErrorState());
  });

}

}
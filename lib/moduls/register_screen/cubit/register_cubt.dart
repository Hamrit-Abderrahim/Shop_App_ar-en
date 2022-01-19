

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/moduls/register_screen/regiter_state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var picker = ImagePicker();
  File? profileImage;
  String? imagePath;
//*******PickedImageProfile*****************
  Future<void> pickedProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      imagePath=pickedFile.path;
      emit(PickedImageProfileSuccessState());
    } else {
      print('No Image Selected');
      emit(PickedImageProfileErrorState());
    }
  }
//***********RegisterUser*******************
  UserModel? userModelLogin;

void registerUser ({
  required String email,
  required String name,
  required String password,
  required String phone,
  File? images,
}){
  // final formData = FormData.fromMap({
  //   'name':name,
  //   'email':email,
  //   'phone':phone,
  //   'password':password,
  //   'images':  MultipartFile.fromFile(images!.path, filename: 'file.jpg')
  // });
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
            'name':name,
            'email':email,
            'phone':phone,
            'password':password,
            'images': images
        },
    ).then((value){
      userModelLogin=UserModel.fromJson(value!.data);
      emit(RegisterSuccessState(userModelLogin!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState());
    });
}
}

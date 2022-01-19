import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/moduls/register_screen/cubit/register_cubt.dart';
import 'package:shop_app/moduls/register_screen/regiter_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/translation/locale_keys.g.dart';

class RegisterScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child:BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state){
            if (state is RegisterSuccessState) {
              if (state.userLoginModel.status) {
                CacheHelper.saveData(
                  key: 'token',
                  value: state.userLoginModel.data!.token,
                ).then((value) {
                  token=state.userLoginModel.data!.token;
                  navigateAndReplace(context, LayoutScreen());
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
         builder: (context, state){
           var imageProfile=RegisterCubit.get(context).profileImage;

           return Scaffold(
             appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                            child:Form(
                              key:formKey ,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(LocaleKeys.signUp.tr(),style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.w900
                                        ),),
                                        Spacer(),
                                        Stack(
                                          alignment: AlignmentDirectional.bottomStart,
                                          children: [
                                            CircleAvatar(
                                              radius: 55.0,
                                              child: CircleAvatar(
                                                radius: 50.0,
                                                backgroundImage: imageProfile==null?
                                                AssetImage('assets/images/profile.jpg') :
                                                  FileImage(imageProfile) as ImageProvider,

                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 20.0,
                                              child: IconButton(
                                                onPressed:(){
                                                  RegisterCubit.get(context).pickedProfileImage();
                                                },
                                                icon:Icon(Icons.camera_alt_outlined,color: Colors.white,),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40.0,),
                                    defaultFormField(
                                      controller: nameController,
                                      type: TextInputType.text,
                                      validate: (String? value){
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Your Name';
                                        }
                                        return null;
                                      },
                                      label: LocaleKeys.name.tr(),
                                      prefix: Icons.person,
                                    ),
                                    SizedBox(height: 15.0,),
                                    defaultFormField(
                                      controller: emailController,
                                      type: TextInputType.text,
                                      validate: (String? value){
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Your Email';
                                        }
                                        return null;
                                      },
                                      label: LocaleKeys.email.tr(),
                                      prefix: Icons.email,
                                    ),
                                    SizedBox(height: 15.0,),
                                    defaultFormField(
                                      controller: phoneController,
                                      type: TextInputType.text,
                                      validate: (String? value){
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Your phone Number';
                                        }
                                        return null;
                                      },
                                      label: LocaleKeys.phone.tr(),
                                      prefix: Icons.phone,
                                    ),
                                    SizedBox(height: 15.0,),
                                    defaultFormField(
                                        controller: passwordController,
                                        type: TextInputType.text,
                                        validate: (String? value){
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your password';
                                          }
                                          return null;
                                        },
                                        label: LocaleKeys.password.tr(),
                                        prefix: Icons.lock,
                                        suffix: Icons.remove_red_eye,
                                        suffixPressed: (){}
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: TextButton(
                                        child: Text(LocaleKeys.forget.tr(),style: TextStyle(
                                        ),
                                        ),
                                        onPressed: (){},
                                      ),
                                    ),
                                    SizedBox(height: 20.0,),
                                    ConditionalBuilder(
                                      condition: state is! RegisterLoadingState,
                                      builder: (context)=> defaultButton(
                                          function:(){
                                            if(formKey.currentState!.validate()){
                                              RegisterCubit.get(context).registerUser(
                                                email: emailController.text,
                                                name: nameController.text,
                                                password: passwordController.text,
                                                phone: phoneController.text,
                                                images: imageProfile,
                                              );
                                            }
                                          },
                                          text: LocaleKeys.signUp.tr()
                                      ),
                                      fallback: (context)=>Center(child: CircularProgressIndicator(),),
                                    ),
                                    SizedBox(height: 10.0,)

                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        },
      ) ,


    );
  }
}

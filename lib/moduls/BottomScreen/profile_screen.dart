import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/moduls/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var model= AppCubit.get(context).profileModel;
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! LoadingGetProfileDataState,
            builder: (context)=>Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  color: defaultColor,
                  width: double.infinity,
                ),
                Container(
                  height: 500.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 500.0,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${model!.data!.name}',style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900
                            ),),
                            SizedBox(height: 20.0),
                            TextFormField(
                              enabled: false,
                              initialValue: '${model.data!.email}',style: TextStyle(
                                fontSize: 20.0
                            ),
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xff0E93A7), width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                labelText: LocaleKeys.email.tr(),
                                labelStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  //color: const Color(0xff6A6A6A),
                                ),
                                prefixIcon: Icon(Icons.email, size: 25,color: defaultColor,),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              enabled: false,
                              initialValue: '${model.data!.phone}',style: TextStyle(
                                fontSize: 20.0
                            ),
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xff0E93A7), width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                labelText: LocaleKeys.phone.tr(),
                                labelStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  //color: const Color(0xff6A6A6A),
                                ),
                                prefixIcon: Icon(Icons.phone, size: 25,color: defaultColor,),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            defaultButton(
                                function:(){
                                  CacheHelper.removeData(key: 'token').then((value){
                                    if(value){
                                      navigateAndReplace(context, LoginScreen());
                                    }
                                  });
                                },
                                text: 'sign out')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: NetworkImage(
                        '${model.data!.image}'
                    ),
                  ),
                ),

              ],
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
          )
        );
      },
    );
  }
}


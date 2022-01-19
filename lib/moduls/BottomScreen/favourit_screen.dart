
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/color.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
            body: ConditionalBuilder(
              condition:AppCubit.get(context).getFavoriteModel != null ,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context, index)=>buildListProductItem(AppCubit.get(context).getFavoriteModel!.data!.data[index].product
                      ,context),
                  separatorBuilder: (context, index)=>Divider(),
                  itemCount: AppCubit.get(context).getFavoriteModel!.data!.data.length
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            )
        );
      },
    );
  }
}

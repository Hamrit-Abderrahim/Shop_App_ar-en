import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: AppCubit.get(context).categoriesModel != null,
            builder: (context)=>ListView.separated(
                itemBuilder: (context, index)=>buildCategoriesItem(AppCubit.get(context).categoriesModel!.data!.data[index]),
                separatorBuilder: (context, index)=>Divider(),
                itemCount: AppCubit.get(context).categoriesModel!.data!.data.length
            ),
            fallback: (context)=>Center(child:CircularProgressIndicator()),
          )
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
              '${model.image}'),
          height: 80.0,
          width: 120.0,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 20.0,),
        Text('${model.name}',style: TextStyle(
          fontSize:20.0,
          fontWeight: FontWeight.bold
        ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}

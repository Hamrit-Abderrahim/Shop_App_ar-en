import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduls/searche_screen/cubit/search_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  var searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              elevation: 10.0,
              title :TextFormField(
                controller: searchController,
                  onFieldSubmitted: (String text){
                  SearchCubit.get(context).searchProduct(text);
                },
                style: TextStyle(fontSize: 21, color: Colors.black),
                decoration: InputDecoration(
                  labelText: LocaleKeys.search.tr(),
                  hintStyle: TextStyle(
                    fontSize: 22,
                    color: Color(0xffffffff),
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, size: 22, color: Colors.black),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                ),
              ),

            ),
            body: ConditionalBuilder(
              condition:SearchCubit.get(context).searchModel != null ,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context, index)=>buildListProductItem(SearchCubit.get(context).searchModel!.data!.data[index]
                      ,context),
                  separatorBuilder: (context, index)=>Divider(),
                  itemCount: SearchCubit.get(context).searchModel!.data!.data.length
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      )
    );
  }
}

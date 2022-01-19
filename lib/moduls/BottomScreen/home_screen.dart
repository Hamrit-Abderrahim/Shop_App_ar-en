
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/models/Home_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/moduls/details_screen/details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is SuccessChangeFavoriteDataState){
          if(!state.model.status){
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }else{
            showToast(text: state.model.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: AppCubit.get(context).homeModel != null && AppCubit.get(context).categoriesModel != null,
            builder:(context)=>productsItem(AppCubit.get(context).homeModel,AppCubit.get(context).categoriesModel,context) ,
            fallback:(context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
  Widget productsItem(HomeModel? model, CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:model!.data!.banners.map((e)=>Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: Duration(seconds: 3),
            height: 200.0,
            reverse: false,
            viewportFraction: 1.0,
            initialPage: 0,
            scrollDirection: Axis.horizontal
          ),
        ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.categories.tr(),
              style:TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800
              )
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index)=>buildCategoriesItem(categoriesModel!.data!.data[index]),
                    separatorBuilder: (context, index)=>SizedBox(width: 10.0,),
                    itemCount: categoriesModel!.data!.data.length
                ),
              ),
              SizedBox(height: 10.0,),
              Text(LocaleKeys.products.tr(),
                  style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800
                  )
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1/1.6,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(model.data!.products.length, (index) =>
                  buildGridViewItem(model.data!.products[index],context)),
          ),
        ),
        
      ],
    ),
  );

  Widget buildGridViewItem(Products products , context, )=>InkWell(
    onTap: (){
      navigateTo(context, DetailsScreen(products.id));
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(image: NetworkImage('${products.image}'),
                width: double.infinity,
                height: 200,
              ),
              if(products.discount != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                  color: Colors.red,
                  child: Text(LocaleKeys.discount.tr(),style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),),
              ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${products.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                      fontWeight: FontWeight.bold
                ),),
                Row(
                  children: [
                    Text('${products.price}',
                      style: TextStyle(
                      fontSize: 12.0,
                        color: defaultColor,
                          fontWeight: FontWeight.bold,
                        height: 1.3,
                    ),),
                    SizedBox(width: 5.0,),
                    if(products.discount !=0)
                      Text('${products.oldPrice}',
                      style: TextStyle(
                      fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    IconButton(
                        onPressed:(){
                         AppCubit.get(context).changeFavourites(products.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:AppCubit.get(context).favorites[products.id]==true ? defaultColor : Colors.grey ,
                          radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 14.0,

                            ))
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  Widget buildCategoriesItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(
          '${model.image}'),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100.0,
        color: defaultColor.withOpacity(.6),
        child: Text('${model.name}',maxLines: 1,overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
        ),),
      )
    ],
  );
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/style/color.dart';

import 'cubit/details_cubit.dart';
import 'cubit/details_state.dart';

class DetailsScreen extends StatelessWidget {
  int? id;
  DetailsScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>DetailsCubit()..getDetailsProducts(id),
      child: BlocConsumer<DetailsCubit,DetailsStates>(
        listener: (context, state){},
        builder: (context, state){
          return  Scaffold(
              appBar: AppBar(
                title: Text('Details'),
              ),
              body: ConditionalBuilder(
                condition:state is! LoadingDetailsState ,
                builder:(context)=>SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: defaultColor),
                                  bottom: BorderSide(color: defaultColor),
                                ),
                              ),
                              child: CarouselSlider(
                                items:DetailsCubit.get(context).detailsModel != null?
                                DetailsCubit.get(context).detailsModel!.data!.images!.map((e)=>Image(
                                  image: NetworkImage(e),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                ).toList():null,
                                options: CarouselOptions(
                                    autoPlay: true,
                                    autoPlayAnimationDuration: Duration(seconds: 1),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayInterval: Duration(seconds: 3),
                                    height: 250.0,
                                    reverse: false,
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    scrollDirection: Axis.horizontal
                                ),
                              ),
                            ),
                            if(DetailsCubit.get(context).detailsModel!.data!.discount != 0)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  color: Colors.red,
                                  child: Text('DISCOUNT',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),),
                                ),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('${DetailsCubit.get(context).detailsModel!.data!.price}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: defaultColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),),
                                  SizedBox(width: 5.0,),
                                  if(DetailsCubit.get(context).detailsModel!.data!.discount !=0)
                                    Text('${DetailsCubit.get(context).detailsModel!.data!.oldPrice}',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.red,
                                          decoration: TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  Spacer(),
                                  IconButton(
                                      onPressed:(){
                                        AppCubit.get(context).changeFavourites(DetailsCubit.get(context).detailsModel!.data!.id);
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor:AppCubit.get(context).favorites[DetailsCubit.get(context).detailsModel!.data!.id]==true ? defaultColor : Colors.grey ,
                                          radius: 15.0,
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 14.0,

                                          ))
                                  ),
                                ],
                              ),
                              Text('${DetailsCubit.get(context).detailsModel!.data!.name}',textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,

                              ),),
                              Text('Description:',style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800
                              ),),
                              Text('${DetailsCubit.get(context).detailsModel!.data!.description}'),
                            ],
                          ),
                        ),

                      ],
                    )
                ) ,
                fallback:(context)=> Center(
                  child: CircularProgressIndicator(),
                ) ,
              )
          );
        },
      ),
    );

  }
}

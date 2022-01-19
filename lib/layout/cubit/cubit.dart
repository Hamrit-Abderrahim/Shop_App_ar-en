

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/models/Home_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/moduls/BottomScreen/category_screen.dart';
import 'package:shop_app/moduls/BottomScreen/favourit_screen.dart';
import 'package:shop_app/moduls/BottomScreen/home_screen.dart';
import 'package:shop_app/moduls/BottomScreen/profile_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //*********changeBottomNav**********
int currentIndex=0;
List<Widget> screens=[
  HomeScreen(),
  CategoryScreen(),
  FavouriteScreen(),
  ProfileScreen(),
];

List<String> title=[
  LocaleKeys.titleHome.tr(),
  LocaleKeys.titleCat.tr(),
  LocaleKeys.titleFav.tr(),
  LocaleKeys.titleProfile.tr(),
];
void changeBottomIndex(int index){
  currentIndex=index;
  emit(ChangeBottomNavState());
}

//***********GetHomeData*********
  Map<int?, bool?> favorites={};
  HomeModel? homeModel;
void getHomeData(){
  emit(LoadingHomeDataState());
  DioHelper.getData(url: HOME,token: token)
      .then((value){
        homeModel=HomeModel.fromJson(value!.data);
        homeModel!.data!.products.forEach((element) {
          favorites.addAll({
            element.id: element.inFavourite,
          });
        });
        emit(SuccessHomeDataState());
      })
      .catchError((error){
        print(error.toString());
        emit(ErrorHomeDataState());
  });
}

//***********GetCategoriesData*********
  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    emit(LoadingHomeDataState());
    DioHelper.getData(url: GET_CATEGORIES,
        token: token)
        .then((value){
      categoriesModel=CategoriesModel.fromJson(value!.data);
      emit(SuccessCategoriesDataState());
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorCategoriesDataState());
    });
  }
  //***********ChangefAVOURITES*********
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int? productId) {
    favorites[productId]= !favorites[productId]!;
    emit(SuccessFavoriteDataState());
    DioHelper.postData(url: FAVOURITES,
        token: token,
        data: {'product_id': productId,
        })
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value!.data);
      if(!changeFavouritesModel!.status){
        favorites[productId]= !favorites[productId]!;
      }else{
        getFavourites();
      }
      emit(SuccessChangeFavoriteDataState(changeFavouritesModel!));
    })
        .catchError((error) {
      favorites[productId]= !favorites[productId]!;
      print(error.toString());
      emit(ErrorChangeFavoriteDataState());
    });
  }

  //***********ChangefAVOURITES*********
  GetFavoriteModel? getFavoriteModel;
  void getFavourites() {
    emit(LoadingGetFavoriteDataState());
    DioHelper.getData(
      url: FAVOURITES,
        token: token,

    )
        .then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value!.data);
      emit(SuccessGetFavoriteDataState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ErrorGetFavoriteDataState());
    });
  }
  //***********ChangefAVOURITES*********
  UserModel? profileModel;
  void getProfile() {
    emit(LoadingGetProfileDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
    ).then((value) {
     profileModel = UserModel.fromJson(value!.data);
      emit(SuccessGetProfileDataState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ErrorGetProfileDataState());
    });
  }

//***************ChangeLanguage/******************
//    //Language language;
//     String? apiLang;
//   void changeLanguage(String language){
//     if(language == 'ar')
//       apiLang ='ar';
//     print(language);
//     emit(ChangeArabicLanguage());
//     if(language=='en')
//       apiLang ='en';
//     print(language);
//     emit(ChangeEnglishLanguage());


}
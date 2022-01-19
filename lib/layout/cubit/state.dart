import 'package:shop_app/models/change_favourites_model.dart';

abstract class AppStates{}
class AppInitialState extends AppStates {}

//************change current index******************
class ChangeBottomNavState extends AppStates {}
//*********HomeData******************
class LoadingHomeDataState extends AppStates {}
class SuccessHomeDataState extends AppStates {}
class ErrorHomeDataState extends AppStates {}

//*********CategoriesData******************
class SuccessCategoriesDataState extends AppStates {}
class ErrorCategoriesDataState extends AppStates {}

//*********ChangeFavorite******************
class SuccessFavoriteDataState extends AppStates {}
class SuccessChangeFavoriteDataState extends AppStates {
  late final ChangeFavouritesModel model;
  SuccessChangeFavoriteDataState(this.model);
}
class ErrorChangeFavoriteDataState extends AppStates {}

//*********ChangeFavorite******************
class LoadingGetFavoriteDataState extends AppStates {}
class SuccessGetFavoriteDataState extends AppStates {}
class ErrorGetFavoriteDataState extends AppStates {}

//*********GetProfile******************
class LoadingGetProfileDataState extends AppStates {}
class SuccessGetProfileDataState extends AppStates {}
class ErrorGetProfileDataState extends AppStates {}

//*********DetailsProduct ******************

class LoadingDetailsProductState extends AppStates {}
class SuccessDetailsProductState extends AppStates {}
class ErrorDetailsProductState extends AppStates {}

//*********Change Language ******************

class ChangeArabicLanguage extends AppStates {}
class ChangeEnglishLanguage extends AppStates {}


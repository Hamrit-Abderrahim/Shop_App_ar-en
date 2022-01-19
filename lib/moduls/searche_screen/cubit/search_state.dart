import 'package:shop_app/models/change_favourites_model.dart';

abstract class SearchStates{}
class SearchInitialState extends SearchStates {}

//*********HomeData******************
class LoadingSearchState extends SearchStates {}
class SuccessSearchState extends SearchStates {}
class ErrorSearchState extends SearchStates {}



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduls/searche_screen/cubit/search_state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
void searchProduct(String? text){
  emit(LoadingSearchState());
  DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      }
  ).then((value){
    searchModel=SearchModel.fromJson(value!.data);
    emit(SuccessSearchState());
  }).catchError((error){
    print(error.toString());
    emit(ErrorSearchState());

  });
}


}
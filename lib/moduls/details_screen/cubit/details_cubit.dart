
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/details_model.dart';
import 'package:shop_app/moduls/details_screen/cubit/details_state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class DetailsCubit extends Cubit<DetailsStates> {
  DetailsCubit() : super(DetailsInitialState());
  static DetailsCubit get(context) => BlocProvider.of(context);

  //***********GetCategoriesData*********
  DetailsModel? detailsModel;
  void getDetailsProducts(int? id){
    emit(LoadingDetailsState());
    DioHelper.getData(
        url: 'products/$id',

        token: 'OJJ1rHdulGF7LKyD7NcwqobvEy6AQlnoMTSAWW9VgUpJ9TDl9aX5bKnIuqq9aQX8vNX5Vh').then((value){
          //print(value!.data);
      detailsModel=DetailsModel.fromJson(value!.data);
      print(detailsModel!.data!.name);
      emit(SuccessDetailsState());
    })
        .catchError((error){
      print(error.toString());
      emit(ErrorDetailsState());
    });
  }


}
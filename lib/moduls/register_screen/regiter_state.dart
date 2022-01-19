
import 'package:shop_app/models/user_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}

//******profileImage******************
class PickedImageProfileSuccessState extends RegisterStates{}
class PickedImageProfileErrorState extends RegisterStates{}

//******profileImage******************
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final UserModel userLoginModel;
  RegisterSuccessState(this.userLoginModel);

}
class RegisterErrorState extends RegisterStates{}


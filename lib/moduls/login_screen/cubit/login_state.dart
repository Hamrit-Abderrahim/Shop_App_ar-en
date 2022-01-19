import 'package:shop_app/models/user_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final UserModel userLoginModel;
  LoginSuccessState(this.userLoginModel);
}
class LoginErrorState extends LoginStates{
   // final String error;
   // LoginErrorState(this.error);
}

class LoginShowPasswordState extends LoginStates{}
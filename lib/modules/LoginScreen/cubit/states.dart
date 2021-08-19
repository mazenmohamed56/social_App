import 'package:flutter/widgets.dart';

abstract class LoginScreenStates {}

class InitLoginState extends LoginScreenStates {}

class LoginLoadingState extends LoginScreenStates {}

class LoginSuccessState extends LoginScreenStates {
  @required
  String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginScreenStates {
  @required
  String error;
  LoginErrorState(this.error);
}

class LoginPasswordIconChange extends LoginScreenStates {}

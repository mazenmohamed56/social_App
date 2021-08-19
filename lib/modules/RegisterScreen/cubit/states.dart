import 'package:flutter/widgets.dart';

abstract class RegisterScreenStates {}

class InitRegisterState extends RegisterScreenStates {}

class RegisterLoadingState extends RegisterScreenStates {}

class RegisterSuccessState extends RegisterScreenStates {
  @required
  String uId;
  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends RegisterScreenStates {
  @required
  String error;
  RegisterErrorState(this.error);
}

class RegisterPasswordIconChange extends RegisterScreenStates {}

class CreateUserSuccessState extends RegisterScreenStates {}

class CreateUserErrorState extends RegisterScreenStates {
  @required
  String error;
  CreateUserErrorState(this.error);
}

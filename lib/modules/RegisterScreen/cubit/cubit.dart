import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_data_model.dart';

import 'package:social_app/modules/RegisterScreen/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterScreenStates> {
  RegisterCubit() : super(InitRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  void postRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      print(value.user!.email);
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio ...',
      cover:
          'https://image.freepik.com/free-photo/copy-space-travel-concept-wooden-background_1421-421.jpg',
      image:
          'https://image.freepik.com/free-photo/questioned-bearded-man-crosses-arms-points-left-right_273609-40944.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
    emit(RegisterPasswordIconChange());
  }
}

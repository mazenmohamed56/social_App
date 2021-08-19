import 'package:flutter/material.dart';

abstract class HomeScreenStates {}

class InitHomestate extends HomeScreenStates {}

class ChangeeNavBottomBarState extends HomeScreenStates {}

class GetUserDataLoadingState extends HomeScreenStates {}

class GetUserDataSuccessState extends HomeScreenStates {}

class GetUserDataErrorState extends HomeScreenStates {
  @required
  String error;
  GetUserDataErrorState(this.error);
}

class GetAllPostsLoadingState extends HomeScreenStates {}

class GetAllPostsSuccessState extends HomeScreenStates {}

class GetAllPostsErrorState extends HomeScreenStates {
  @required
  String error;
  GetAllPostsErrorState(this.error);
}

class GetUserPostsLoadingState extends HomeScreenStates {}

class GetUserPostsSuccessState extends HomeScreenStates {}

class GetUserPostsErrorState extends HomeScreenStates {
  @required
  String error;
  GetUserPostsErrorState(this.error);
}

class NewPostState extends HomeScreenStates {}

class ChangeIsClickFormFieldState extends HomeScreenStates {}

class PickProfileImageLoadingState extends HomeScreenStates {}

class PickProfileImageSuccessState extends HomeScreenStates {}

class PickProfileImageErrorState extends HomeScreenStates {}

class PickCoverImageLoadingState extends HomeScreenStates {}

class PickCoverImageSuccessState extends HomeScreenStates {}

class PickCoverImageErrorState extends HomeScreenStates {}

class PickPostImageLoadingState extends HomeScreenStates {}

class PickPostImageSuccessState extends HomeScreenStates {}

class PickPostImageErrorState extends HomeScreenStates {}

class UpdateUserDataLoadingState extends HomeScreenStates {}

class UpdateUserDataSuccessState extends HomeScreenStates {}

class UpdateUserDataErrorState extends HomeScreenStates {}

class UploadUserDataLoadingState extends HomeScreenStates {}

class UploadUserSuccessState extends HomeScreenStates {}

class CreatNewPostLoadingState extends HomeScreenStates {}

class CreatNewPostSuccessState extends HomeScreenStates {}

class CreatNewPostErrorState extends HomeScreenStates {}

class LikePostSuccessState extends HomeScreenStates {}

class LikePostErrorState extends HomeScreenStates {}

class GetAllUsersSuccessState extends HomeScreenStates {}

class GetAllUsersErrorState extends HomeScreenStates {
  @required
  String error;
  GetAllUsersErrorState(this.error);
}

class SendMessageSuccessState extends HomeScreenStates {}

class SendMessageErrorState extends HomeScreenStates {}

class GetMessageSuccessState extends HomeScreenStates {}

class ScrollMessageSuccessState extends HomeScreenStates {}

class GetMessageErrorState extends HomeScreenStates {}

class UploadmMessagePicLoadingState extends HomeScreenStates {}

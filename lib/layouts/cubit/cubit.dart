import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/modules/ChatScreen/chat_screen.dart';
import 'package:social_app/modules/FeedsScreen/feeds_screen.dart';
import 'package:social_app/modules/NewPostScreen/new_post_screen.dart';
import 'package:social_app/modules/SettingsScreen/settings_screen.dart';
import 'package:social_app/modules/UsersScreen/users_screen.dart';
import 'package:social_app/shared/Network/local/sharedPreferences.dart';
import 'package:social_app/shared/components/components.dart';

class HomeCubit extends Cubit<HomeScreenStates> {
  HomeCubit() : super(InitHomestate());
  static HomeCubit get(context) => BlocProvider.of(context);
  late UserModel model;
  late String profileImagePath;
  late String coverImagePath;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index, context) {
    if (index == 1 || index == 3) getUsers();
    if (index == 2) {
      navigateTo(context, NewPostScreen());
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeeNavBottomBarState());
    }
  }

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
      ..collection('users')
          .doc(CacheHelper.getData(key: 'uId'))
          .get()
          .then((value) {
        model = UserModel.fromJson(value.data());
        profileImagePath = model.image;
        coverImagePath = model.cover;

        emit(GetUserDataSuccessState());
      }).catchError((error) {
        emit(GetUserDataErrorState(error));
      });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postsLikes = [];
  void getAllPostsData() {
    emit(GetAllPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) {
      posts = [];
      postsId = [];
      postsLikes = [];
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          posts.add(PostModel.fromJson(element.data()));
          postsLikes.add(value.docs.length);
          postsId.add(element.id);

          emit(GetAllPostsSuccessState());
        }).catchError((error) {});
      });
      emit(GetAllPostsSuccessState());
    });
  }

  List<PostModel> userPosts = [];
  List<String> userPostsId = [];
  List<int> userPostsLikes = [];
  void getUserPostsData({required String id}) {
    userPosts = [];
    userPostsId = [];
    userPostsLikes = [];
    emit(GetUserPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          if (element.data()['uId'] == id) {
            userPosts.add(PostModel.fromJson(element.data()));
            userPostsLikes.add(value.docs.length);
            userPostsId.add(element.id);

            emit(GetUserPostsSuccessState());
          }
        }).catchError((error) {});
      });

      emit(GetUserPostsSuccessState());
    }).catchError((error) {
      emit(GetUserPostsErrorState(error));
    });
  }

  bool isClickable = false;
  void changeIsClickForm() {
    isClickable = !isClickable;
    emit(ChangeIsClickFormFieldState());
  }

  final ImagePicker _picker = ImagePicker();
  File? profileimage;

  Future<void> pickProfilePic() async {
    emit(PickProfileImageLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      profileimage = File(pickedimage.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickProfileImageErrorState());
    }
  }

  File? coverimage;

  Future<void> pickCoverPic() async {
    emit(PickCoverImageLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      coverimage = File(pickedimage.path);
      emit(PickCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickCoverImageErrorState());
    }
  }

  void uploadProfilePic({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImagePath = value;
        profileimage = null;
        updataData(name: name, phone: phone, bio: bio);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void uploadcoverPic({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImagePath = value;
        coverimage = null;
        updataData(name: name, phone: phone, bio: bio);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(UpdateUserDataLoadingState());

    if (profileimage != null && coverimage != null) {
      uploadProfilePic(name: name, phone: phone, bio: bio);

      uploadcoverPic(name: name, phone: phone, bio: bio);
    } else if (profileimage != null)
      uploadProfilePic(name: name, phone: phone, bio: bio);
    else if (coverimage != null)
      uploadcoverPic(name: name, phone: phone, bio: bio);
    else
      updataData(name: name, phone: phone, bio: bio);
  }

  void updataData({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel usermodel = UserModel(
      name: name,
      email: model.email,
      phone: phone,
      uId: model.uId,
      bio: bio,
      cover: coverImagePath,
      image: profileImagePath,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
      changeIsClickForm();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  File? postimage;

  Future<void> pickPostImage() async {
    emit(PickPostImageLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      postimage = File(pickedimage.path);
      emit(PickPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickPostImageErrorState());
    }
  }

  String? postimagepath;

  void uploadPostPic({
    required String text,
    required var context,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postimagepath = value;
        postimage = null;
        creatNewPost(text: text, context: context);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void newPostData({
    required String text,
    required var context,
  }) {
    emit(CreatNewPostLoadingState());

    if (postimage != null)
      uploadPostPic(text: text, context: context);
    else
      creatNewPost(text: text, context: context);
  }

  void creatNewPost({
    required String text,
    required var context,
  }) {
    emit(CreatNewPostLoadingState());
    PostModel postModel = new PostModel(
        name: model.name,
        uId: model.uId,
        image: model.image,
        dateTime: DateTime.now().toString(),
        text: text,
        postImage: postimagepath ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .set(postModel.toMap())
        .then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      print(error.toString());
      emit(CreatNewPostErrorState());
    });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Likes')
        .doc(model.uId)
        .set({'liked': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikePostErrorState());
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    users = [];
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId)
            users.add(UserModel.fromJson(element.data()));
        });

        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUsersErrorState(error.toString()));
      });
  }

  String? messageImagePath;
  File? messageImage;

  Future<void> pickMessageImage() async {
    emit(PickPostImageLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      messageImage = File(pickedimage.path);
      emit(PickPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickPostImageErrorState());
    }
  }

  void uploadMessagePic({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    emit(UploadmMessagePicLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        messageImagePath = value;
        messageImage = null;
        sendMessage(receiverId: receiverId, dateTime: dateTime, text: text);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void newMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    if (messageImage != null)
      uploadMessagePic(receiverId: receiverId, dateTime: dateTime, text: text);
    else
      sendMessage(receiverId: receiverId, dateTime: dateTime, text: text);
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: model.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      imagePath: messageImagePath ?? '',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      messageImagePath = '';
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}

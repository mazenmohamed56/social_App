import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getUserData();
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index, context);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Upload), label: 'New Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Settings'),
              ]),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

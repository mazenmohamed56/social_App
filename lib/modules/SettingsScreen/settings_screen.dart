import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/modules/UserProfile/user_profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: defaultColor,
                  radius: 94,
                  child: CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(
                      '${HomeCubit.get(context).model.image}',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defultOutLinedButton(
                        onTap: () {
                          navigateTo(context, UserProfileScreen());
                        },
                        text: 'Profile',
                        icon: IconBroken.Profile)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defultOutLinedButton(
                        onTap: () {
                          signOut(context);
                        },
                        text: 'LogOut',
                        icon: IconBroken.Logout)),
              ],
            ),
          ),
        );
      },
    );
  }
}

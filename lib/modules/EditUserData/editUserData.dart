import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditUserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        nameController.text = HomeCubit.get(context).model.name;
        phoneController.text = HomeCubit.get(context).model.phone;
        bioController.text = HomeCubit.get(context).model.bio;
        var profileimage = HomeCubit.get(context).profileimage;
        var coverimage = HomeCubit.get(context).coverimage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                HomeCubit.get(context).changeIsClickForm();
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: defaultColor,
              ),
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () {
                    HomeCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                          color: defaultColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 290,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 240,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverimage != null
                                            ? FileImage(coverimage)
                                            : NetworkImage(
                                                '${HomeCubit.get(context).model.cover}',
                                              ) as ImageProvider,
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.grey[100]!.withOpacity(0.5),
                                  child: InkWell(
                                    onTap: () {
                                      HomeCubit.get(context).pickCoverPic();
                                    },
                                    child: Icon(
                                      IconBroken.Camera,
                                      color: defaultColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 94,
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage: profileimage != null
                                    ? FileImage(profileimage)
                                    : NetworkImage(
                                        '${HomeCubit.get(context).model.image}',
                                      ) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Colors.grey[100]!.withOpacity(0.9),
                                child: InkWell(
                                  onTap: () {
                                    HomeCubit.get(context).pickProfilePic();
                                  },
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeIsClickForm();
                        },
                        icon: Icon(
                          IconBroken.Edit_Square,
                          color: defaultColor,
                        ),
                      ),
                      defaultFormField(
                          isClickable: HomeCubit.get(context).isClickable,
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: IconBroken.Profile),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          isClickable: HomeCubit.get(context).isClickable,
                          controller: bioController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Bio must not be empty';
                            }
                          },
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          isClickable: HomeCubit.get(context).isClickable,
                          controller: phoneController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: IconBroken.Call),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

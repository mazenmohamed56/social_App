import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/modules/ChatDetailsScreen/chat_datails_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => true,
            widgetBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildUsersListItem(
                          context,
                          HomeCubit.get(context).users[index],
                          ChatDetaisScreen(
                              user: HomeCubit.get(context).users[index])),
                      separatorBuilder: (context, index) => mySeparator(),
                      itemCount: HomeCubit.get(context).users.length),
                ),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }
}

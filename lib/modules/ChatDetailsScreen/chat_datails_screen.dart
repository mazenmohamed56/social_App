import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetaisScreen extends StatelessWidget {
  UserModel user;
  ChatDetaisScreen({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getMessages(receiverId: user.uId);
      var messageController = TextEditingController();
      ScrollController _scrollController = ScrollController();

      return BlocConsumer<HomeCubit, HomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          '${user.image}',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${user.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            HomeCubit.get(context).messages.length > 0,
                        widgetBuilder: (context) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Expanded(
                                  child: ListView.separated(
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        if (HomeCubit.get(context)
                                                .messages[index]
                                                .senderId ==
                                            user.uId) {
                                          return buildMessage(
                                              HomeCubit.get(context)
                                                  .messages[index]);
                                        }
                                        return buildMyMessage(
                                            HomeCubit.get(context)
                                                .messages[index]);
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 5,
                                          ),
                                      itemCount: HomeCubit.get(context)
                                          .messages
                                          .length)),
                            ),
                        fallbackBuilder: (context) =>
                            Center(child: CircularProgressIndicator())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: defaultColor.withOpacity(0.8),
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: () {
                                HomeCubit.get(context).pickMessageImage();
                              },
                              child: Icon(
                                IconBroken.Image,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            color: defaultColor.withOpacity(0.8),
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: () {
                                if (messageController.text != '' ||
                                    HomeCubit.get(context).messageImage !=
                                        null) {
                                  HomeCubit.get(context).newMessage(
                                    receiverId: user.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );

                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                }
                                messageController.text = '';
                              },
                              child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (messageModel.imagePath != '')
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(messageModel.imagePath)))),
                  ),
                Text('${messageModel.text}'),
              ],
            ),
          ),
        ),
      );
  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (messageModel.imagePath != '')
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(messageModel.imagePath)))),
                    ),
                  Text('${messageModel.text}'),
                ],
              ),
            ),
          ),
        ),
      );
}

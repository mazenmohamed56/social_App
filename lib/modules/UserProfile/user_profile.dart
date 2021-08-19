import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/modules/EditUserData/editUserData.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context)
        .getUserPostsData(id: HomeCubit.get(context).model.uId);
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: defaultColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, EditUserDataScreen());
                  },
                  icon: Icon(
                    IconBroken.Edit_Square,
                    color: defaultColor,
                  ))
            ],
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      height: 290,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                width: double.infinity,
                                height: 240,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${HomeCubit.get(context).model.cover}',
                                      ),
                                    ))),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 94,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                '${HomeCubit.get(context).model.image}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${HomeCubit.get(context).model.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${HomeCubit.get(context).model.bio}',
                        style: Theme.of(context).textTheme.caption),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Posts',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                '120',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Photos',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                '50',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                '10K',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                '300',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            HomeCubit.get(context).userPosts.length > 0,
                        widgetBuilder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildListItem(
                                context, cubit.userPosts[index], index),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: cubit.userPosts.length),
                        fallbackBuilder: (context) =>
                            Center(child: Text('No posts'))),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildListItem(context, PostModel post, int index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${post.image}',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${post.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${post.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text('${post.text}',
                  style: Theme.of(context).textTheme.subtitle1),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: defaultColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#FlutterApp',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: defaultColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (post.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${post.postImage}',
                            ),
                          ))),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: defaultColor,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                '${HomeCubit.get(context).userPostsLikes[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 14,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Comments',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              '${HomeCubit.get(context).model.image}',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'New Comment...',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context)
                          .likePost(HomeCubit.get(context).userPostsId[index]);
                    },
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: defaultColor,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Like')
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

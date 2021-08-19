import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                cubit.posts.length > 0 &&
                cubit.postsLikes.length > 0 &&
                cubit.postsId.length > 0,
            widgetBuilder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Image(
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Comunicate with Friend',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontFamily: 'Jannah',
                                        color: Colors.white,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildListItem(
                                context, cubit.posts[index], index),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: cubit.posts.length)
                      ],
                    ),
                  ),
                ),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
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
                            Text('${HomeCubit.get(context).postsLikes[index]}')
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
                          .likePost(HomeCubit.get(context).postsId[index]);
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

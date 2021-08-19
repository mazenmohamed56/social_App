import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/LoginScreen/login_screen.dart';
import 'package:social_app/shared/BlocObserver.dart';
import 'package:social_app/shared/Network/local/sharedPreferences.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/Themes.dart';

void main() async {
  late Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = HomeScreen();
  } else
    widget = LoginScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
          ),
          BlocProvider(
              create: (context) => HomeCubit()
                ..getUserData()
                ..getAllPostsData()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: startWidget);
          },
        ));
  }
}

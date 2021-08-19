import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/LoginScreen/cubit/states.dart';
import 'package:social_app/modules/RegisterScreen/register_screen.dart';
import 'package:social_app/shared/Network/local/sharedPreferences.dart';
import 'package:social_app/shared/components/components.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginScreenStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.putData(key: 'uId', value: state.uId);
            navigateAndFinsh(context, HomeScreen());
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
              body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login',
                          style: TextStyle(
                            fontSize: 35,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Welcome To Shop App , Login now to see our new offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is to short';
                            }
                          },
                          suffixPressed: () {
                            cubit.changePasswordVisibilty();
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffix),
                      SizedBox(
                        height: 20,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            state is! LoginLoadingState,
                        widgetBuilder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallbackBuilder: (contex) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an acount ?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text('Register now '.toUpperCase()),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}

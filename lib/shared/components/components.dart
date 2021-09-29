import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/shared/styles/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (e) {
        onSubmit!(e);
      },
      onChanged: (e) {
        onChange!(e);
      },
      validator: (e) {
        validate(e);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void showToast({
  required String msg,
  required ToastState state,
}) async =>
    await Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }
Color toastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;

      break;
    case ToastState.WARNING:
      color = Colors.green;
      break;
  }
  return color;
}

Widget mySeparator() => Padding(
      padding:
          const EdgeInsetsDirectional.only(top: 10.0, start: 20, bottom: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[500],
      ),
    );
Widget defultOutLinedButton({
  required Function onTap,
  required String text,
  required IconData icon,
}) =>
    OutlinedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
          BorderSide(color: defaultColor, width: 2),
        )),
        onPressed: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                icon,
                color: Colors.red[700],
                size: 30,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ));
Widget buildUsersListItem(context, UserModel user, Widget widget) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateTo(context, widget);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                '${user.image}',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${user.name}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            )
          ],
        ),
      ),
    );

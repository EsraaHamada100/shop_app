import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/favorites_model.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultFormField(
    {required TextEditingController controller,
    required TextInputType type,
    required String? Function(String?) validate,
    required IconData prefix,
    required onChange,
    String label = "",
    IconData? suffix,
    void Function()? suffixPressed,
    void Function(String)? onSubmit,
    bool isPassword = false}) {
  return TextFormField(
    /*********************************/
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: label,
      icon: Icon(prefix),
      suffixIcon: IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix),
      ),
    ),
    onFieldSubmitted: onSubmit,
    controller: controller,
    keyboardType: type,
    validator: validate,
    onChanged: onChange,
    obscureText: isPassword,
  );
}

Widget defaultTextButton(
    {required void Function()? function, required String text}) {
  return TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()),
  );
}

enum ToastStates { success, error, warning }

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

Color chooseToastColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
  }
  return color;
}

customButton({
  required bool buttonCondition,
  required void Function()? onTap,
  required String buttonText,
}) {
  return ConditionalBuilder(
    condition: buttonCondition,
    builder: (context) {
      return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: defaultColor,
          ),
          child: Text(
            buttonText.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
        ),
      );
    },
    fallback: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget buildProductItem(product, BuildContext context,
        {bool isSearch = false}) =>
    Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(product.image),
                width: 100,
                height: 120,
              ),
              if (!isSearch && product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, color: Colors.black),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        product!.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.3,
                          color: defaultColor,
                        ),
                      ),
                      if (!isSearch && product.discount != 0)
                        Text(
                          product.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(product.id);
                          // print(model.product!.inFavorites);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favorites[product.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

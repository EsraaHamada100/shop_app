import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/login_statues.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // means there is no error in the server but
          // may the user is ont register
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              // here he will print true
              print(state.loginModel.message);
              // print(state.loginModel.favoritesDataList.token);
              showToast(
                  text: state.loginModel.message, state: ToastStates.success);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then(
                (value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                ),
              );
            } else {
              // here he will print false
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastStates.error);
              // Fluttertoast.showToast(
              //     msg: state.loginModel.message,
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0,
              // );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            // I wrap them with singleChildScrollView because of the error
            // that appears when the keyboard shows you can't see the fields
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/login.png'),
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                        onChange: (String hello) {},
                      ),
                      SizedBox(height: 20),
                      defaultFormField(
                          isPassword: LoginCubit.get(context).invisiblePassword,
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          onChange: (String hello) {},
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      customButton(
                        buttonCondition: state != LoginLoadingState(),
                        onTap: () {
                          print('You tapped sign in');
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        buttonText: 'login',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          defaultTextButton(
                            function: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterScreen(),
                                ),
                              );
                            },
                            text: 'register',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

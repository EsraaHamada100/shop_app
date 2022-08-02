import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/app_components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/cubit/login_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('register screen'),
          ),
      body: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState ) {
            if (state.registerModel.status) {
              // here he will print true
              print(state.registerModel.message);
              // print(state.loginModel.favoritesDataList.token);
              showToast(
                  text: state.registerModel.message,
                  state: ToastStates.success);
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
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
              print(state.registerModel.message);
              showToast(
                  text: state.registerModel.message, state: ToastStates.error);
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
        builder: (context, state) => SingleChildScrollView(
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
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Register now to browse our hot offers',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: _nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                    },
                    label: 'Name',
                    prefix: Icons.email_outlined,
                    onChange: (String hello) {},
                  ),
                  defaultFormField(
                    controller: _emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      }
                    },
                    label: 'Email Address',
                    prefix: Icons.email_outlined,
                    onChange: (String hello) {},
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                      isPassword: RegisterCubit.get(context).invisiblePassword,
                      controller: _passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,
                      suffix: RegisterCubit.get(context).suffix,
                      suffixPressed: () {
                        RegisterCubit.get(context).changePasswordVisibility();
                      },
                      onChange: (String hello) {},
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                          );
                        }
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: _phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone';
                      }
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    onChange: (String hello) {},
                  ),
                  SizedBox(height: 40),
                  customButton(
                    buttonCondition: state != RegisterLoadingState(),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        RegisterCubit.get(context).userRegister(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text,
                        );
                      }
                    },
                    buttonText: 'register',
                  ),
                  // ConditionalBuilder(
                  //   condition: state != LoginLoadingState(),
                  //   builder: (context) {
                  //     return InkWell(
                  //       borderRadius: BorderRadius.circular(5),
                  //       onTap: () {
                  //         print('You tapped sign in');
                  //         if (formKey.currentState!.validate()) {
                  //           RegisterCubit.get(context).userLogin(
                  //             email: _emailController.text,
                  //             password: _passwordController.text,
                  //           );
                  //         }
                  //       },
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         width: double.maxFinite,
                  //         padding: EdgeInsets.all(15),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: defaultColor,
                  //         ),
                  //         child: Text(
                  //           'login'.toUpperCase(),
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyText1!
                  //               .copyWith(color: Colors.white),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   fallback: (context) =>
                  //       Center(child: CircularProgressIndicator()),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('Don\'t have an account ?'),
                  //     defaultTextButton(
                  //       function: () {
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 RegisterScreen(),
                  //           ),
                  //         );
                  //       },
                  //       text: 'register',
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

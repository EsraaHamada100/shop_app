import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // if you try to do that it will not work because
        // states are changing very fast so we will use another way
        if (state is ShopSuccessUserDataState) {
          nameController.text = state.loginModel.data!.name;
          emailController.text = state.loginModel.data!.email;
          phoneController.text = state.loginModel.data!.phone;
        }
      },
      builder: (context, state) {
        LoginModel model = ShopCubit.get(context).userModel!;
        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is ShopLoadingUpdateUserState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20
                ),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter a name';
                    }
                    return null;
                  },
                  prefix: Icons.person,
                  onChange: (val) {},
                ),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter an email';
                    }
                    return null;
                  },
                  prefix: Icons.email,
                  onChange: (val) {},
                ),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter a phone';
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  onChange: (val) {},
                ),
                SizedBox(height: 40),
                // InkWell(
                //   borderRadius: BorderRadius.circular(5),
                //   onTap: ,
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: double.maxFinite,
                //     padding: EdgeInsets.all(15),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: defaultColor,
                //     ),
                //     child: Text(
                //       'logout'.toUpperCase(),
                //       style: Theme.of(context)
                //           .textTheme
                //           .bodyText1!
                //           .copyWith(color: Colors.white),
                //     ),
                //   ),
                // ),
                customButton(
                  buttonCondition: true,
                  onTap: () {
                    signOut(context);
                  },
                  buttonText: 'logout',
                ),
                SizedBox(height: 40),
                customButton(
                  buttonCondition: state != ShopLoadingUpdateUserState,
                  onTap: () {
                    ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                  },
                  buttonText: "update",
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

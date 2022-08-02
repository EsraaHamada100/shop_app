import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/register_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      // that url is not the whole url but the end point like
      // https://student.valuxapps.com/api/Register => this url will take
      // only Register and the rest we will put it in the base url
      url: register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel.status);
      print(registerModel.message);
      // print(RegisterModel.data?.token);
      if (!registerModel.status) {
        showToast(
          text: registerModel.message.toString(),
          state: ToastStates.error,
        );
        emit(RegisterErrorState('error'));
        return;
      }
      CacheHelper.saveData(key: 'token', value: registerModel.data?.token);
      myToken = CacheHelper.getData(key: 'token');
      print('the token is ${CacheHelper.getData(key: 'token')}');
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print('the error is $error');
      showToast(text: error.toString(), state: ToastStates.error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool invisiblePassword = true;
  void changePasswordVisibility() {
    invisiblePassword = !invisiblePassword;
    suffix = invisiblePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}

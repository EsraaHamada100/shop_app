import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_statues.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      // that url is not the whole url but the end point like
      // https://student.valuxapps.com/api/login => this url will take
      // only login and the rest we will put it in the base url
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      // print(loginModel.data?.token);
      if (!loginModel.status) {
        showToast(
          text: loginModel.message.toString(),
          state: ToastStates.error,
        );
        emit(LoginErrorState('error'));
        return;
      }
      CacheHelper.saveData(key: 'token', value: loginModel.data?.token);
      myToken = CacheHelper.getData(key: 'token');
      print('the token is ${CacheHelper.getData(key: 'token')}');
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print('the error is $error');
      showToast(text: error.toString(), state: ToastStates.error);
      emit(LoginErrorState(error.toString()));
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

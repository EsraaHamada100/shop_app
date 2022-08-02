

import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';
import 'app_statues.dart';

class AppCubit extends Cubit<AppStatues> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode(){
    isDark = !isDark ;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });

  }


}
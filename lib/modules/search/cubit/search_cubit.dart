import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';
import '../../../models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: searchProduct,token: myToken, data: {"text": text})
        .then((value) {
          model = SearchModel.fromJson(value.data);
          if(model != null){
            print(model!.data.productsDataList.length);
            emit(SearchSuccessState());
          }else{
            emit(SearchErrorState());
            showToast(text: 'خطأ أثناء البحث', state: ToastStates.error);
          }
    })
        .catchError((error) {
          print(error.toString());
          emit(SearchErrorState());
    });
  }
}

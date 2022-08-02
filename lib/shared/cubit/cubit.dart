import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/login_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialState());

  // get an instance of ShopCubit class
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: myToken).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data.products.forEach((product) {
          favorites.addAll({product.id: product.inFavorites});
        });
        print(favorites.toString());
        emit(ShopSuccessHomeDataState());
      },
    );
    //     .catchError((error) {
    //   print(error);
    //   emit(ShopErrorHomeDataState());
    // });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    // emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: categories,
      token: myToken,
    ).then(
      (value) {
        print(value.data);
        categoriesModel = CategoriesModel.fromJson(value.data);
        // print(homeModel!.data.banners[0].image);
        emit(ShopSuccessCategoriesState());
      },
    );
    //     .catchError((error) {
    //   print(error);
    //   emit(ShopErrorCategoriesState());
    // });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    // I add this emit to make it change directly
    // before entering the function
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: Favorites,
      data: {'product_id': productId},
      token: myToken,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      // delete the change when an error occur
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    });
    //     .catchError((error, errorStack){
    //   favorites[productId] = !favorites[productId]!;
    //   emit(ShopErrorChangeFavoritesState());
    //   print(error);
    //   print(errorStack);
    // });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    print('we are in getFavorites');
    // emit(ShopLoadingHomeDataState());
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: Favorites,
      token: myToken,
    ).then(
      (value) {
        print('we are getting favoriets data');
        print('the token is $myToken');
        print("We get " + value.data.toString());
        favoritesModel = FavoritesModel.fromJson(value.data);
        if (favoritesModel == null) {
          print('damn programming');
        } else if (favoritesModel!.data == null) {
          print('damm 2');
        } else if (favoritesModel!.data.favoritesDataList == null) {
          print('damn 3');
        } else {
          print(
              'cool programming ${favoritesModel!.data.favoritesDataList[1].product}');
        }

        // print(homeModel!.data.banners[0].image);
        emit(ShopSuccessGetFavoritesState());
      },
    ).catchError((error, errorStack) {
      print(error);
      // print(errorStack);
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;

  void getUserData() {
    print('we are in getFavorites');
    // emit(ShopLoadingHomeDataState());
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: profile,
      token: myToken,
    ).then(
      (value) {
        print('we are getting favoriets data');
        print('the token is $myToken');
        print("We get " + value.data.toString());
        userModel = LoginModel.fromJson(value.data);
        // if(userModel == null){
        //   print('user model is null');
        // }else if(userModel!.data == null){
        // print('print the data is null');}
        // else if(userModel!.data!.name == null){
        //   print('the name is null');
        // }else {
        //   print('every thing is ok');
        // }

        // print(homeModel!.data.banners[0].image);
        if (userModel != null) {
          emit(ShopSuccessUserDataState(userModel!));
        } else {
          debugPrint('user model is null');
        }
      },
    ).catchError((error, errorStack) {
      print(error);
      // print(errorStack);
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    print('we are in getFavorites');
    // emit(ShopLoadingHomeDataState());
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: updateProfile,
      data: {"name": name, "email": email, "phone": phone},
      token: myToken,
    ).then(
      (value) {
        print('we are getting favoriets data');
        print('the token is $myToken');
        print("We get " + value.data.toString());
        userModel = LoginModel.fromJson(value.data);
        // if(userModel == null){
        //   print('user model is null');
        // }else if(userModel!.data == null){
        // print('print the data is null');}
        // else if(userModel!.data!.name == null){
        //   print('the name is null');
        // }else {
        //   print('every thing is ok');
        // }

        // print(homeModel!.data.banners[0].image);
        if (userModel != null) {
          if (userModel!.status == false) {
            showToast(
              text: userModel!.message.toString(),
              state: ToastStates.error,
            );
            emit(ShopErrorUpdateUserState());
          } else {
            emit(ShopSuccessUpdateUserState(userModel!));
            showToast(
              text: userModel!.message.toString(),
              state: ToastStates.success,
            );
          }
        } else {
          debugPrint('user model is null');
        }
      },
    ).catchError((error, errorStack) {
      print(error);
      // print(errorStack);
      emit(ShopErrorUpdateUserState());
    });
  }
}

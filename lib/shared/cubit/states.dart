import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopState {}

class InitialState extends ShopState {}

class ChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopState {}

class ShopLoadingGetFavoritesState extends ShopState {}

class ShopErrorGetFavoritesState extends ShopState {}

class ShopSuccessGetFavoritesState extends ShopState {}

class ShopLoadingUserDataState extends ShopState {}

class ShopErrorUserDataState extends ShopState {}

class ShopSuccessUserDataState extends ShopState {
  final LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}


class ShopLoadingUpdateUserState extends ShopState {}

class ShopErrorUpdateUserState extends ShopState {}

class ShopSuccessUpdateUserState extends ShopState {
  final LoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

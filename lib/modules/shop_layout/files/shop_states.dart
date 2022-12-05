import 'package:shop_app/model/change_favorites_model.dart';

abstract class ShopStates{}


class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoryState extends ShopStates{}
class ShopErrorCategoryState extends ShopStates{}

class ShopSuccessFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessFavoritesState( this.model);
}
class ShopErrorFavoritesState extends ShopStates{}
class ShopSuccessToggleFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{}
class ShopErrorUpdateUserDataState extends ShopStates{}
class ShopLoadingUpdateUserDataState extends ShopStates{}





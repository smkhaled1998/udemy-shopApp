import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/shop_login_model.dart';
import 'package:shop_app/modules/shop_layout/files/shop_states.dart';

import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/dio_helper.dart';


import '../../../model/change_favorites_model.dart';
import '../../../shared/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super (ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);


  int currentIndex=0;
  void changeNavBarIndex(int index){
   currentIndex = index;
   emit(ShopChangeBottomNavBarState());
  }


    HomeModel? homeModel;
    Map<int,bool> favorites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url:HOME,
        token:token
    ).then((value) {



      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites
        });

      });


      emit(ShopSuccessHomeDataState());
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorHomeDataState());});
  }

  CategoryModel? categoryModel;
  void getCategoryData(){

    DioHelper.getData(
        url: GET_CATEGORY,
        lang: 'en',
        token: token
    ).then((value) {
      categoryModel= CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((error){
      emit(ShopErrorCategoryState());
      print(error.toString());});
  }

  ChangeFavoritesModel? changeFavoritesModel;
 void changeFavorites(int productId){
   favorites[productId]=!favorites[productId]!;
   emit(ShopSuccessToggleFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id':productId
        })
        .then((value) {
          changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
          if (!changeFavoritesModel!.status!){
            favorites[productId]=!favorites[productId]!;}
          else {
            getFavoritesData();
          }

          emit(ShopSuccessFavoritesState(changeFavoritesModel!));

    })
        .catchError((error){
      emit(ShopErrorFavoritesState());
    });
 }

 FavoritesModel? favoritesModel;
 void getFavoritesData(){
emit(ShopLoadingUserDataState());
   DioHelper.getData(
       url: FAVORITES,
           token: token
   ).then((value) {
     favoritesModel= FavoritesModel.fromJson(value.data);

     emit(ShopSuccessGetFavoritesState());
   }).catchError((error){
     emit(ShopErrorGetFavoritesState());
   });
 }

 ShopLoginModel? userData;
 void getUserData(){

   emit(ShopLoadingUserDataState());
   DioHelper.getData(
       url: PROFILE,
       token: token,
       lang: 'ar')
       .then((value) {
         userData=ShopLoginModel.fromJson(value.data);
         print(userData!.data!.name.toString());
         emit(ShopSuccessUserDataState());
   })
       .catchError((error) {
         emit(ShopErrorUserDataState());
   });
  }


  void UpdateUserData(
  {
  required String name,
  required String email,
  required String phone,
}
      ){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: 'update-profile',
        token: token,
        lang: 'ar',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        })
        .then((value) {
      userData=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState());
    })
        .catchError((error) {
      emit(ShopErrorUpdateUserDataState());
    });
  }


}
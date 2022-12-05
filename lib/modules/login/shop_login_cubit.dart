import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/shop_login_model.dart';

import 'package:shop_app/shared/network/dio_helper.dart';

import '../../shared/end_points.dart';
import 'shop_login_states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool seen =false;
  void changeShopLoginVisibility(){
    seen=!seen;
    emit(ShopLoginVisibilityState());
  }

  ShopLoginModel? loginModel;
  void userLogin (
  {
  required String email,
  required String password,
}
      ) {
     emit(ShopLoginLoadingState());

    DioHelper.postData(
        url:LOGIN,
        data:{
          'email':email,
          'password':password
        }).then((value){
          loginModel=ShopLoginModel.fromJson(value.data);
          print("message is ${loginModel?.message}");
      emit(ShopLoginSuccessState(loginModel!));
          print(value.data.toString());
    }).catchError((error){
      emit(ShopLoginErrorState());
      print('error is ${error.toString()}');
    });
  }
}
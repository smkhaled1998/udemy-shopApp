import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/shop_login_model.dart';
import 'package:shop_app/modules/register/register_states.dart';

import 'package:shop_app/shared/network/dio_helper.dart';

import '../../shared/end_points.dart';


class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool seen =false;
  void changeRegisterVisibility(){
    seen=!seen;
    emit(RegisterVisibilityState());
  }

  ShopLoginModel? loginModel;
  void userRegister (
      {
        required String email,
        required String password,
        required String name,
        required String phone,
      }
      )
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
        url:REGISTER,
        data:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }).then((value){
      loginModel=ShopLoginModel.fromJson(value.data);
      print("message is ${loginModel?.message}");
      emit(RegisterSuccessState(loginModel));
      print(value.data.toString());
    }).catchError((error){
      emit(RegisterErrorState());
      print('error is ${error.toString()}');
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/shop_login_cubit.dart';
import 'package:shop_app/modules/shop_layout/files/shop_cubit.dart';
import 'package:shop_app/modules/shop_layout/files/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/on_boarding_screen.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();


  DioHelper.init();
  await CacheHelper.init();

  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  dynamic token = CacheHelper.getData(key: 'token');
  print(token);

  Widget widget;
  if (onBoarding == false)
    {
      if (token != null) {
        widget= ShopLayout();
      } else {
        widget = ShopLoginScreen();
      }
    }
  else {
    widget= OnBoardingScreen();
  }
  runApp(MyApp( startWidget:widget,));
}

class MyApp extends StatelessWidget {

  final Widget  startWidget;
  const MyApp({Key? key,required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUserData()),
        BlocProvider(create: (context)=> ShopLoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home:  OnBoardingScreen()
      ),
    );
  }
}

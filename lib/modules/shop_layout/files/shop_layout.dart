import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_layout/files/shop_states.dart';
import 'package:shop_app/modules/shop_layout/screens/cateogries.dart';
import 'package:shop_app/modules/shop_layout/screens/favorites.dart';
import 'package:shop_app/modules/shop_layout/screens/products.dart';
import 'package:shop_app/modules/shop_layout/screens/search.dart';

import 'package:shop_app/modules/shop_layout/screens/settings.dart';
import 'package:shop_app/modules/shop_layout/files/shop_cubit.dart';

import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';

class ShopLayout extends StatelessWidget {

List <Widget> screen=[const ProductScreen(),const CategoryScreen() ,const FavoriteScreen(), SettingScreen()];
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
      return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sallah'),
              centerTitle: true,
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  // CacheHelper.removeData(key: 'token').then((value) {
                  //   if (value) {
                  //     navigateAndReplace(context, ShopLoginScreen());
                  //     showToast(text: 'تم تسجيل الخروج بنجاح', state: ToastStates.SUCCESS);
                  //   }
                  // });
                }, icon: Icon(Icons.offline_bolt)),
              ],
            ),
            body: screen [cubit.currentIndex],
            bottomNavigationBar:BottomNavigationBar(
              items: const [
                BottomNavigationBarItem( icon:Icon(Icons.home),label: 'Product'),
                BottomNavigationBarItem( icon:Icon(Icons.category_outlined),label: 'Category'),
                BottomNavigationBarItem( icon:Icon(Icons.favorite),label: 'Favorite'),
                BottomNavigationBarItem( icon:Icon(Icons.settings),label: 'Setting'),
              ],
              currentIndex:cubit.currentIndex ,
              onTap: (index){
                cubit.changeNavBarIndex(index);
              },
            ),
          );
        },
      );

  }
}

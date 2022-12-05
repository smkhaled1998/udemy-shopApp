import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/modules/shop_layout/files/shop_cubit.dart';

import '../files/shop_states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is ! ShopLoadingUserDataState,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildFavItem( cubit.favoritesModel!.data!.data[index].product!,context),
              separatorBuilder: (context,index)=> const Divider(thickness: 2,),
              itemCount: cubit.favoritesModel!.data!.data.length),
           fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget buildFavItem (Product model,context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage((model.image)!),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (model.name)!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      (model.price.toString()),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if ((model.discount) != 0)
                      Text(model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id as int);

                        },
                        icon:   CircleAvatar(
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]! ? Colors.blue:Colors.grey,
                          radius: 15,
                          child:   Icon(
                              size: 14,
                              color: Colors.white,
                              Icons.favorite_border),
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

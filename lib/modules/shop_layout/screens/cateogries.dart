import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/files/shop_cubit.dart';

import '../../../model/category_model.dart';
import '../files/shop_states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(cubit.categoryModel!.data!.data[index]),
            separatorBuilder: (context,index)=>const Divider(thickness: 3,),
            itemCount: cubit.categoryModel!.data!.data.length);
      },
    );
  }
  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
                height: 150,
                width: 150,
                image: NetworkImage('${model.image}')
            ),
            // Container(
            //     width: 150,
            //     color: Colors.black.withOpacity(.8),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 1.0),
            //       child: Text(
            //         '${model.name}',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           color: Colors.white,),),
            //     ))
          ],
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
      ],
    ),
  );
}

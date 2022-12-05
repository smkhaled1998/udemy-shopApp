import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_layout/files/shop_cubit.dart';
import 'package:shop_app/modules/shop_layout/files/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit =ShopCubit.get(context);
    nameController.text= cubit.userData!.data!.name!;
    phoneController.text= cubit.userData!.data!.phone!;
    emailController.text= cubit.userData!.data!.email!;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: cubit.userData!=null ,
          builder:(context)=>Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (v) {
                        if(v!.isEmpty) {
                          return 'must n\'t be empty';
                        } return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon : const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if(v!.isEmpty) {
                          return 'must n\'t be empty';
                        } return null;
                      },

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email ),
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if(v!.isEmpty) {
                          return 'must n\'t be empty';
                        } return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'phone',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: (){
                            // CacheHelper.removeData(key: 'token').then((value) {
                            //   navigateAndReplace(context, ShopLoginScreen());
                            // });
                          },child: const Text('LOGOUT'),),
                        const SizedBox(width: 20,),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: (){
                            if (formKey.currentState!.validate()){
                              cubit.UpdateUserData(
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  name: nameController.text
                              );
                            }

                          }
                          ,child: const Text('Update'),),
                      ],
                    ),



                  ],
                ),
              ),
            ),
          ) ,
          fallback: (context)=> const Center(child: const CircularProgressIndicator()) ,

        );
      }
    );
  }
}

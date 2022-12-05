import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register_screen.dart';

import 'package:shop_app/modules/shop_layout/files/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_cubit.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'shop_login_states.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel!.status == true) {
            CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token)
                .then((value) {
              token = state.loginModel!.data!.token!;
              showToast(
                  state: ToastStates.SUCCESS,
                  text: '${state.loginModel!.message}');
              navigateAndReplace(context, ShopLayout());
            });
          } else {
            showToast(
                text: '${state.loginModel!.message}',
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLoginCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.seen ? true : false,
                          validator: (index) {
                            if (index!.isEmpty) {
                              return 'password must not be empty';
                            } else {
                              return null;
                            }
                          },
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeShopLoginVisibility();
                              },
                              icon: cubit.seen
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }

                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                          TextButton(
                              onPressed: (){
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                            'REGISTER NOW',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 15),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

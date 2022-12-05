import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register_cubit.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/modules/shop_layout/files/shop_layout.dart';
import 'package:shop_app/shared/network/cashe_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel!.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                showToast(
                    state: ToastStates.SUCCESS,
                    text: '${state.loginModel!.message}');
                navigateAndReplace(context, ShopLayout());
              });
            } else {
              showToast(
                  text: '${state.loginModel!.message}', state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 40),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (index) {
                              if (index!.isEmpty) {
                                return 'name field must not be empty';
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            )),
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

                            validator: (index) {
                              if (index!.isEmpty) {
                                return 'password must not be empty';
                              } else {
                                return null;
                              }
                            },
                            controller: passController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (index) {
                              if (index!.isEmpty) {
                                return 'please enter your phone number';
                              } else {
                                return null;
                              }
                            },
                            controller: phoneController,
                            decoration:const InputDecoration(
                              labelText: 'Phone number',
                              prefixIcon:  Icon(Icons.phone),
                              border:  OutlineInputBorder(),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition:state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      email: emailController.text,
                                      password: passController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/providers/image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../providers/login_provider.dart';




class AuthScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
            builder: (context, ref, child) {
              final isLogin = ref.watch(loginProvider);
              final isLoad = ref.watch(loadingProvider);
              return Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView(
                    children: [
                      Text(isLogin ? 'Login Form ' : 'SignUp Form', style: TextStyle(fontSize: 17, color: Colors.blueGrey, letterSpacing: 2),),
                     SizedBox(height: 70,),
             if(isLogin == false)    TextFormField(
               validator: (val){
                  if(val!.isEmpty){
                    return 'please provide username';
                  }else if(val.length > 15){
                    return 'maximum character 15';
                  }
                  return null;
               },
               controller: nameController,
                       decoration: InputDecoration(
                          hintText: 'username',
                         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         border: OutlineInputBorder()
                       ),
                     ),
                      SizedBox(height: 30,),
                      TextFormField(
                        validator: (val){
                          if(val!.isEmpty || !val.contains('@')){
                            return 'please provide email';
                          }
                          return null;
                        },
                        controller: mailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'email',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: passwordController,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'please provide password';
                          }else if(val.length > 15){
                            return 'maximum character 15';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'password',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()
                        ),
                      ),
                       SizedBox(height: 30,),

                      Container(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () async{
                              _form.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if(_form.currentState!.validate()){
                                if(isLogin){
                                  ref.read(loadingProvider.notifier).toggle();
                                  final response = await ref.read(userProvider.notifier).userSignIn(
                                      email: mailController.text.trim(),
                                      password: passwordController.text.trim(),
                                  );
                                  if(response != 'success'){
                                    ref.read(loadingProvider.notifier).toggle();
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      duration: Duration(milliseconds: 1500),
                                      content: Text(response),
                                    ));
                                  }
                                }else{
                                    ref.read(loadingProvider.notifier).toggle();
                                    final response = await ref.read(userProvider.notifier).userSignUp(
                                      fullName: nameController.text.trim(),
                                        email: mailController.text.trim(),
                                        password: passwordController.text.trim(),
                                    );
                                    if(response != 'success'){
                                      ref.read(loadingProvider.notifier).toggle();
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        duration: Duration(milliseconds: 1500),
                                        content: Text(response),
                                      ));
                                    }

                                  }

                                }

                            }, child: isLoad ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Loading....'),
                            SizedBox(width: 15,),
                            CircularProgressIndicator(
                              color: Colors.white,
                            )
                          ],

                        ) : Text('Submit')
                        ),
                      ),


                      Row(
                        children: [
                          Text(isLogin ? 'Don\'t have an account' : 'Already have an account'),
                          TextButton(onPressed: (){
                            ref.read(loginProvider.notifier).toggle();
                          }, child: Text(isLogin ? 'SignUp' : 'Login') )
                        ],
                      )

                    ],
                  ),
                ),
              );
            }
          ),
    );
  }
}

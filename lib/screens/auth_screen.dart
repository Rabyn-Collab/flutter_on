import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                    if(isLogin) SizedBox(height: 30,),

                  if(isLogin == false)  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        color: Colors.blueGrey,
                        height: 150,
                        width: 150,
                        child: Center(child: Text('please select an image')),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          _form.currentState!.save();
                          if(_form.currentState!.validate()){
                            print(mailController.text);
                            print(passwordController.text);
                            if(isLogin){

                            }else{

                            }
                          }


                        }, child: Text('Submit')
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
        )
    );
  }
}

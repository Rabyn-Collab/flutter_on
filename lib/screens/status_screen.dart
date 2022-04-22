import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/screens/auth_screen.dart';
import 'package:flutter_new_project/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class StatusScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final userStream = ref.watch(authStream);
          return userStream.when(
                data: (data){
                  if(data == null){
                     return AuthScreen();
                  }else{
                    return HomeScreen();
                  }
                },
                error: (err, stack) =>  Scaffold(body: Center(child: Text('$err',))),
                loading: () => Scaffold(
                  body: Center(child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),),
                )
            );
        }
    );
  }
}

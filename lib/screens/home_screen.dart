import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_provider.dart';




class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Firebase project'),
              actions: [
                TextButton(onPressed: () {
                  ref.read(loadingProvider.notifier).toggle();
             ref.read(authProvider).userSignOut();
                },
                    child: Text(
                      'SignOut', style: TextStyle(color: Colors.white),))
              ],
            ),
            body: Container()
        );
      }
    );
  }
}

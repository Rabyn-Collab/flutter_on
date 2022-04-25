import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/widgets/create_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/login_provider.dart';




class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userData = ref.watch(userStream);
        final postData = ref.watch(postStream);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Firebase project'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.to(() => CreatePage(), transition: Transition.leftToRight);
                    },
                    child: Text(
                      'Add Post', style: TextStyle(color: Colors.white),)
                ),
                TextButton(onPressed: () {
                  ref.read(loadingProvider.notifier).toggle();
             ref.read(authProvider).userSignOut();
                },
                    child: Text(
                      'SignOut', style: TextStyle(color: Colors.white),)
                ),


              ],
            ),
            body:ListView(
              children: [
                Container(
                  height: 140,
                  child: userData.when(
                      data: (data){
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index){
                            final dat = data[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 20, left: 20),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                        backgroundImage: NetworkImage(dat.imageUrl),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(dat.username)
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      error: (err, stack) => Text('$err'),
                      loading: () =>Container()
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: postData.when(
                      data: (data){

                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              final dat = data[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 20, left: 20),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(dat.imageUrl),
                                    ),
                                    SizedBox(height: 7,),
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      error: (err, stack) => Text('$err'),
                      loading: () =>Container()
                  ),
                ),
              ],
            )
        );
      }
    );
  }
}

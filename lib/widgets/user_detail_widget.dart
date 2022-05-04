import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_new_project/fire_chat/chat.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_new_project/providers/chat_provider.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';




class UserDetail extends StatelessWidget {

  final types.User user;
  UserDetail(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.imageUrl!),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.firstName!, style: TextStyle(fontSize: 17),),
                          SizedBox(height: 15,),
                         Text(user.metadata!['email']),
                          SizedBox(height: 15,),
                          Consumer(
                            builder: (context, ref, child) {
                              return ElevatedButton(
                                onPressed: () async {
                                 final room = await ref.read(chatProvider).createRoom(user);
                                 if(room !=null){
                                    Get.to(() => ChatPage(room: room), transition: Transition.leftToRight);
                                 }
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.send_outlined),
                                    SizedBox(width: 10,),
                                    Text('send message')
                                  ],
                                ),);
                            }
                          )
                        ],
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Posts', style: TextStyle(fontSize: 20),)),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final userPostData = ref.watch(postStream);
                    return Expanded(
                      child: Container(
                        child: userPostData.when(
                            data: (data){
                              final userPost =  data.where((element) => element.userId == user.id ).toList();
                              return userPost.isEmpty ? Container(
                                child: Center(child: Text('No Post Created yet')),
                              ): GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent: 200,
                                ),
                                itemCount: userPost.length,
                                itemBuilder: (context, index) {
                                  final post = userPost[index];
                                  return CachedNetworkImage(
                                   imageUrl: post.imageUrl, fit: BoxFit.cover,);
                                },
                              );
                            },
                            error: (err, stack) => Text('$err'),
                            loading: () => Center(child: CircularProgressIndicator(),)
                        ),

                      ),
                    );
                  }
                ),

              ],
            ),
          ),
        )
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/fire_chat/chat.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';




class RecentChat extends  ConsumerWidget {

  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context, ref) {
    final roomData = ref.watch(roomStream);
    return Scaffold(
        body: SafeArea(
          child: roomData.when(
              data: (data){
                if(data.isNotEmpty){
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final room = data[index];
                      final otherUser = room.users.firstWhere(
                            (u) => u.id != userId,
                      );
                      return GestureDetector(
                          onTap: () {
                            Get.to(() =>ChatPage(room: data[index]), transition: Transition.leftToRight);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(otherUser.imageUrl!),
                              ),
                              title: Text(otherUser.firstName!),
                            ),
                          )
                      );
                    },
                  );
                }else{
                  return Center(child: Text('No recent chats yet'));
                }

              },
              error: (err, stack) => Center(child: Text('No recent chats yet')),
              loading: () => Center(child: CircularProgressIndicator(
                color: Colors.purple,
              ),)
          ),
        )
    );
  }
}

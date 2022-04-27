import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/post.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/widgets/drawer_widget.dart';
import 'package:flutter_new_project/widgets/update_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';






class HomeScreen extends StatelessWidget {

late User user;

  final userId = auth.FirebaseAuth.instance.currentUser!.uid;
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
            ),
            drawer: DrawerWidget(),
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
                            user = data.firstWhere((element) => element.userId == userId);
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
                  height: 600,
                  child: postData.when(
                      data: (data){
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              final dat = data[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 20, left: 20),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Container(
                                            width: 250,
                                            height:27,
                                            child: Text(dat.title)),
                                         if(userId == dat.userId) IconButton(
                                             onPressed: (){

                                           Get.defaultDialog(
                                             title: 'Customize Post',
                                             content: Text('edit or remove post'),
                                             actions: [
                                              IconButton(
                                                onPressed: (){
                                               Navigator.of(context).pop();
                                               Get.to(() => UpdatePage(dat), transition: Transition.leftToRight);
                                                },
                                                icon: Icon(Icons.edit),
                                              ),

                                              IconButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop();

                                                  Get.defaultDialog(
                                                      title: 'Are you sure',
                                                      content: Text('you want to remove post'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                         child: Text('No'),
                                                        ),

                                                        TextButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                            ref.read(crudProvider).removePost(postId: dat.id, imageId: dat.imageId);
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ]
                                                  );






                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                             ]
                                           );


                                          }, icon: Icon(Icons.more_horiz_rounded))
                                        ],
                                      ),
                                      Container(
                                          height: 200,
                                          width: double.infinity,
                                          child: CachedNetworkImage(
                                            imageUrl:  dat.imageUrl, fit: BoxFit.cover,)),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(dat.description),
                                        if(userId != dat.userId)  Row(
                                            children: [
                                              IconButton(
                                                onPressed: (){
                                           if(dat.likData.usernames.contains(user.username)){
                                             ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            duration: Duration(milliseconds: 1500),
                                              content: Text('You\'ve already like this post')));
                                           }else{
                                             final newData = Like(
                                                 likes: dat.likData.likes + 1,
                                                 usernames: [...dat.likData.usernames, user.username]
                                             );
                                             ref.read(crudProvider).likePost(postId: dat.id, likeData: newData);
                                           }
                                                },
                                                icon:Icon(Icons.thumb_up_alt_rounded)
                                              ),
                                             if(dat.likData.likes != 0) Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Text('${dat.likData.likes}'),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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

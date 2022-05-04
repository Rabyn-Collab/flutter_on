import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/post.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_new_project/notification_service.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/screens/detail_screen.dart';
import 'package:flutter_new_project/screens/recent_chats.dart';
import 'package:flutter_new_project/widgets/drawer_widget.dart';
import 'package:flutter_new_project/widgets/update_page.dart';
import 'package:flutter_new_project/widgets/user_detail_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';





class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



late types.User user;

  final userId = auth.FirebaseAuth.instance.currentUser!.uid;

@override
void initState() {
  super.initState();

  // 1. This method call when app in terminated state and you get a notification
  // when you click on notification app open from terminated state and you can get notification data in this method

  FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );

  // 2. This method only call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
        (message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);

      }
    },
  );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data22 ${message.data['_id']}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );
  getToken();
}
Future getToken() async{
  final token = await FirebaseMessaging.instance.getToken();
  print(token);
}
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
                    onPressed: (){
                   Get.to(() => RecentChat(), transition: Transition.leftToRight);
                }, child: Text('Recent Chats', style: TextStyle(color: Colors.white),)),
              ],
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
                            print(data);
                            user = data.firstWhere((element) => element.id == userId, orElse: (){
                              return types.User(
                                id: ''
                              );
                            });
                            print(user);
                            final dat = data[index];
                           return dat.id == userId ? Container(): Padding(
                                padding: const EdgeInsets.only(top: 20, left: 20),
                                child: InkWell(
                                  onTap: (){
                                    Get.to(() => UserDetail(dat), transition: Transition.leftToRight);
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                          backgroundImage: NetworkImage(dat.imageUrl!),
                                      ),
                                      SizedBox(height: 7,),
                                      Text(dat.firstName!)
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
                                      InkWell(
                                        onTap: (){
                                          Get.to(() => DetailScreen(dat), transition: Transition.leftToRight);
                                        },
                                        child: Container(
                                            height: 200,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl:  dat.imageUrl, fit: BoxFit.cover,)
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(dat.description),
                                        if(userId != dat.userId)  Row(
                                            children: [
                                              IconButton(
                                                onPressed: (){
                                           if(dat.likData.usernames.contains(user.firstName!)){
                                             ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            duration: Duration(milliseconds: 1500),
                                              content: Text('You\'ve already like this post')));
                                           }else{
                                             final newData = Like(
                                                 likes: dat.likData.likes + 1,
                                                 usernames: [...dat.likData.usernames, user.firstName!]
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

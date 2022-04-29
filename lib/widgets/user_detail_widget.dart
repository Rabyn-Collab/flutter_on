import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class UserDetail extends StatelessWidget {

  final User user;
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
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.username, style: TextStyle(fontSize: 17),),
                          SizedBox(height: 15,),
                          Text(user.email),
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
                              final userPost =  data.where((element) => element.userId == user.userId ).toList();
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';



class DetailScreen extends StatelessWidget {
  final Post post;
  final User user;

  DetailScreen(this.user, this.post);

  final commentController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            return Form(
              key: _form,
              child: ListView(
                children: [
                  Container(
                      height: 250,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: post.imageUrl, fit: BoxFit.cover,)
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.title, style: TextStyle(fontSize: 17),),
                        SizedBox(height: 25,),
                        Text(post.description),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextFormField(
                            validator: (val){
                              if(val!.isEmpty){
                                return 'please provide commnet';
                              }
                              return  null;
                            },
                            controller: commentController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: 'add comment',
                                border: OutlineInputBorder()
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              onPressed: () {
                               _form.currentState!.save();
                               FocusScope.of(context).unfocus();
                               if(_form.currentState!.validate()){
                                 final comment = Comments(
                                     comment: commentController.text.trim(),
                                     imageUrl: user.imageUrl,
                                     username: user.username
                                 );
                                 post.comments.add(comment);
                                 ref.read(crudProvider).addComment(
                                     postId: post.id,
                                     comments: post.comments
                                 );

                               }
                               commentController.clear();
                              }, child: Text('submit')),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: post.comments.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child:ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(e.imageUrl),
                            ),
                            title: Text(e.username),
                            subtitle: Text(e.comment),
                          ),
                        );
                      }).toList(),
                    ),
                  )

                ],
              ),
            );
          }
        )
    );
  }
}

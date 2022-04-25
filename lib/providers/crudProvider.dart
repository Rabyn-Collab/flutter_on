import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_new_project/models/post.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';



final userStream = StreamProvider((ref) => CrudProvider().getUser());
final postStream = StreamProvider((ref) => CrudProvider().getPosts());
final crudProvider = Provider((ref) => CrudProvider());

class CrudProvider{


  CollectionReference dbUser = FirebaseFirestore.instance.collection('users');
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');


  Stream<List<User>> getUser(){
    return dbUser.snapshots().map((event) =>_getQuery(event));
  }

  List<User> _getQuery(QuerySnapshot snapshot){
     return snapshot.docs.map((e) => User.fromJson(e.data() as Map<String, dynamic>)).toList();
  }


  Future<String> addPost({required String title, required String detail,
    required XFile file,required String userId}) async{
    try{
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('userPosts/$imageId');
      final convertFile = File(file.path);
      await ref.putFile(convertFile);
      final url = await ref.getDownloadURL();
      await dbPost.add({
        'title': title,
        'imageUrl': url,
        'description': detail,
        'userId': userId,
        'imageId': imageId,
        'likes': {
          'like': 0,
          'usernames': []
        },
        'comments': []
      });

       return 'success';

    }on FirebaseException catch (err){
       return '${err.message}';
    }

  }



  Stream<List<Post>> getPosts(){
    return dbPost.snapshots().map((event) =>_getPostData(event));
  }

  List<Post> _getPostData(QuerySnapshot snapshot){
    return snapshot.docs.map((e) {
      final dat  = e.data() as Map<String, dynamic>;
      print(dat);
      return Post(
          imageUrl: dat['imageUrl'],
          title: dat['title'],
         comments: (dat['comments'] as List).map((e) => Comments.fromJson(e)).toList(),
          description: dat['description'],
          id: e.id,
          imageId: dat['imageId'],
          likData: Like.fromJson(dat['likes']),
          userId: dat['userId']
      );
    }).toList();
  }



}
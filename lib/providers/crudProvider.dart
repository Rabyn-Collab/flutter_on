import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_new_project/models/post.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';



final userStream = StreamProvider((ref) => CrudProvider().getUser());
final postStream = StreamProvider.autoDispose((ref) => CrudProvider().getPosts());
final crudProvider = Provider((ref) => CrudProvider());
final  singleUserStream = StreamProvider.autoDispose((ref) => CrudProvider().getSingleUser());
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


  Stream<User> getSingleUser(){
    final uid = auth.FirebaseAuth.instance.currentUser!.uid;
    final user = dbUser.where('userId', isEqualTo: uid).snapshots();
    return user.map((event) => _getUserQuery(event));
  }

  User _getUserQuery(QuerySnapshot snapshot){
    final user = snapshot.docs[0].data() as Map<String, dynamic>;
    return  User.fromJson(user);
  }



  Future<void> likePost({required String postId, required Like likeData}) async{
       try{
         await dbPost.doc(postId).update({
           'likes': likeData.toJson()
         });

       }on FirebaseException catch (err){
         print(err);
       }
  }

  Future<void> addComment({required String postId, required List<Comments> comments}) async{
    try{
      await dbPost.doc(postId).update({
        'comments': comments.map((e) => e.toJson()).toList()
      });
    }on FirebaseException catch (err){
      print(err);
    }
  }



  Future<String> updatePost({required String title, required String detail,
     XFile? file,required String postId, String? imageId}) async{
    try{
      if(file == null){
        await dbPost.doc(postId).update({
          'title': title,
          'description': detail,
        });

      }else{
        final ref = FirebaseStorage.instance.ref().child('userPosts/$imageId');
        await ref.delete();
        final imageId1 = DateTime.now().toString();
        final ref1 = FirebaseStorage.instance.ref().child('userPosts/$imageId1');
        final convertFile = File(file.path);
        await ref1.putFile(convertFile);
        final url = await ref1.getDownloadURL();
        await dbPost.doc(postId).update({
          'title': title,
          'imageUrl': url,
          'description': detail,
          'imageId': imageId1,
        });

      }
      return 'success';

    }on FirebaseException catch (err){
      return '${err.message}';
    }

  }



  Future<String> removePost({required String postId, required String imageId}) async{
    try{
        final ref = FirebaseStorage.instance.ref().child('userPosts/$imageId');
        await ref.delete();
        await dbPost.doc(postId).delete();
      return 'success';

    }on FirebaseException catch (err){
      return '${err.message}';
    }

  }








}
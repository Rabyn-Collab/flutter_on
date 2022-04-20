import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider{
  CollectionReference  dbUser = FirebaseFirestore.instance.collection('users');

   Future<String> userSignUp({required String username, required String email,
    required String password, required File file}) async{
    try{
     final imageId = DateTime.now().toString();
     final ref = FirebaseStorage.instance.ref().child('userImages/$imageId');
     await ref.putFile(file);
     final url = await ref.getDownloadURL();
   final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
         await dbUser.add({
           'username': username,
           'imageUrl': url,
           'userId': response.user!.uid,
           'email': email
         });
   return 'success';
    }on FirebaseAuthException catch(err){
       return '${err}';

    }

  }



  Future<String> userSignIn({required String email,
    required String password}) async{
    try{
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    }on FirebaseAuthException catch(err){
      return '${err}';
    }

  }


  Future<String> userSignOut() async{
    try{
      final response = await FirebaseAuth.instance.signOut();
      return 'success';
    }on FirebaseAuthException catch(err){
      return '${err}';
    }

  }



}
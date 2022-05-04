import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

final authStream = StreamProvider.autoDispose((ref) => FirebaseAuth.instance.authStateChanges());

final authProvider = Provider.autoDispose((ref) => AuthProvider());


class AuthProvider{


   Future<String> userSignUp({required String firstName, required String lastName, required String email,
    required String password, required XFile file}) async{
    try{
     final imageId = DateTime.now().toString();
     final ref = FirebaseStorage.instance.ref().child('userImages/$imageId');
     final convertFile = File(file.path);
     await ref.putFile(convertFile);
     final url = await ref.getDownloadURL();
   final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
     await FirebaseChatCore.instance.createUserInFirestore(
       types.User(
         firstName: firstName,
         id: response.user!.uid,
         imageUrl: url,
         lastName: lastName,
          metadata: {
           'email': email
          },
          createdAt: DateTime.now().millisecondsSinceEpoch,
       ),
     );
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
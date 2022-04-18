


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider{


  static Future<String> userSignUp({required String username, required String email,
    required String password, required File file}) async{
    try{
     final imageId = DateTime.now().toString();
     final ref = FirebaseStorage.instance.ref().child('userImages/$imageId');
     await ref.putFile(file);
     final url = await ref.getDownloadURL();


    }on FirebaseAuthException catch(err){
       return '${err}';

    }

  }



}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';


final chatProvider =  Provider((ref) => ChatProvider());

class ChatProvider{


  Future<types.Room?> createRoom(types.User otherUser) async{
    try{

      final room = await FirebaseChatCore.instance.createRoom(otherUser);
      return room;

    }on FirebaseException catch (err){
          return null;
    }


  }


}
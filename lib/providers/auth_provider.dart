import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/main.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


final userProvider = StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider(ref: ref));

class UserProvider extends StateNotifier<List<User>>{

  UserProvider({required this.ref}) : super(ref.read(boxA));
  StateNotifierProviderRef ref;



  Future<String> userSignUp({required String email, required String password, required String fullName}) async{
      final dio = Dio();
      try{

        final response = await dio.post(Api.userSignUp, data: {
          'email': email,
          'password' : password,
          'full_name': fullName
        });
        final newsUser = User.fromJson(response.data);
        Hive.box<User>('user').add(newsUser);
         state = [newsUser];
        return 'success';
      }on DioError catch (err){
        return '${err.message}';
      }
  }


  Future<String> userSignIn({required String email, required String password}) async{
    final dio = Dio();
    try{
      final response = await dio.post(Api.userLogin, data: {
        'email': email,
        'password' : password,
      });
      final newsUser = User.fromJson(response.data);
      Hive.box<User>('user').add(newsUser);
      state = [newsUser];
      return 'success';
    }on DioError catch (err){
      return '${err.message}';
    }
  }


  void clearBox(){
    Hive.box<User>('user').clear();
    state = [];
  }



}
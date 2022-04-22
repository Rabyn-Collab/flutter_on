import 'package:flutter_riverpod/flutter_riverpod.dart';



final loginProvider = StateNotifierProvider<LoginProvider, bool>((ref) => LoginProvider());

class LoginProvider extends StateNotifier<bool>{
  LoginProvider() : super(true);

   void toggle(){
     state = !state;
   }


}


final loadingProvider = StateNotifierProvider<LoadingProvider, bool>((ref) => LoadingProvider());

class LoadingProvider extends StateNotifier<bool>{
  LoadingProvider() : super(false);

  void toggle(){
    state = !state;
  }

}


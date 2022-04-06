import 'package:flutter_riverpod/flutter_riverpod.dart';


final progressProvider = StateNotifierProvider<ProgressProvider, double>((ref) => ProgressProvider());

class ProgressProvider extends StateNotifier<double>{
  ProgressProvider() : super(0.0);

  void changeProgress(double val){
     state = val;
  }

}
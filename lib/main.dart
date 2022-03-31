import 'package:flutter/material.dart';
import 'package:flutter_new_project/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



void main () async {

 runApp(ProviderScope(child: Home()));

}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Counter(),
    );
  }
}


class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            print(count.count);
            print(count.status);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${count.count}', style: TextStyle(fontSize: 50),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  TextButton(
                      onPressed: (){
                        ref.read(counterProvider.notifier).increment();
                      }, child: Text('add')),
                  TextButton(
                      onPressed: (){
                      }, child: Text('minus')),
                  ],
                ),
              ],
            );
          }
      ),
    );
  }
}


class Count{
  int count;
  bool status;

  Count({required this.count, required this.status});
  Count.intiState(): status= false,count=0;


  Count copyWith({int? count, bool? status}){
    return Count(
        count: count ?? this.count,
        status: status ?? this.status
    );
  }
}

final counterProvider = StateNotifierProvider<CounterProvider, Count>((ref) =>CounterProvider());

class CounterProvider extends StateNotifier<Count>{
  CounterProvider() : super(Count.intiState()){
    increment();
  }



  void increment(){
    state = state.copyWith(
      count: state.count + 1,
      status: true
    );
  }



}



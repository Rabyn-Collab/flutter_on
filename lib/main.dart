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
      home: HomeScreen(),
    );
  }
}


class Counter extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    print('re-build');
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final number = ref.watch(countProvider).number;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$number', style: TextStyle(fontSize: 45),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                        ref.read(countProvider).increment();
                        }, child: Text('increment')),
                    TextButton(
                        onPressed: () {
                          ref.read(countProvider).decrement();
                        }, child: Text('decrement')),
                  ],
                )
              ],
            );
          }
        ),
      ),
    );
  }
}



final countProvider = ChangeNotifierProvider((ref) => CountProvider());

class  CountProvider extends  ChangeNotifier{

  int number = 0;


  void increment(){
     number++;
     notifyListeners();
  }

  void decrement(){
    number--;
    notifyListeners();
  }

}
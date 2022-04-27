import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/screens/status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


void main () async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 runApp(ProviderScope(child: Home()));

}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     home: StatusScreen(),
    );
  }
}

//
// class CounterApp extends StatelessWidget {
//
//   int number = 0;
//
//   final numberController = StreamController<int>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final broadCast = numberController.stream.asBroadcastStream();
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           StreamBuilder<int>(
//             stream: broadCast,
//             builder: (context, snapshot) {
//               print(snapshot.data);
//               if(snapshot.hasData){
//                 return Center(child: Text('${snapshot.data}',style: TextStyle(fontSize: 25)));
//               }
//               return Center(child: Text('0', style: TextStyle(fontSize: 25),));
//             }
//           ),
//
//           StreamBuilder<int>(
//               stream: broadCast,
//               builder: (context, snapshot) {
//                 print(snapshot.data);
//                 if(snapshot.hasData){
//                   return Center(child: Text('${snapshot.data}',style: TextStyle(fontSize: 25)));
//                 }
//                 return Center(child: Text('0', style: TextStyle(fontSize: 25),));
//               }
//           ),
//
//         ],
//
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: (){
//            numberController.sink.add(number++);
//           },
//        child:Icon(Icons.add),
//       ),
//     );
//   }
// }

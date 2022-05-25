import 'package:flutter/material.dart';
import 'package:flutter_new_project/location/location_check.dart';
import 'package:flutter_new_project/models/cart_item.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_new_project/screens/status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


final boxA = Provider<List<User>>((ref) => []);
final boxB = Provider<List<CartItem>>((ref) => []);

void main () async {
 WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
  final userBox = await Hive.openBox<User>('user');
  final cartBox = await Hive.openBox<CartItem>('carts');
 runApp(ProviderScope(
     overrides: [
       boxA.overrideWithValue(userBox.values.toList().cast<User>()),
       boxB.overrideWithValue(cartBox.values.toList().cast<CartItem>())
     ],
     child: Home()));

}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
         //home: StatusScreen(),
      home: LocationCheck(),
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






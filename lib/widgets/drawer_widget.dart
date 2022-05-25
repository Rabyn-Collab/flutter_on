import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/providers/login_provider.dart';
import 'package:flutter_new_project/providers/order_provider.dart';
import 'package:flutter_new_project/screens/customize_product.dart';
import 'package:flutter_new_project/screens/order_screen.dart';
import 'package:flutter_new_project/widgets/create_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(userProvider)[0];
                    return ListView(
                      children: [
                       DrawerHeader(
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             colorFilter: ColorFilter.mode(
                                 Colors.black12,
                                 BlendMode.darken),
                             image: NetworkImage('https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aW1hZ2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                             fit: BoxFit.cover
                           )
                         ),
                         child: Text(data.username, style: TextStyle(fontSize: 17, color: Colors.white),),
                       ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text(data.email),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            Get.to(() => CreatePage(), transition: Transition.leftToRight);
                          },
                          leading: Icon(Icons.add),
                          title: Text('Add Product'),
                        ),

                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            Get.to(() => CustomScreen(), transition: Transition.leftToRight);
                          },
                          leading: Icon(Icons.add),
                          title: Text('Customize product'),
                        ),

                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            Get.to(() => OrderHistoryPage(), transition: Transition.leftToRight);
                          },
                          leading: Icon(Icons.ac_unit),
                          title: Text('order history'),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            ref.read(loadingProvider.notifier).toggle();
                            ref.read(userProvider.notifier).clearBox();
                          },
                          leading: Icon(Icons.exit_to_app),
                          title: Text('SignOut'),
                        ),
                      ],
                    );
                  },
              )
       );
            }

}

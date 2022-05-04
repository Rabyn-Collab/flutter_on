import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/providers/login_provider.dart';
import 'package:flutter_new_project/widgets/create_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Consumer(
            builder: (context, ref, child) {
              final userData = ref.watch(singleUserStream);
              return userData.when(
                  data: (data){
                    return ListView(
                      children: [
                       DrawerHeader(
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             colorFilter: ColorFilter.mode(
                                 Colors.black12,
                                 BlendMode.darken),
                             image: NetworkImage(data.imageUrl!),
                             fit: BoxFit.cover
                           )
                         ),
                         child: Text(data.firstName!, style: TextStyle(fontSize: 17, color: Colors.white),),
                       ),
                        // ListTile(
                        //   leading: Icon(Icons.email),
                        //   title: Text(data.email),
                        // ),
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            Get.to(() => CreatePage(), transition: Transition.leftToRight);
                          },
                          leading: Icon(Icons.add),
                          title: Text('Create Post'),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pop();
                            ref.read(loadingProvider.notifier).toggle();
                            ref.read(authProvider).userSignOut();
                          },
                          leading: Icon(Icons.exit_to_app),
                          title: Text('SignOut'),
                        ),
                      ],
                    );
                  },
                  error: (err, stack) => Text('$err'),
                  loading: () => Container()
              );
            }
        )
    );
  }
}

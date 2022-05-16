import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/auth_provider.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/providers/login_provider.dart';
import 'package:flutter_new_project/widgets/create_page.dart';
import 'package:flutter_new_project/widgets/drawer_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';





class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productData = ref.watch(dataProvider);
        return Scaffold(
          drawer: DrawerWidget(),
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Sample Shop'),
              
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: productData.when(
                  data: (data){
                    return GridView.builder(
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                         childAspectRatio: 2/3

                        ),
                        itemBuilder: (context, index){
                          return GridTile(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(data[index].image, fit: BoxFit.cover,)) ,
                            footer: Container(
                              height: 30,
                              color: Colors.black38,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                               Text(data[index].product_name, style: TextStyle(color: Colors.white),),
                               Text('Rs. ${data[index].price}', style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator())
              ),
            )
        );
      }
    );
  }
}

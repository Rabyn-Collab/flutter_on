import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/widgets/update_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';




class CustomScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
            builder: (context, ref, child) {
              final productData = ref.watch(dataProvider);
              return productData.when(
                  data: (data){
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            leading: Image.network(data[index].image),
                            title: Text(data[index].product_name),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        Get.to(() => UpdatePage(data[index]));
                                      }, icon: Icon(Icons.edit)
                                  ),
                                  IconButton(
                                      onPressed: (){
                                       Get.defaultDialog(
                                         title: 'are you sure',
                                         content: Text('you want to remove this product'),
                                         actions: [
                                           TextButton(
                                               onPressed: (){
                                                 Navigator.of(context).pop();
                                               }, child: Text('No')),
                                           TextButton(
                                               onPressed: () async{
                                                 Navigator.of(context).pop();
                                               await  ref.read(crudProvider).removeProduct(
                                                   id: data[index].id,
                                                   imageId: data[index].public_id
                                               );
                                               ref.refresh(dataProvider);
                                               }, child: Text('Yes')),
                                         ]
                                       );
                                      }, icon: Icon(Icons.delete)
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err'),),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  )
              );
            }
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/cart_provider.dart';
import 'package:flutter_new_project/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';





class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final cartData = ref.watch(cartProvider);
              final total = ref.watch(cartProvider.notifier).total;
              return cartData.isEmpty ? Center(child: Text('please add some product')) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: cartData.map((e) {
                          print(cartData.length);
                          return Container(
                            height: 200,
                              child: Row(
                                children: [
                                  Image.network(e.imageUrl, height: 200, width: 150, fit: BoxFit.cover,),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.title),
                                      Container(
                                        width: 200,
                                        child: Row(
                                          children: [
                                            Text('Rs. ${e.price}'),
                                            Spacer(),
                                            Text('${e.quantity} x')
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                              onPressed: (){
                                                ref.read(cartProvider.notifier).addSingleProduct(e);
                                              },
                                              child: Icon(Icons.add)),
                                          SizedBox(width: 20,),
                                          OutlinedButton(
                                              onPressed: (){
                                                ref.read(cartProvider.notifier).removeSingleProduct(e);
                                              }, child: Icon(Icons.remove)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ));
                        }).toList(),
                      ),
                    ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text('Total', style: TextStyle(fontSize: 20),),
                            Spacer(),
                            Text('$total', style: TextStyle(fontSize: 17),)
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              primary: Colors.black,
                              minimumSize: Size(375, 50)
                          ),
                          onPressed: ()  async{
                            final response = await ref.read(orderProvider).orderCreate(total: total, carts: cartData);
                            if(response == 'success'){
                                ref.read(cartProvider.notifier).clearBox();
                            }

                          }, child: Text('Check Out'),),
                    ],
                  ),
                  ],
                ),
              );
            }
    )
    );
  }
}

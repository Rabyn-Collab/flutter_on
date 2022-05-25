import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class OrderHistoryPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final orderData = ref.watch(historyProvider);
                return orderData.isEmpty ? Center(child: CircularProgressIndicator()):
                Container(
                  child: ListView.builder(
                      itemCount: orderData.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date:-' + ' ' + orderData[index].dateTime.substring(0, 10)),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: orderData[index].products.map((e) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Container(
                                                height: 100,
                                                child: Image.network(e.imageUrl, fit: BoxFit.cover,)
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(e.title),
                                              SizedBox(height: 15,),
                                              Text('Rs. ${e.price} * ${e.quantity}')
                                            ],
                                          )

                                        ],
                                      );
                                    }).toList(),
                                  ),

                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('Total:- ${orderData[index].total}'))
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                );
              }
    ),
        )
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/cart_item.dart';
import 'package:flutter_new_project/models/order.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


final historyProvider = StateNotifierProvider<OrderHistory, List<Order>>((ref) => OrderHistory([]));
class OrderHistory extends StateNotifier<List<Order>>{
  OrderHistory(super.state){
    orderHistory();
  }

  Future<void> orderHistory() async {
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try {
      final response = await dio.get(Api.getOrderHistory,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
          }));
      print(response.data);
      final data = (response.data as List).map((e) => Order.fromJson(e)).toList();
      state = data;
    } on DioError catch (err) {
      state = [];
     print(err.message);
    }
  }

}
final orderProvider = Provider((ref) => OrderProvider());

class OrderProvider {


  Future<String> orderCreate({required int total, required List<CartItem> carts}) async {
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try {
      final response = await dio.post(Api.orderCreate,
          data: {
            'amount': total,
            'dateTime': DateTime.now().toIso8601String(),
            'products': carts.map((e) => e.toJson()).toList()
          },
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
          }));
      return 'success';
    } on DioError catch (err) {
      return '${err.message}';
    }
  }



}
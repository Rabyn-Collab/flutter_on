import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final cartData = ref.watch(cartProvider);
              return cartData.isEmpty ? Center(child: Text('please add some product')) : Container();
            }
    )
    );
  }
}

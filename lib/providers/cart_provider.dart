import 'package:flutter_new_project/main.dart';
import 'package:flutter_new_project/models/cart_item.dart';
import 'package:flutter_new_project/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


final  cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref: ref));

class CartProvider extends StateNotifier<List<CartItem>>{

  CartProvider({required this.ref}) : super(ref.read(boxB));
  StateNotifierProviderRef ref;


 String addProduct(Product product){
     if(state.isEmpty){
       final newCart = CartItem(
         price: product.price,
           imageUrl: product.image,
           title: product.product_name,
           id: product.id,
           quantity: 1,
           total: product.price
       );

       Hive.box<CartItem>('carts').add(newCart);
       state = [newCart];
       return 'success';
     }else{
       final item = state.firstWhere((element) => element.id == product.id, orElse: () => CartItem(
         price: 0,
           imageUrl: '', title: 'no-data', id: '', quantity: 0, total: 0));
       if(item.title == 'no-data'){
         final newCart = CartItem(
           price: product.price,
             imageUrl: product.image,
             title: product.product_name,
             id: product.id,
             quantity: 1,
             total: product.price
         );

         Hive.box<CartItem>('carts').add(newCart);
         state = [...state, newCart];
         return 'success';
       }
       return 'already add to cart';


     }
 }


 void addSingleProduct(CartItem cartItem){
   cartItem.quantity  = cartItem.quantity + 1;
  cartItem.total = cartItem.price * (cartItem.quantity + 1);
   cartItem.save();

   state = [
     for(final element in state)
       if(element == cartItem) cartItem else element
   ];

 }


  void removeSingleProduct(CartItem cartItem){
   if(cartItem.quantity > 1){
     cartItem.quantity  = cartItem.quantity - 1;
     cartItem.total = cartItem.price * (cartItem.quantity - 1);
     cartItem.save();

     state = [
       for(final element in state)
         if(element == cartItem) cartItem else element
     ];
   }

  }

  int get total{
   int total = 0;
    state.forEach((element) {
      total += element.quantity * element.price;
    });
   return total;

  }

  void clearBox(){
    Hive.box<CartItem>('carts').clear();
    state = [];
  }



}
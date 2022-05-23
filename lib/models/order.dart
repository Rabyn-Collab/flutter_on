import 'cart_item.dart';




class Order{

  final int total;
  final String dateTime;
  final List<CartItem> products;

  Order({
    required this.total,
    required this.dateTime,
    required this.products
});

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
        total: json['total'],
        dateTime: json['dateTime'],
        products: json['products']);
  }


}
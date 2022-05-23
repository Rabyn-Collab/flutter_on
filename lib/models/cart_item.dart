import 'package:hive/hive.dart';
part 'cart_item.g.dart';



@HiveType(typeId: 1)
class CartItem extends HiveObject{

  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late int quantity;

  @HiveField(3)
  late String imageUrl;

  @HiveField(4)
  late int total;

  @HiveField(5)
  late int price;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.quantity,
    required this.total,
    required this.price
  });


  factory CartItem.fromJson(Map<String, dynamic> json){
    return CartItem(
       id: json['id'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
      title: json['title'],
      total: json['total'],
      price: json['price']
    );
  }



  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'imageUrl': this.imageUrl,
      'quantity': this.quantity,
      'title': this.title,
      'total': this.total,
      'price': this.price
    };
  }

}
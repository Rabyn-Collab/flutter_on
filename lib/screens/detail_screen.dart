import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/product.dart';



class DetailScreen extends StatelessWidget {
  final Product product;
  DetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 270),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight:  Radius.circular(40),
                  ),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100,),
                        Text(product.product_detail),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                               ),
                              primary: Colors.black,
                              minimumSize: Size(375, 50)
                            ),
                            onPressed: (){}, child: Text('Add To cart')),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(product.product_name, style: TextStyle(fontSize: 20, color: Colors.white),),
                          SizedBox(height: 190,),
                          Text('Rs. ${product.price}', style: TextStyle(fontSize: 16, color: Colors.white),),
                        ],
                      ),
                    ),
                    Container(
                        height: 250,
                        width: 250,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Hero(
                                tag: product.id,
                                child: Image.network(product.image, fit: BoxFit.cover,)))),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

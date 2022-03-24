import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/book.dart';


class DetailScreen extends StatelessWidget {

  final Book book;
  DetailScreen(this.book);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Hero(
                tag: book.imageUrl,
                child: Image.network(book.imageUrl, height: 400, width: double.infinity, fit: BoxFit.cover,)),

           Container(
             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(book.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                     Column(
                       children: [
                         Text(book.ratingStar),
                         SizedBox(height: 5,),
                         Text(book.bookGenre, style: TextStyle(color: Colors.blue),),
                       ],
                     )
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 17),
                   child: Text(book.summary, style: TextStyle(fontSize: 16, color: Colors.black45, wordSpacing: 2),),
                 ),
                 SizedBox(height: 55,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         primary: Color(0xFF007084),
                         minimumSize: Size(150, 57),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12),
                         )
                       ),
                         onPressed: (){

                         }, child: Text('Read Book')),
                     OutlinedButton(
                       style: OutlinedButton.styleFrom(
                           minimumSize: Size(150, 57),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                           )
                       ),
                       onPressed: (){

                       }, child: Text('More info'),)
                   ],
                 )
               ],
             ),
           ),

          ],
        )
    );
  }
}

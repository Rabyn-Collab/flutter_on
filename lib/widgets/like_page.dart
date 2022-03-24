import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/book.dart';



class LikePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 350,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bookData.length,
          itemBuilder: (context, index) {
            final book = bookData[index];
            return Container(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(book.imageUrl, width: 125,
                      height: 250,
                      fit: BoxFit.cover,),
                  ),
                  Text(book.title),
                  Text(book.bookGenre, style: TextStyle(color: Colors.blue),)
                ],
              ),
            );
          }
      ),
    );
  }
}

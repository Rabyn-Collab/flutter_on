import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/book.dart';
import 'package:flutter_new_project/providers/counter_provider.dart';
import 'package:flutter_new_project/screens/detail_screen.dart';
import 'package:flutter_new_project/widgets/like_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';





class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Color(0xFFF2F5F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F5F9),
       title: Text('Hi John, ', style: TextStyle(color: Colors.black, fontSize: 22,),),
        actions: [
          Icon(Icons.search, color: Colors.black, size: 30,),
          SizedBox(width: 15,),
          Icon(Icons.notifications, color: Colors.black, size: 30,),
          SizedBox(width: 15,),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 27, top: 20, right: 27),
          child: Column(
            children: [
              Container(
                height: 250,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      errorWidget: (context, d, s){
                        return Image.asset('assets/images/no-image.jpg');
                      },
                      placeholder: (context, String){
                        return Center(child: CircularProgressIndicator(),);
                      },
                       imageUrl: 'https://images.unsplash.com/photo-1528208079124-a2387f039c99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Ym9vayUyMHNoZWxmfGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=500&q=60', )),
              ),
             SizedBox(height: 15,),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookData.length,
                    itemBuilder: (context, index) {
                    final book = bookData[index];
                      return InkWell(
                        onTap: (){
                        Get.to(() => DetailScreen(book), transition: Transition.leftToRight);
                        },
                        child: Container(
                          width: 360,
                          margin: EdgeInsets.only(right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                           // textBaseline: TextBaseline.alphabetic,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: book.imageUrl,
                                  child: Image.network(book.imageUrl, width: 125,
                                    height: 250,
                                    fit: BoxFit.cover,),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 200,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(book.title),
                                          Text(book.summary, style: TextStyle(color: Colors.blueGrey),
                                            maxLines: 7,
                                            textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,),
                                          Row(
                                            children: [
                                              Text(book.ratingStar),
                                              Spacer(),
                                              Text(book.bookGenre, style: TextStyle(color: Colors.blue),)
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 17),
                child: Text('You may also like', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              ),
           Consumer(
           builder: (context, ref, child) {
             final   count = ref.watch(counterProvider).number;
             return Column(
               children: [
                 Text('$count', style: TextStyle(fontSize: 25),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                         onPressed: () {
                           ref.read(counterProvider).increment();
                         }, child: Text('add')
                     ),
                     TextButton(
                         onPressed: () {
                           ref.read(counterProvider).decrement();
                     }, child: Text('minimize')),
                   ],)
               ],
             );
           }
           ),

           LikePage()
            ],
          ),
        ),
      ),
    );
  }
}

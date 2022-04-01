import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/news_provider.dart';
import 'package:flutter_new_project/widgets/tab_bar_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomeScreen extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          toolbarHeight: 10,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey),
              tabs: [
            Tab(
            text: 'Game',
            ),
                Tab(
                  text: 'Hollywood',
                ),
          ]),
        ),
          body: Column(
            children: [
              Container(
                height: 260,
                child: TabBarView(
                    children: [
                      TabBarWidget('game'),
                      TabBarWidget('hollywood'),
                ]),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final newsData = ref.watch(searchNewsProvider);
                  return Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: searchController,
                              onFieldSubmitted: (val){
                                ref.read(searchNewsProvider.notifier).search(val);
                                searchController.clear();
                              },
                              decoration: InputDecoration(
                                  hintText: 'Search for news',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder()
                              ),
                            ),
                          SizedBox(height: 15,),
                          newsData.isEmpty ? Center(child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),) : Container(
                            height: 420,
                            child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  itemCount: newsData.length,
                                  itemBuilder: (context, index){
                                    return Card(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10, bottom: 10),
                                        height: 200,
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                                errorWidget: (context, image, url){
                                                  return Image.asset('assets/images/no-image.jpg',
                                                    fit: BoxFit.cover,);
                                                },
                                                height: 200,
                                                width: 170,
                                                fit: BoxFit.cover,
                                                imageUrl:  newsData[index].media
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(newsData[index].title,
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 15,),),
                                                  SizedBox(height: 14,),
                                                  Text(newsData[index].summary,
                                                    maxLines: 7,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),),
                                                  SizedBox(height: 14,),
                                                  Spacer(),
                                                  FittedBox(child: Text(newsData[index].author.length > 50 ? newsData[index].author.substring(0, 40): newsData[index].author))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                          )
                          ],
                        )),
                  );
                }
              )
            ],
          )
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/news_provider.dart';
import 'package:flutter_new_project/widgets/tab_bar_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Consumer(
              builder: (context, ref, child) {
                final newsData = ref.watch(newsProvider);
                return Column(
                  children: [
                    Container(
                      height: 260,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: newsData.when(
                          data: (data){
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index){
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    height: 250,
                                    width: 600,
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                            color: Colors.black54,
                                            colorBlendMode: BlendMode.darken,
                                            errorWidget: (context, image, url){
                                              return Image.asset('assets/images/no-image.jpg',
                                                fit: BoxFit.cover,);
                                            },
                                            height: 250,
                                            width: 200,
                                            fit: BoxFit.cover,
                                            imageUrl:  data[index].media
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(data[index].title,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 17,),),
                                              SizedBox(height: 17,),
                                              Text(data[index].summary,
                                                maxLines: 5,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold),),
                                              Text(data[index].author)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                          error: (err, stack) => Center(child: Text('$err')),
                          loading: () => Center(child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),)
                      ),
                    ),
                  ],
                );
              }
          ),
         toolbarHeight: 220,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.only(top: 20),
              labelStyle: TextStyle(fontSize: 17, color: Colors.blueGrey),
              tabs: [
            Tab(
            text: 'Game',
            ),
                Tab(
                  text: 'Flutter',
                ),
          ]),
        ),
          body: TabBarView(
              children: [
                TabBarWidget('game'),
                TabBarWidget('flutter'),
          ])
      ),
    );
  }
}

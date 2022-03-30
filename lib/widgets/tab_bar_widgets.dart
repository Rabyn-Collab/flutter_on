import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/news_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class TabBarWidget extends StatelessWidget {
  final String query;
  TabBarWidget(this.query);
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final newsData = ref.watch(searchNewsProvider(query));
          return newsData.when(
              data: (data){
                return Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 15),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 250,
                            width: double.infinity,
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                    errorWidget: (context, image, url){
                                      return Image.asset('assets/images/no-image.jpg',
                                        fit: BoxFit.cover,);
                                    },
                                    height: 250,
                                    width: 150,
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
                                      SizedBox(height: 2,),
                                      Container(
                                        height: 100,
                                        child: SingleChildScrollView(
                                          child: Text(data[index].summary,
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: 16),),
                                        ),
                                      ),
                                      Text(data[index].author)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator(
                color: Colors.purple,
              ),)
          );
        }
    );
  }
}

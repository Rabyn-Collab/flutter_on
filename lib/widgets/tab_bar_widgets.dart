import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/news_provider.dart';
import 'package:flutter_new_project/widgets/detail_page.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class TabBarWidget extends StatelessWidget {
  final String query;
  TabBarWidget(this.query);
  // bool isConnect = false;
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        final bool connected = connectivity != ConnectivityResult.none;
          // if(connectivity == ConnectivityResult.none){
          //   isConnect = false;
          // }else{
          //   isConnect = true;
          // }

        return connected ? Consumer(
            builder: (context, ref, child) {
              final newsData = ref.watch(newsProvider(query));
              return Column(
                children: [
                  Container(
                    height: 260,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: newsData.when(
                        data: (data) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DetailPage(data[index]),
                                        transition: Transition.leftToRight);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 250,
                                    width: 300,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              17),
                                          child: CachedNetworkImage(
                                              color: Colors.black54,
                                              colorBlendMode: BlendMode.darken,
                                              errorWidget: (context, image,
                                                  url) {
                                                return Image.asset(
                                                  'assets/images/no-image.jpg',
                                                  fit: BoxFit.cover,);
                                              },
                                              height: 250,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              imageUrl: data[index].media
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 100),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(data[index].title,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 15,
                                                    color: Colors.white),),
                                              SizedBox(height: 17,),
                                              Text(data[index].summary,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),),
                                              SizedBox(height: 15,),
                                              Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    data[index].author,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    overflow: TextOverflow
                                                        .ellipsis,))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () =>
                            Center(child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),)
                    ),
                  ),
                ],
              );
            }
        ) : Container(
          height: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_outlined, size: 70, color: Colors.pink,),
              SizedBox(height: 15,),
              Text('no connection try again')
            ],
          ),
        ) ;
      },
      child: Container(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/movie_provider.dart';
import 'package:flutter_new_project/screens/detail_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class TabBarWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final movieData = ref.watch(movieProvider);
          return OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              return connectivity == ConnectivityResult.none ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(Icons.wifi_off_outlined, size: 150,),
                    Text('No connection try again', style: TextStyle(fontSize: 19),)
                  ],
                ),
              ): movieData.movies.isEmpty ? Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),) : movieData.movies[0].title == 'not available'
                  ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('movie not found try using another query',
                      style: TextStyle(fontSize: 17),),
                    ElevatedButton(onPressed: () {
                      ref.refresh(movieProvider.notifier);
                    }, child: Text('Refresh'))
                  ],
                ),
              )
                  : NotificationListener(
                onNotification: (onNotification) {
                  if (onNotification is ScrollEndNotification) {
                    final before = onNotification.metrics.extentBefore;
                    final max = onNotification.metrics.maxScrollExtent;
                    if (before == max) {
                        ref.read(movieProvider.notifier).loadMore();
                      }

                  }
                  return true;
                },
                child: GridView.builder(
                    itemCount: movieData.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      final movie = movieData.movies[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailScreen(movie),
                              transition: Transition.leftToRight);
                        },
                        child: CachedNetworkImage(
                            errorWidget: (ctx, s, d) {
                              return Image.asset(
                                  'assets/images/no-image.jpg');
                            },
                            imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie
                                .poster_path}'),
                      );
                    }
                ),
              );
            },
            child: Container(),
          );
        }
    );
  }
}

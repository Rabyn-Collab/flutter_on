import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/models/movie.dart';
import 'package:flutter_new_project/providers/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class DetailScreen extends StatelessWidget {
  final Movie movie;

  DetailScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final videoData = ref.watch(videoProvider(movie.id));
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: ListView( 
                children: [
                  Container(
                    height: 350,
                    child: videoData.when(
                        data: (data){
                           return YoutubePlayer(
                             controller: YoutubePlayerController(
                               initialVideoId: data,
                               flags: YoutubePlayerFlags(
                                 autoPlay: false,
                               ),
                             ),
                             showVideoProgressIndicator: true,
                           );
                        }, error: (err, stack) => Container(), loading: () => Container()),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 250,
                                  child: Text(movie.title , style: TextStyle(color: Colors.white, fontSize: 17),)),
                              Text(movie.release_date, style: TextStyle(color: Colors.white, fontSize: 15),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: CachedNetworkImage(
                            errorWidget: (ctx, s, d) {
                              return Image.asset(
                                  'assets/images/no-image.jpg');
                            },
                            imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie
                                .poster_path}', fit: BoxFit.cover,),
                      ),

                      Container(
                        padding: EdgeInsets.all(17),
                        child: Text(movie.overview, style: TextStyle(color: Colors.white, fontSize: 15),),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

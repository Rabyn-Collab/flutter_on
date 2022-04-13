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
            body: SafeArea(
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
          );
        });
  }
}

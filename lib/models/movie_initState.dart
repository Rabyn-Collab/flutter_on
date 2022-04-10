


import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/movie.dart';

class MovieState{
  late String apiPath;
  late int page;
  late List<Movie> movies;
  late String searchText;

  MovieState({required this.apiPath, required this.movies, required this.page, required this.searchText});

  MovieState.init() : searchText ='', page=1, apiPath= Api.getPopularMovie, movies=[];

   MovieState copyWith({String? apiPath, int? page, List<Movie>? movies , String? searchText}){
      return MovieState(
          apiPath: apiPath ?? this.apiPath,
          movies: movies ?? this.movies,
          page: page ?? this.page,
          searchText: searchText ?? this.searchText
      );
   }

}
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/movie.dart';
import 'package:flutter_new_project/models/movie_initState.dart';
import 'package:flutter_new_project/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider({required this.apiPath}) : super(MovieState.init());

  String apiPath;

  Future<void> getMovies() async{
       List<Movie> _movies = [];
    if(state.searchText.isEmpty){
    if(apiPath == Api.getPopularMovie){
       _movies = await MovieService.getMoviesByCategory(apiPath: apiPath, page: state.page);
    }else if(apiPath == Api.getTopRatedMovie){
      _movies = await MovieService.getMoviesByCategory(apiPath: apiPath, page: state.page);
    }else{
      _movies = await MovieService.getMoviesByCategory(apiPath: apiPath, page: state.page);
    }
    }else{
      _movies = await MovieService.getSearchMovie(apiPath: state.apiPath, page: state.page, query: state.searchText);

    }
       state = state.copyWith(
           movies: [...state.movies, ..._movies]
       );

  }


  void searchMovie(String query){
     state = state.copyWith(
     apiPath: Api.searchMovie,
       searchText: query,
       movies: [],
     );
     getMovies();
  }

  void LoadMore(){
    state = state.copyWith(
      searchText: '',
    page:  state.page + 1
    );
    getMovies();
  }


}
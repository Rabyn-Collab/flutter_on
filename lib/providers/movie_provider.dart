import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/movie.dart';
import 'package:flutter_new_project/models/movie_initState.dart';
import 'package:flutter_new_project/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieProvider = StateNotifierProvider<MoviesProvider, MovieState>((ref) => MoviesProvider());

class MoviesProvider extends StateNotifier<MovieState> {
  MoviesProvider() : super(MovieState.init()){
    getMovies();
  }

  Future<void> getMovies() async{
    List<Movie> _movies = [];
    if(state.searchText == ''){
      if(state.apiPath == Api.getPopularMovie){
        _movies = await MovieService.getMoviesByCategory(apiPath: state.apiPath, page: state.page);
      }else if(state.apiPath == Api.getTopRatedMovie){
        _movies = await MovieService.getMoviesByCategory(apiPath: state.apiPath, page: state.page);
      }else{
        _movies = await MovieService.getMoviesByCategory(apiPath: state.apiPath, page: state.page);
      }
    }else{
      _movies = await MovieService.getSearchMovie(apiPath: state.apiPath,page:  state.page,query:  state.searchText);
    }

    state = state.copyWith(
      movies: [...state.movies, ..._movies],
    );

  }

//update category

  void updateApi(String api){
    state = state.copyWith(
        movies: [],
        apiPath: api,
        searchText: ''
    );
    getMovies();
  }


//search_movies


  void searchMovie(String query){
    state = state.copyWith(
        movies: [],
        apiPath: Api.searchMovie,
        searchText: query
    );
    getMovies();
  }




//load_more
  void loadMore(){
    state = state.copyWith(
        searchText: '',
        page:  state.page + 1
    );
    getMovies();
  }


}


final videoProvider = FutureProvider.family((ref, int id) => VideoProvider().getVideo(id));
class VideoProvider {
  Future<String> getVideo(int movieId) async{
    final dio = Dio();
    try{
      final response = await dio.get('https://api.themoviedb.org/3/movie/$movieId/videos', queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8'
      });
      return response.data['results'][0]['key'];
    }on DioError catch (err){
      print(err);
      return '';
    }


  }
}
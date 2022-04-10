import 'package:dio/dio.dart';
import 'package:flutter_new_project/models/movie.dart';

class MovieService {


 static Future<List<Movie>> getMoviesByCategory({required String apiPath, required int page}) async{
    final dio = Dio();
       try{
        final response = await dio.get(apiPath, queryParameters: {
          'api_key': '2a0f926961d00c667e191a21c14461f8',
          'page': page,
          'language': 'en-US'
        });

        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;

      }on DioError catch (err){
        print(err);
         return [];
      }


  }

 static Future<List<Movie>> getSearchMovie({required String apiPath, required int page, required String query}) async{
   final dio = Dio();
   try{
     final response = await dio.get(apiPath, queryParameters: {
       'api_key': '2a0f926961d00c667e191a21c14461f8',
       'page': page,
       'language': 'en-US',
       'query': query
     });

     final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
     return data;

   }on DioError catch (err){
     print(err);
     return [];
   }


 }











}
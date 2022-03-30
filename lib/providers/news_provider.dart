import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = FutureProvider((ref) => NewsProvider.getNews());

class NewsProvider{

static  Future<List<News>> getNews () async{
    final dio = Dio();
     try{
       final response = await dio.get(Api.newsApi, queryParameters: {
         'q': 'latest',
         'lang': 'en'
       }, options: Options(
         headers: {
           'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
           'X-RapidAPI-Key': '4f981854f9msh55baa80c3d771a9p1244e2jsn5dac6b03155d'
         }
       )
       );
       final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
       return data;
     } on DioError catch (e){
       print(e);
        return [];
    }
  }




}



final searchNewsProvider = FutureProvider.family((ref, String q) => SearchNewsProvider(query: q).getNews());

class SearchNewsProvider{

  SearchNewsProvider({required this.query});
  String query;

    Future<List<News>> getNews () async{
    final dio = Dio();
    try{
      final response = await dio.get(Api.newsApi, queryParameters: {
        'q': query,
        'lang': 'en'
      }, options: Options(
          headers: {
            'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
            'X-RapidAPI-Key': '4f981854f9msh55baa80c3d771a9p1244e2jsn5dac6b03155d'
          }
      )
      );
      final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
     await Future.delayed(Duration(seconds: 10));
      return data;
    } on DioError catch (e){
      print(e);
      return [];
    }
  }




}
import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final newsProvider = FutureProvider.family((ref, String q) => NewsProvider(query: q).getNews());

class NewsProvider{

  NewsProvider({required this.query});
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

      return data;
    } on DioError catch (e){
      print(e);
      return [];
    }
  }


}



final searchNewsProvider = StateNotifierProvider<SearchNewsProvider, List<News>>((ref) => SearchNewsProvider());

class SearchNewsProvider extends  StateNotifier<List<News>>{
  SearchNewsProvider() : super([]){
    getNews();
  }

  Future<void> getNews () async{
    final dio = Dio();
    try{
      await Future.delayed(Duration(seconds: 3));
      final response = await dio.get(Api.newsApi, queryParameters: {
        'q': 'news',
        'lang': 'en'
      }, options: Options(
          headers: {
            'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
            'X-RapidAPI-Key': '4f981854f9msh55baa80c3d771a9p1244e2jsn5dac6b03155d'
          }
      )
      );
      final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
         state = data;
    } on DioError catch (e){
      print(e);
    }
  }


  Future<void> search (String query) async{
    final dio = Dio();
    try{
       state = [];
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
      if(response.data['status'] == 'No matches for your search.'){
            state =  [News(
                title: 'no title',
                summary: '',
                author:'',
                link: '',
                media: '',
                published_date:'')];
      }else{
        final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
        state = data;
      }

    } on DioError catch (e){
      print(e);
    }
  }







}
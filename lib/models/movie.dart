


class Movie{
final int id;
final String title;
final String overview;
final String poster_path;
final String release_date;
final String vote_avergae;



Movie({
  required this.id,
  required this.title,
  required this.overview,
  required this.poster_path,
  required this.release_date,
  required this.vote_avergae
});


 factory Movie.fromJson(Map<String, dynamic> json){
   return Movie(
       id: json['id'],
       title: json['title'],
       overview: json['overview'],
       poster_path: json['poster_path'] ?? '',
       release_date: json['release_date'],
       vote_avergae: json['vote_average'].toString()
   );
 }


}
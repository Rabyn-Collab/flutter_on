



class News{

  late String title;
  late String author;
  late String published_date;
  late String link;
  late String summary;
  late String media;

  News({
    required this.title,
    required this.summary,
    required this.author,
    required this.link,
    required this.media,
    required this.published_date
});

factory News.fromJson(Map<String, dynamic> json){
  return News(
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      author: json['author'] ?? '',
      link: json['link'] ?? '',
      media: json['media'] ?? '',
      published_date: json['published_date'] ?? ''
  );
}



}



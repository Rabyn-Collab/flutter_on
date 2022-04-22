class Like{
  late int likes;
  late List<String> usernames;

  Like({
    required this.likes,
    required this.usernames
});

  factory Like.fromJson(Map<String, dynamic> json){
     return Like(
         likes: json['like'],
         usernames: (json['usernames'] as List).map((e) => (e as String)).toList()
     );
  }

  Map<String, dynamic> toJson(){
    return {
      'usernames': this.usernames,
      'like': this.likes
    };
  }


}



class Comments{
  late String username;
  late String imageUrl;
  late String comment;

  Comments({
   required this.comment,
    required this.imageUrl,
    required this.username
  });

  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
        comment: json['comment'],
      imageUrl: json['imageUrl'],
      username: json['username']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'comment':  this.comment,
      'imageUrl': this.imageUrl,
      'username': this.username
    };
  }


}


class Post{
  late String id;
  late String imageId;
  late String userId;
  late String title;
  late String description;
  late String imageUrl;
  late Like likData;
  late List<Comments> comments;

  Post({
    required this.imageUrl,
    required this.title,
    required this.comments,
    required this.description,
    required this.id,
    required this.imageId,
    required this.likData,
    required this.userId
});


}
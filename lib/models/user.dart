


class User{
late String email;
late String imageUrl;
late String userId;
late String username;


User({
  required this.userId,
  required this.imageUrl,
  required this.username,
  required this.email
});


factory User.fromJson(Map<String, dynamic> json){
  return User(
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      email: json['email']
  );
}



}
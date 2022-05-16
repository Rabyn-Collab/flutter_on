import 'package:hive/hive.dart';
part 'user.g.dart';



@HiveType(typeId: 0)
class User extends HiveObject{

@HiveField(0)
late String email;

@HiveField(1)
late String token;

@HiveField(2)
late String username;


User({
   required this.token,
  required this.username,
  required this.email
});


factory User.fromJson(Map<String, dynamic> json){
  return User(
    token: json['token'],
      username: json['username'],
      email: json['email']
  );
}



}
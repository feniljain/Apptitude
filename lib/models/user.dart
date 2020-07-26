import 'package:flutter/foundation.dart';

class User {
  
  User({
    @required this.userId,
    @required this.userName,
    @required this.token
  }): assert(token!=null);

  factory User.fromJson(dynamic json) {
    return User(
        userId: json['userId'],
        userName: json['userName'],
        token: json['token']
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'token': token
    };
  }

  final String userId;
  final String userName;
  final String token;
}

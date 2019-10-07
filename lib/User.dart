class User {
  String userId;
  String token;
  User({this.userId, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      token: json['token'],
    );
  }
}

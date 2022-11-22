class User {
  final String uid;
  final String email;
  final String username;
  double? coin;
  String? coverImageUrl;

  User(
      {required this.uid,
      required this.email,
      required this.username,
      this.coin,
      this.coverImageUrl});

  User.fromMap({required Map<String, dynamic> userMap})
      : uid = userMap['uid'],
        email = userMap['email'],
        username = userMap['username'],
        coin = userMap['coin'],
        coverImageUrl = userMap['coverImageUrl'];

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'username': username,
        'coin': coin ?? 0,
        'coverImageUrl': coverImageUrl ?? ""
      };
}

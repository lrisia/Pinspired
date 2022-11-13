class Transactionn {
  final String uid;
  final String description;
  final String user_id;
  final String coin;

  Transactionn(
      {required this.uid,
      required this.description,
      required this.user_id,
      required this.coin});

  Transactionn.fromMap({required Map<String, dynamic> transactionMap})
      : uid = transactionMap['uid'],
        description = transactionMap['description'],
        user_id = transactionMap['user_id'],
        coin = transactionMap['coin'];

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'description': description,
        'user_id': user_id,
        'coin': coin,
      };
}
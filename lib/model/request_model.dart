enum PostTag {Waiting, NewRequest, denieded, Accpeted, unknown}


class Request {
  final String description;
  final String id;
  final int cost;
  final String state;
  final String user_hirer;
  final String user_workForHire;

  Request({
    required this.id,
    required this.description,
    required this.cost,
    required this.user_hirer,
    required this.user_workForHire,
    required this.state
  } 
  );

  Request.fromMap({required Map<String, dynamic> requestMap})
      : id = requestMap['id'],
        description = requestMap['description'],
        cost = requestMap['cost'],
        user_hirer = requestMap['user_hirer'],
        user_workForHire = requestMap['user_workForHire'],
        state = requestMap['state'];


          Map<String, dynamic> toMap() => {
        'id': id,
        'description': description,
        'cost': cost,
        'user_hirer': user_hirer ,
        'user_workForHire': user_workForHire ,
        'state': state
      };


}
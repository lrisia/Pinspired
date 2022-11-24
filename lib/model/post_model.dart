import 'package:cnc_shop/model/product_model.dart';

enum PostTag {Illustration, Drawing, Fashion, Photo, Food, Architecture, Sky, Nature, Animal, Other}

class Post{
  final String postId;
  final String userId;
  final String? description;
  final PostTag tag;
  final String photoURL;

  static PostTag getPostTag(String tag) {
    switch (tag) {
      case 'Illustration':
        return PostTag.Illustration;
        case 'Illustator':
        return PostTag.Illustration;
      case 'Drawing':
        return PostTag.Drawing;
      case 'Fashion':
        return PostTag.Fashion;
      case 'Photo':
        return PostTag.Photo;
      case 'Food':
        return PostTag.Food;
      case 'Architecture':
        return PostTag.Architecture;
      case 'Sky':
        return PostTag.Sky;
      case 'Nature':
        return PostTag.Nature;
      case 'Animal':
        return PostTag.Animal;
      default:
        return PostTag.Other;
    }

}

Post({
  required this.postId,
  required this.userId,
  this.description,
  required this.tag,
  required this.photoURL,
});

  Post.fromMap({required Map<String, dynamic> postMap})
      : postId = postMap['postId'] ?? '',
        userId = postMap['userId'] ?? '',
        description = postMap['description'] ?? '',
        photoURL = postMap['photoURL'] ?? '',
        tag = getPostTag(postMap['tag']);

  Map<String, dynamic> toMap() => {
        'postId': postId,
        'userId': userId,
        'description': description,
        'photoURL': photoURL ,
        'tag': tag.name.toString()
      };

}



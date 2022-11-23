import 'dart:developer';

import 'package:cnc_shop/model/product_model.dart';

enum PostTag {Illustator, Drawing, Fashion, Photo, unknown}

class Post{
  final String uid;
  final String? description;
  final PostTag tag;
  final String photoURL;

  static PostTag getPostType(String type) {
    switch (type.toLowerCase()) {
      case 'Illustator':
        return PostTag.Illustator;
      case 'Drawing':
        return PostTag.Drawing;
      case 'Fashion':
        return PostTag.Fashion;
      case 'Photo':
        return PostTag.Photo;
      default:
        return PostTag.unknown;
    }

}

Post({
  required this.uid,
  this.description,
  required this.tag,
  required this.photoURL,
});

  Post.fromMap({required Map<String, dynamic> postMap})
      : uid = postMap['uid'] ?? '',
        description = postMap['description'] ?? '',
        photoURL = postMap['photoURL'] ?? '',
        tag = getPostType(postMap['tag']);

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'description': description,
        'photoURL': photoURL ,
        'tag': tag.name.toString()
      };

  @override
  String toString() {
    return 'Product{uid: $uid, description: $description, photoURL: $photoURL, tag: $tag}';
  }
}



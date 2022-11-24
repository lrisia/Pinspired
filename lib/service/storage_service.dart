import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProductImage({required File imageFile}) async {
    String unixTime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    final fileName = imageFile.path.split('/').last;
    final fileNameArray = fileName.split('.');
    final fileNameAndTime =
        '${fileNameArray[0]}${unixTime}${fileNameArray.last}';

    try {
      final uploadTask = await _firebaseStorage
          .ref('products/$fileNameAndTime')
          .putFile(imageFile);

      final imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String?> uploadCoverImage({required File imageFile}) async {
    String unixTime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    final fileName = imageFile.path.split('/').last;
    final fileNameArray = fileName.split('.');
    final fileNameAndTime =
        '${fileNameArray[0]}${unixTime}${fileNameArray.last}';


    try {
      final uploadTask = await _firebaseStorage
          .ref('covers/$fileNameAndTime')
          .putFile(imageFile);

      final imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } on FirebaseException catch (e) {
      print(e);
    }
    return "https://firebasestorage.googleapis.com/v0/b/cnc-shop-caa9d.appspot.com/o/covers%2Fdefualt_cover.png?alt=media&token=c16965aa-a181-4c12-b528-b23221c23e17";
  }

Future<String?> uploadPostImage({required File imageFile}) async {
    String unixTime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    final fileName = imageFile.path.split('/').last;
    final fileNameArray = fileName.split('.');
    final fileNameAndTime =
        '${fileNameArray[0]}${unixTime}${fileNameArray.last}';
    try {
      final uploadTask = await _firebaseStorage
          .ref('posts/$fileNameAndTime')
          .putFile(imageFile);

      final imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

    Future<String?> getImage({required String path}) async {
      try {
        final imageUrl = await _firebaseStorage.ref(path).getDownloadURL();

        return imageUrl;
      } on FirebaseException catch (e) {
        print(e);
      }
    }
}


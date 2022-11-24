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
      print(imageUrl+'-------------------------------');
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


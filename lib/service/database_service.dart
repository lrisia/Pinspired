import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnc_shop/model/product_model.dart';
import 'package:cnc_shop/model/request_model.dart';
import 'package:cnc_shop/model/transactionn_model.dart';
import 'package:cnc_shop/model/user_model.dart';

import '../model/post_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  Future<void> createUserFromModel({required User user}) async {
    final docUser = _firebaseStore.collection('users').doc(user.uid);
    final Map<String, dynamic> userInfo = user.toMap();
    await docUser.set(userInfo);
  }

  

  Future<User?> getUserFromUid({required uid}) async {
    final docUser = _firebaseStore.collection('users').doc(uid);
    final snapshot = await docUser.get();

    if (!snapshot.exists) return null;

    final userInfo = snapshot.data();
    final user = User.fromMap(userMap: userInfo!);
    return user;
  }

  Future<void> updateUserFromUid({required uid, required User user}) async {
    final docUser = _firebaseStore.collection('users').doc(uid);
    final newUserInfo = user.toMap();

    docUser.set(newUserInfo);
  }

  Future<List<Product?>> getFutureListProduct() async {
    final snapshot = await _firebaseStore.collection('products').get();

    return snapshot.docs
        .map((doc) => Product.fromMap(productMap: doc.data()))
        .toList();
  }

  Future<User?> getUserFormEmail({required email}) async {
    final docUser = _firebaseStore.collection('users').doc(email);
    final snapshot = await docUser.get();

    if (!snapshot.exists) {
      return null;
    }

    final userInfo = snapshot.data();
    final user = User.fromMap(userMap: userInfo!);
    return user;
  }



  Stream<List<Post>> getStreamListPost() => _firebaseStore
      .collection('posts')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return Post.fromMap(postMap: doc.data());
          }).toList());


  Stream<List<Product>> getStreamListProduct() => _firebaseStore
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            // print(doc.data());
            return Product.fromMap(productMap: doc.data());
          }).toList());


  Stream<List<Request>> getStreamListRequest() => _firebaseStore
      .collection('requests')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            // print(doc.data());
            return Request.fromMap(requestMap: doc.data());
          }).toList());

  Future<void>addPost({required post})async {
    final docPost = _firebaseStore.collection('posts').doc();

    final Map<String, dynamic> postInfo = post.toMap();

    await docPost.set(postInfo);

  }

  Future<void> addProduct({required product}) async {
    final docProduct = _firebaseStore.collection('products').doc();

    final Map<String, dynamic> productInfo = product.toMap();

    await docProduct.set(productInfo);
  }

  Future<void> updateProductFromUid({required product}) async {
    // final String productUid = product['uid'];
    // log("product uid: $productUid");

    return _firebaseStore.collection('products').doc(product['uid']).update(product);
    // final Map<String, dynamic> converted = getProduct.docs.forEach()


    // log("product: " + getProduct.toString());
    // await docProduct.update(productInfo);
  }

}

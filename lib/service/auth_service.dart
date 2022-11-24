import 'package:cnc_shop/model/user_model.dart';
import 'package:cnc_shop/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final DatabaseService _databaseService;

  AuthService({required DatabaseService dbService})
      : _databaseService = dbService;

  Future<User?> currentUser() async {
    return await _databaseService.getUserFromUid(
        uid: _firebaseAuth.currentUser?.uid);
  }

  Future<User?> signInWithEmailAndPassword(
      {required email, required password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email!, password: password!);

    final userUid = userCredential.user?.uid;
    final user = await _databaseService.getUserFromUid(uid: userUid);
    return user;
  }

  Future<User?> signInWithEmail({required email}) async {
    final userUid = email;
    final user = await _databaseService.getUserFromUid(uid: userUid);
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    return;
  }

  Future<User> createUser(
      {required email,
      required username,
      required password,
      coin,
      coverImageUrl}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (userCredential.user == null) {
      throw Exception('create user with email and password return null');
    }
    final firebaseUser = userCredential.user;
    final newUser = User(
        uid: firebaseUser!.uid,
        email: email,
        username: username,
        coin: 0,
        coverImageUrl: "https://firebasestorage.googleapis.com/v0/b/cnc-shop-caa9d.appspot.com/o/covers%2Fdefualt_cover.png?alt=media&token=c16965aa-a181-4c12-b528-b23221c23e17");

    //TODO add new user to firestore, database
    await _databaseService.createUserFromModel(user: newUser);

    return newUser;
  }

  Future<User> createUserGoogle(
      {required email,
      required username,
      required uid,
      phone,
      address,
      coin}) async {
    final newUser = User(uid: uid, email: email, username: username, coin: 0);

    //TODO add new user to firestore, database
    await _databaseService.createUserFromModel(user: newUser);
    return newUser;
  }
}

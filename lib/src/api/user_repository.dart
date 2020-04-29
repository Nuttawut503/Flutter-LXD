import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CollectionReference _userCollection;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin, CollectionReference userCollection})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _userCollection = userCollection ?? Firestore.instance.collection('users');

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    await _updateUserActivation(await getUser());
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> _updateUserActivation(user) async {
    final userSnapshot = await _userCollection.document('${user['id']}').get();
    if (userSnapshot.exists) {
      await _userCollection
        .document('${user['id']}')
        .updateData({
          'name': user['name'],
          'profile_image_url': user['profile_picture_url'],
          'latest_signin': DateTime.now()
        });
    } else {
      await _userCollection
        .document('${user['id']}')
        .setData({
          'email': user['email'],
          'name': user['name'],
          'profile_image_url': user['profile_picture_url'],
          'signup_date': DateTime.now(),
          'latest_signin': DateTime.now(),
          'is_admin': false
        });
    }
  }

  Future<String> findNameOfUserById(userId) async {
    return (await _userCollection.document('$userId').get()).data['name'];
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<Map<String, String>> getUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    return {
      'id': currentUser.uid,
      'name': currentUser.displayName,
      'email': currentUser.email,
      'profile_picture_url': currentUser.photoUrl,
    };
  }
}

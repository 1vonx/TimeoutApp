import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../model/place.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _fireStorage = FirebaseStorage.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user!.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user!.uid;
  }

  Future<void> signOut() async {
    //_snapshotService.setWasteLessLifeUserObject({});
    return _firebaseAuth.signOut();
  }

  Future<List<Place>> getPlacesFromFirebase() async {
    List<Place> placeList = [];
    try {
      final places = await _fireStore.collection("places").get();

      for (var place in places.docs) {
        placeList.add(Place.fromJson(place.data()));
      }

      return placeList;
    } on FirebaseException catch (e) {
      if(kDebugMode){
        print(e);
      }
      return placeList;
    } catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> setUserInfo(String userId, String username, String email, url) {
    return _fireStore.collection('users').doc(userId).set({
      'username': username,
      'email': email,
      'user_image': url,
    });
  }

  Future<String> getDownloadUrl(String userId, File image) async {
    final ref =  _fireStorage
        .refFromURL('gs://flutter-timeout-app.appspot.com')
        .child('user_image')
        .child('$userId.jpg');

    await ref.putFile(image);

    final url = await ref.getDownloadURL();

    return url;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class FirebaseFirestoreService {
  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}

@module
abstract class FirebaseStorageService {
  @lazySingleton
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
}

@module
abstract class SharedPreferencesService {
  @preResolve
  Future<SharedPreferences> get shaerdPreferences =>
      SharedPreferences.getInstance();
}

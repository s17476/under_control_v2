import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseFirestoreService {
  @lazySingleton
  FirebaseFirestore get firebaseAuth => FirebaseFirestore.instance;
}

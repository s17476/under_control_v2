import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_firebase/flutter_cache_manager_firebase.dart';

Future<File?> getCachedFirebaseStorageFile(
    String storageFullUrl, String key) async {
  try {
    final fileReference = FirebaseStorage.instance.refFromURL(storageFullUrl);
    var file = await FirebaseCacheManager().getSingleFile(
      fileReference.fullPath,
      key: key,
    );
    return file;
  } catch (e) {
    debugPrint('Get Cached Firebase Storage File');
    debugPrint(e.toString());
  }
  return null;
}

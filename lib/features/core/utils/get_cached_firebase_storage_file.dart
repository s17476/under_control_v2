import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<File?> getCachedFirebaseStorageFile(String storageFullUrl) async {
  try {
    final fileReference = FirebaseStorage.instance.refFromURL(storageFullUrl);
    var file = await DefaultCacheManager().getSingleFile(
      fileReference.fullPath,
    );
    return file;
  } catch (e) {
    debugPrint('Get Cached Firebase Storage File');
    debugPrint(e.toString());
  }
  return null;
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<File?> getCachedFirebaseStorageFile(String storageFullUrl) async {
  try {
    var file = await DefaultCacheManager().getSingleFile(storageFullUrl);
    return file;
  } catch (e) {
    debugPrint('Get Cached Firebase Storage File');
    debugPrint(e.toString());
  }
  return null;
}

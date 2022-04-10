import 'dart:async';
import 'dart:typed_data';

import 'package:app_tracker_search/net/api.dart';
import 'package:flutter/services.dart';

class IconRepo {
  final Api _api = Api.getInstance();

  // Future<Uint8List> getIcon(String packageName) {
  //   return Future(() async {
  //     var icon = await _api.getIcon(packageName);
  //     return await consolidateHttpClientResponseBytes(
  //         icon.data as HttpClientResponse);
  //   });
  // }

  Future<void> saveIcon(String imageUrl) {
    return Future(() async {
      Uint8List bytes =
          (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
              .buffer
              .asUint8List();
    });
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IconModel with ChangeNotifier {
  List<IconData> icons = [];

  Future<void> getIcon(String packageName) async {
    var imageUrl = 'https://bot.k2t3k.tk/api/appIcon?packageName=$packageName';
    var icon = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    icons.add(IconData(packageName: packageName, icon: icon));
    notifyListeners();
  }

  //   Future<void> saveIcon(String imageUrl) {
  //   return Future(() async {
  //     var bytes = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
  //         .buffer
  //         .asUint8List();
  //     var cachePath = await getTemporaryDirectory();
  //     var file = File('${cachePath.path}/${data.packageName}.png');
  //     await file.writeAsBytes(bytes);
  //   });
  // }
}

class IconData {
  String packageName;
  Uint8List icon;

  IconData({
    required this.packageName,
    required this.icon,
  });
}

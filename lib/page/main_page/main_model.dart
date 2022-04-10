import 'package:app_tracker_search/repo/icon_repo.dart';
import 'package:app_tracker_search/repo/search_repo.dart';
import 'package:app_tracker_search/types/search_list.dart';
import 'package:flutter/material.dart';

class MainModel with ChangeNotifier {
  List<SearchListData>? searchListData;

  bool first = true;
  bool searching = false;
  bool empty = true;

  String? currIconUrl;

  search(String appName) async {
    if (appName.isEmpty) {
      return;
    }

    first = false;
    searching = true;
    notifyListeners();
    var result = await SearchRepo().search(appName);

    if (result != null) {
      empty = false;
    } else {
      empty = true;
    }

    searchListData = result;
    searching = false;
    notifyListeners();
    print("""
      searchListData: ${searchListData}
      first: ${first}
      searching: ${searching}
      empty: ${empty}
    """);
  }

  getIconUrl(String packageName) async {
    currIconUrl = await IconRepo().getIconUrl(packageName);
    notifyListeners();
  }
}

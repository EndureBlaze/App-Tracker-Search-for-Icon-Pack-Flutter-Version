import 'package:app_tracker_search/net/api.dart';
import 'package:app_tracker_search/types/search_list.dart';
import 'package:app_tracker_search/types/search_response.dart';

class SearchRepo {
  final Api _api = Api.getInstance();

  Future<List<SearchListData>?> search(String appName) {
    return Future(() async {
      final response = await _api.search(appName);
      final data = SearchResponse.fromJson(response.data);
      if (data.items!.isNotEmpty) {
        return data.items!.map((item) {
          return SearchListData(
            appName: item.appName ?? '',
            packageName: item.packageName ?? '',
            activityName: item.activityName ?? '',
          );
        }).toList();
      } else {
        return null;
      }
    });
  }
}

import 'package:app_tracker_search/net/api.dart';

class IconRepo {
  final Api _api = Api.getInstance();

  Future<String> getIconUrl(String packageName) {
    return Future(() async {
      var url = await _api.getIconUrl(packageName);
      return url as String;
    });
  }
}

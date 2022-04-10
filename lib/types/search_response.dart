class SearchResponse {
  Metadata? metadata;
  List<Items>? items;

  SearchResponse({this.metadata, this.items});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? page;
  int? per;
  int? total;

  Metadata({this.page, this.per, this.total});

  Metadata.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    per = json['per'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per'] = this.per;
    data['total'] = this.total;
    return data;
  }
}

class Items {
  String? appName;
  String? signature;
  String? id;
  String? activityName;
  int? count;
  String? packageName;

  Items(
      {this.appName,
      this.signature,
      this.id,
      this.activityName,
      this.count,
      this.packageName});

  Items.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    signature = json['signature'];
    id = json['id'];
    activityName = json['activityName'];
    count = json['count'];
    packageName = json['packageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['signature'] = this.signature;
    data['id'] = this.id;
    data['activityName'] = this.activityName;
    data['count'] = this.count;
    data['packageName'] = this.packageName;
    return data;
  }
}

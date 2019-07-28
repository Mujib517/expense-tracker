class Category {
  int id;
  String name;
  int icon;
  int type;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();

    if (id != null) map["id"] = id;
    map["name"] = name;
    map["name"] = name;
    map["icon"] = icon;
    map["type"] = type;

    return map;
  }

  Category.fromObject(dynamic obj) {
    id = obj["id"];
    name = obj["name"];
    icon = obj["icon"];
    type = obj["type"];
  }
}

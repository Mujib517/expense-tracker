import 'category.dart';

class Entry {
  int id;
  int categoryId;
  String name;
  String date;
  num amount;
  int type;
  Category category;

  Entry(this.categoryId, this.name, this.date, this.amount, this.type);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();

    if (id != null) map["id"] = id;
    map["categoryId"] = categoryId;
    map["name"] = name;
    map["date"] = date;
    map["amount"] = amount;
    map["type"] = type;

    return map;
  }

  Entry.fromObject(dynamic obj) {
    id = obj["id"];
    categoryId = obj["categoryId"];
    name = obj["name"];
    date = obj["date"];
    amount = obj["amount"];
    type = obj["type"];
    if (obj["icon"] != null && obj["categoryName"] != null) {
      category =
          Category(obj["categoryName"], obj["icon"], obj["categoryType"]);
    }
  }
}

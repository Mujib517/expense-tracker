class Entry{
  int id;
  int categoryId;
  String name;
  String date;
  num amount;
  int type;

  Entry(this.categoryId,this.name,this.date,this.amount,this.type);

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
}
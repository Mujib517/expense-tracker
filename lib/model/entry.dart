import 'package:tracker/model/type.dart';

class Entry{
  int id;
  int categoryId;
  String name;
  DateTime date;
  num amount;
  EntryType type;
}
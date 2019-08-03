class Queries {
  static String tblData = "entry", tblCat = "category";
  static String createCatTable =
      "CREATE TABLE category (id INTEGER PRIMARY KEY,name TEXT, icon INTEGER,type INTEGER);";

  static String createEntryTable =
      "CREATE TABLE entry(id INTEGER PRIMARY KEY,name TEXT,type INTEGER,categoryId INTEGER,date TEXT,amount REAL);";

  static String seedCatData =
      "INSERT INTO $tblCat(name,icon,type) VALUES ('Food',0xe57a,1),('Drink',0xeb44,1),('Salary',0xe850,0),('Rent',0xe88a,0);";

  static String getCatData = "SELECT * FROM $tblCat ORDER BY id";

  static String getExpensesEntry =
      "SELECT A.id,A.name,A.type,A.categoryId,A.date,A.amount,B.icon,B.name as categoryName,B.type as categoryType FROM $tblData A "
      "INNER JOIN $tblCat B ON A.categoryId = B.id WHERE A.type=? ORDER BY A.id DESC";
}

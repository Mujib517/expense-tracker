class Queries {
  static String createCatTable =
      "CREATE TABLE category (id INTEGER PRIMARY KEY,name TEXT, icon INTEGER,type INTEGER);";

  static String createEntryTable =
      "CREATE TABLE entry(id INTEGER PRIMARY KEY,name TEXT,type INTEGER,categoryId INTEGER,date DATETIME,amount REAL);";

  static String seedCatData =
      "INSERT INTO category(name,icon,type) VALUES ('Food',0xe57a,1),('Drink',0xeb44,1),('Salary',0xe850,0),('Rent',0xe88a,0);";

  static String getCatData = "SELECT * FROM category ORDER BY id";
}

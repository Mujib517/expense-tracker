class Queries {
  static String createDb =
      'CREATE TABLE category (id INTEGER,name TEXT, icon TEXT)'
      'CREATE TABLE entry(id INTEGER,name TEXT,type INTEGER,categoryId INTEGER,date DATETIME,amount REAL)';
}

import 'package:kuza/models/customers.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  // Define your database table and column names

  final String columnId = 'id';

  // Table name for Customers
  final String customerTableName = 'customers'; // Table name for customers
  final String columnName = 'name';
  final String columnContactNo = 'contactNo';
  final String columnEmailAddress = 'emailAddress';
  final String columnDate = 'date'; // Added column for date

  // Singleton constructor
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  DatabaseHelper._createInstance();

  // Get a reference to the database and create it if necessary
  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // Initialize the database
  Future<Database> initializeDatabase() async {
    try {
      final String path = join(await getDatabasesPath(), 'kuza.db');
      final Database database = await openDatabase(
        path,
        version: 3,
        onCreate: _createDb,
        onUpgrade: _upgradeDb,
      );
      return database;
    } catch (e) {
      print('Error initializing database: $e');
      throw e; // Rethrow the exception to propagate it further
    }
  }

  // Create the database tables for products and expenses
  void _createDb(Database db, int newVersion) async {
    // Create the customers table
    await db.execute('''
    CREATE TABLE $customerTableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT,
      $columnContactNo TEXT,
      $columnEmailAddress TEXT,
      $columnDate TEXT
    )
  ''');
  }

  // Implement schema migration logic if necessary
  void _upgradeDb(Database db, int oldVersion, int newVersion) {
    // Implement schema migration logic here
  }

  // Insert a customer into the customers table
  Future<int> insertCustomer(Customer customer) async {
    final Database? db = await database;
    final int result = await db!.insert(
      customerTableName,
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  // Query all customers from the customers table
  Future<List<Customer>> getCustomers() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(customerTableName);
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }

  // Update a customer in the customers table
  Future<int> updateCustomer(Customer customer) async {
    final Database? db = await database;
    final int result = await db!.update(
      customerTableName,
      customer.toMap(),
      where: '$columnId = ?',
      whereArgs: [customer.id],
    );
    return result;
  }

  // Delete a customer from the customers table
  Future<int> deleteCustomer(int id) async {
    final Database? db = await database;
    final int result = await db!.delete(
      customerTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result;
  }

  // Close the database
  Future<void> close() async {
    final Database? db = await database;
    db?.close();
  }
}

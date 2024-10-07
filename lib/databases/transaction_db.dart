import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:league_of_legends_universe/models/transactions.dart';


class TransactionDB{
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation  = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertDatabase(Transactions statement) async{
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');

    var keyID  = store.add(db, {
      "champion": statement.champion,
      "region": statement.region,
      "role" : statement.role,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  Future<List<Transactions>> loadAllData()async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactions = [];
    for (var record in snapshot) {
      transactions.add(Transactions(
        keyID: record.key,
        champion: record['champion'].toString(),
        role: record['role'].toString(),
        region: record['region'].toString(),
        date: DateTime.parse(record['date'].toString())
      ));
    }
    return transactions;
  }
  
  deleteDatabase(int? index) async{
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, index)));
  }

  updateDatabase(Transactions statement) async{
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var filter = Finder(filter: Filter.equals(Field.key, statement.keyID));
    var result = store.update(db, finder: filter,  {
      "champion": statement.champion,
      "role": statement.role,
      "region": statement.region,
      "date": statement.date.toIso8601String()
    });
    db.close();
    print('update result: $result');
  }
}
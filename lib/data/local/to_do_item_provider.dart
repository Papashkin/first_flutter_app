import 'package:first_flutter_app/models/to_do_item.dart';
import 'package:sqflite/sqflite.dart';

final String tableToDoItem = 'toDoItem';

class ToDoItemProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableToDoItem (
          $columnId integer primary key autoincrement,
          $columnName text not null,
          $columnSelected integer not null)
            ''');
    });
  }

  Future<ToDoItem> insert(ToDoItem item) async {
    await db.insert(tableToDoItem, item.toMap());
    return item;
  }

  Future<List<ToDoItem>> getAll() async {
    var data = await db.query(tableToDoItem);
    if (data.length > 0) {
      return data.map((item) => ToDoItem.fromMap(item)).toList();
    } else {
      return null;
    }
  }

  Future delete(int id) async =>
      await db.delete(tableToDoItem, where: '$columnId = ?', whereArgs: [id]);

  Future update(ToDoItem item) async =>
      await db.update(tableToDoItem, item.toMap(), where: '$columnId = ?', whereArgs: [item.id]);

  Future close() async => db.close();

}
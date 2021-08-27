// import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 50)();
  // BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;
  Future<List<Task>> getAllTask() => select(tasks).get();
  Stream<List<Task>> watchAllTask() => select(tasks).watch();
  Future insertNewTasks(TasksCompanion task) => into(tasks).insert(task);
  Future deleteTasks(Task task) => delete(tasks).delete(task);
  Future updateTask(Task task) => update(tasks).replace(task);
}

// @UseDao(tables: [Tasks])

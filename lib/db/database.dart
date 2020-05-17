import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Words extends Table {
  TextColumn get strFoodName => text()();

  DateTimeColumn get dateFoodOfLimit => dateTime()();

  @override
  Set<Column> get primaryKey => {strFoodName};
}

@UseMoor(tables: [Words])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  //Create
  Future addWord(Word word) => into(words).insert(word);

  //Read 全件読み込み
  Future<List<Word>> get allWords => select(words).get();

  //Read 消費期限近い順で降順
  Future<List<Word>> get allWordsDescendLimitOfFood => (select(words)
        ..orderBy([(table) => OrderingTerm(expression: table.dateFoodOfLimit,mode: OrderingMode.desc)]))
      .get();

  //Read 消費期限近い順で昇順
  Future<List<Word>> get allWordsAscendLimitOfFood => (select(words)
        ..orderBy([(table) => OrderingTerm(expression: table.dateFoodOfLimit, mode: OrderingMode.asc)]))
      .get();

  //Update
  Future updateWord(Word word) => update(words).replace(word);

  //Delete
  Future deleteWord(Word word) => (delete(words)
        ..where((table) => table.strFoodName.equals(word.strFoodName)))
      .go();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'words.db'));
    return VmDatabase(file);
  });
}

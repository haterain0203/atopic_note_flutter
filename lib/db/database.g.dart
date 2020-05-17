// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final String strFoodName;
  final DateTime dateFoodOfLimit;
  Word({@required this.strFoodName, @required this.dateFoodOfLimit});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Word(
      strFoodName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_food_name']),
      dateFoodOfLimit: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}date_food_of_limit']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || strFoodName != null) {
      map['str_food_name'] = Variable<String>(strFoodName);
    }
    if (!nullToAbsent || dateFoodOfLimit != null) {
      map['date_food_of_limit'] = Variable<DateTime>(dateFoodOfLimit);
    }
    return map;
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Word(
      strFoodName: serializer.fromJson<String>(json['strFoodName']),
      dateFoodOfLimit: serializer.fromJson<DateTime>(json['dateFoodOfLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strFoodName': serializer.toJson<String>(strFoodName),
      'dateFoodOfLimit': serializer.toJson<DateTime>(dateFoodOfLimit),
    };
  }

  Word copyWith({String strFoodName, DateTime dateFoodOfLimit}) => Word(
        strFoodName: strFoodName ?? this.strFoodName,
        dateFoodOfLimit: dateFoodOfLimit ?? this.dateFoodOfLimit,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strFoodName: $strFoodName, ')
          ..write('dateFoodOfLimit: $dateFoodOfLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(strFoodName.hashCode, dateFoodOfLimit.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Word &&
          other.strFoodName == this.strFoodName &&
          other.dateFoodOfLimit == this.dateFoodOfLimit);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strFoodName;
  final Value<DateTime> dateFoodOfLimit;
  const WordsCompanion({
    this.strFoodName = const Value.absent(),
    this.dateFoodOfLimit = const Value.absent(),
  });
  WordsCompanion.insert({
    @required String strFoodName,
    @required DateTime dateFoodOfLimit,
  })  : strFoodName = Value(strFoodName),
        dateFoodOfLimit = Value(dateFoodOfLimit);
  static Insertable<Word> custom({
    Expression<String> strFoodName,
    Expression<DateTime> dateFoodOfLimit,
  }) {
    return RawValuesInsertable({
      if (strFoodName != null) 'str_food_name': strFoodName,
      if (dateFoodOfLimit != null) 'date_food_of_limit': dateFoodOfLimit,
    });
  }

  WordsCompanion copyWith(
      {Value<String> strFoodName, Value<DateTime> dateFoodOfLimit}) {
    return WordsCompanion(
      strFoodName: strFoodName ?? this.strFoodName,
      dateFoodOfLimit: dateFoodOfLimit ?? this.dateFoodOfLimit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (strFoodName.present) {
      map['str_food_name'] = Variable<String>(strFoodName.value);
    }
    if (dateFoodOfLimit.present) {
      map['date_food_of_limit'] = Variable<DateTime>(dateFoodOfLimit.value);
    }
    return map;
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _strFoodNameMeta =
      const VerificationMeta('strFoodName');
  GeneratedTextColumn _strFoodName;
  @override
  GeneratedTextColumn get strFoodName =>
      _strFoodName ??= _constructStrFoodName();
  GeneratedTextColumn _constructStrFoodName() {
    return GeneratedTextColumn(
      'str_food_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateFoodOfLimitMeta =
      const VerificationMeta('dateFoodOfLimit');
  GeneratedDateTimeColumn _dateFoodOfLimit;
  @override
  GeneratedDateTimeColumn get dateFoodOfLimit =>
      _dateFoodOfLimit ??= _constructDateFoodOfLimit();
  GeneratedDateTimeColumn _constructDateFoodOfLimit() {
    return GeneratedDateTimeColumn(
      'date_food_of_limit',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [strFoodName, dateFoodOfLimit];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('str_food_name')) {
      context.handle(
          _strFoodNameMeta,
          strFoodName.isAcceptableOrUnknown(
              data['str_food_name'], _strFoodNameMeta));
    } else if (isInserting) {
      context.missing(_strFoodNameMeta);
    }
    if (data.containsKey('date_food_of_limit')) {
      context.handle(
          _dateFoodOfLimitMeta,
          dateFoodOfLimit.isAcceptableOrUnknown(
              data['date_food_of_limit'], _dateFoodOfLimitMeta));
    } else if (isInserting) {
      context.missing(_dateFoodOfLimitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strFoodName};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}

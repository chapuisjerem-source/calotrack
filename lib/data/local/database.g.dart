// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _activityLevelMeta =
      const VerificationMeta('activityLevel');
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
      'activity_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
      'goal', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dailyCalorieGoalMeta =
      const VerificationMeta('dailyCalorieGoal');
  @override
  late final GeneratedColumn<int> dailyCalorieGoal = GeneratedColumn<int>(
      'daily_calorie_goal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _proteinGoalMeta =
      const VerificationMeta('proteinGoal');
  @override
  late final GeneratedColumn<int> proteinGoal = GeneratedColumn<int>(
      'protein_goal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _carbsGoalMeta =
      const VerificationMeta('carbsGoal');
  @override
  late final GeneratedColumn<int> carbsGoal = GeneratedColumn<int>(
      'carbs_goal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fatGoalMeta =
      const VerificationMeta('fatGoal');
  @override
  late final GeneratedColumn<int> fatGoal = GeneratedColumn<int>(
      'fat_goal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sex,
        age,
        heightCm,
        weightKg,
        activityLevel,
        goal,
        dailyCalorieGoal,
        proteinGoal,
        carbsGoal,
        fatGoal,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('activity_level')) {
      context.handle(
          _activityLevelMeta,
          activityLevel.isAcceptableOrUnknown(
              data['activity_level']!, _activityLevelMeta));
    } else if (isInserting) {
      context.missing(_activityLevelMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
          _goalMeta, goal.isAcceptableOrUnknown(data['goal']!, _goalMeta));
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('daily_calorie_goal')) {
      context.handle(
          _dailyCalorieGoalMeta,
          dailyCalorieGoal.isAcceptableOrUnknown(
              data['daily_calorie_goal']!, _dailyCalorieGoalMeta));
    } else if (isInserting) {
      context.missing(_dailyCalorieGoalMeta);
    }
    if (data.containsKey('protein_goal')) {
      context.handle(
          _proteinGoalMeta,
          proteinGoal.isAcceptableOrUnknown(
              data['protein_goal']!, _proteinGoalMeta));
    } else if (isInserting) {
      context.missing(_proteinGoalMeta);
    }
    if (data.containsKey('carbs_goal')) {
      context.handle(
          _carbsGoalMeta,
          carbsGoal.isAcceptableOrUnknown(
              data['carbs_goal']!, _carbsGoalMeta));
    } else if (isInserting) {
      context.missing(_carbsGoalMeta);
    }
    if (data.containsKey('fat_goal')) {
      context.handle(_fatGoalMeta,
          fatGoal.isAcceptableOrUnknown(data['fat_goal']!, _fatGoalMeta));
    } else if (isInserting) {
      context.missing(_fatGoalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _createdAtMeta,
          createdAt.isAcceptableOrUnknown(
              data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(
          _updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(
              data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      activityLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_level'])!,
      goal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal'])!,
      dailyCalorieGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}daily_calorie_goal'])!,
      proteinGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}protein_goal'])!,
      carbsGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}carbs_goal'])!,
      fatGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fat_goal'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String sex;
  final int age;
  final double heightCm;
  final double weightKg;
  final String activityLevel;
  final String goal;
  final int dailyCalorieGoal;
  final int proteinGoal;
  final int carbsGoal;
  final int fatGoal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User(
      {required this.id,
      required this.sex,
      required this.age,
      required this.heightCm,
      required this.weightKg,
      required this.activityLevel,
      required this.goal,
      required this.dailyCalorieGoal,
      required this.proteinGoal,
      required this.carbsGoal,
      required this.fatGoal,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sex'] = Variable<String>(sex);
    map['age'] = Variable<int>(age);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['activity_level'] = Variable<String>(activityLevel);
    map['goal'] = Variable<String>(goal);
    map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal);
    map['protein_goal'] = Variable<int>(proteinGoal);
    map['carbs_goal'] = Variable<int>(carbsGoal);
    map['fat_goal'] = Variable<int>(fatGoal);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      sex: Value(sex),
      age: Value(age),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      activityLevel: Value(activityLevel),
      goal: Value(goal),
      dailyCalorieGoal: Value(dailyCalorieGoal),
      proteinGoal: Value(proteinGoal),
      carbsGoal: Value(carbsGoal),
      fatGoal: Value(fatGoal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      sex: serializer.fromJson<String>(json['sex']),
      age: serializer.fromJson<int>(json['age']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      activityLevel: serializer.fromJson<String>(json['activityLevel']),
      goal: serializer.fromJson<String>(json['goal']),
      dailyCalorieGoal: serializer.fromJson<int>(json['dailyCalorieGoal']),
      proteinGoal: serializer.fromJson<int>(json['proteinGoal']),
      carbsGoal: serializer.fromJson<int>(json['carbsGoal']),
      fatGoal: serializer.fromJson<int>(json['fatGoal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  factory User.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      User.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sex': serializer.toJson<String>(sex),
      'age': serializer.toJson<int>(age),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'activityLevel': serializer.toJson<String>(activityLevel),
      'goal': serializer.toJson<String>(goal),
      'dailyCalorieGoal': serializer.toJson<int>(dailyCalorieGoal),
      'proteinGoal': serializer.toJson<int>(proteinGoal),
      'carbsGoal': serializer.toJson<int>(carbsGoal),
      'fatGoal': serializer.toJson<int>(fatGoal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith(
          {int? id,
          String? sex,
          int? age,
          double? heightCm,
          double? weightKg,
          String? activityLevel,
          String? goal,
          int? dailyCalorieGoal,
          int? proteinGoal,
          int? carbsGoal,
          int? fatGoal,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      User(
        id: id ?? this.id,
        sex: sex ?? this.sex,
        age: age ?? this.age,
        heightCm: heightCm ?? this.heightCm,
        weightKg: weightKg ?? this.weightKg,
        activityLevel: activityLevel ?? this.activityLevel,
        goal: goal ?? this.goal,
        dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
        proteinGoal: proteinGoal ?? this.proteinGoal,
        carbsGoal: carbsGoal ?? this.carbsGoal,
        fatGoal: fatGoal ?? this.fatGoal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      sex: data.sex.present ? data.sex.value : this.sex,
      age: data.age.present ? data.age.value : this.age,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      goal: data.goal.present ? data.goal.value : this.goal,
      dailyCalorieGoal: data.dailyCalorieGoal.present
          ? data.dailyCalorieGoal.value
          : this.dailyCalorieGoal,
      proteinGoal:
          data.proteinGoal.present ? data.proteinGoal.value : this.proteinGoal,
      carbsGoal:
          data.carbsGoal.present ? data.carbsGoal.value : this.carbsGoal,
      fatGoal: data.fatGoal.present ? data.fatGoal.value : this.fatGoal,
      createdAt:
          data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt:
          data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('proteinGoal: $proteinGoal, ')
          ..write('carbsGoal: $carbsGoal, ')
          ..write('fatGoal: $fatGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sex, age, heightCm, weightKg,
      activityLevel, goal, dailyCalorieGoal, proteinGoal, carbsGoal, fatGoal, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.age == this.age &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.activityLevel == this.activityLevel &&
          other.goal == this.goal &&
          other.dailyCalorieGoal == this.dailyCalorieGoal &&
          other.proteinGoal == this.proteinGoal &&
          other.carbsGoal == this.carbsGoal &&
          other.fatGoal == this.fatGoal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> sex;
  final Value<int> age;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<String> activityLevel;
  final Value<String> goal;
  final Value<int> dailyCalorieGoal;
  final Value<int> proteinGoal;
  final Value<int> carbsGoal;
  final Value<int> fatGoal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goal = const Value.absent(),
    this.dailyCalorieGoal = const Value.absent(),
    this.proteinGoal = const Value.absent(),
    this.carbsGoal = const Value.absent(),
    this.fatGoal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String sex,
    required int age,
    required double heightCm,
    required double weightKg,
    required String activityLevel,
    required String goal,
    required int dailyCalorieGoal,
    required int proteinGoal,
    required int carbsGoal,
    required int fatGoal,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sex = Value(sex),
        age = Value(age),
        heightCm = Value(heightCm),
        weightKg = Value(weightKg),
        activityLevel = Value(activityLevel),
        goal = Value(goal),
        dailyCalorieGoal = Value(dailyCalorieGoal),
        proteinGoal = Value(proteinGoal),
        carbsGoal = Value(carbsGoal),
        fatGoal = Value(fatGoal);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? sex,
    Expression<int>? age,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? activityLevel,
    Expression<String>? goal,
    Expression<int>? dailyCalorieGoal,
    Expression<int>? proteinGoal,
    Expression<int>? carbsGoal,
    Expression<int>? fatGoal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (age != null) 'age': age,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (goal != null) 'goal': goal,
      if (dailyCalorieGoal != null) 'daily_calorie_goal': dailyCalorieGoal,
      if (proteinGoal != null) 'protein_goal': proteinGoal,
      if (carbsGoal != null) 'carbs_goal': carbsGoal,
      if (fatGoal != null) 'fat_goal': fatGoal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? sex,
      Value<int>? age,
      Value<double>? heightCm,
      Value<double>? weightKg,
      Value<String>? activityLevel,
      Value<String>? goal,
      Value<int>? dailyCalorieGoal,
      Value<int>? proteinGoal,
      Value<int>? carbsGoal,
      Value<int>? fatGoal,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      carbsGoal: carbsGoal ?? this.carbsGoal,
      fatGoal: fatGoal ?? this.fatGoal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (sex.present) map['sex'] = Variable<String>(sex.value);
    if (age.present) map['age'] = Variable<int>(age.value);
    if (heightCm.present) map['height_cm'] = Variable<double>(heightCm.value);
    if (weightKg.present) map['weight_kg'] = Variable<double>(weightKg.value);
    if (activityLevel.present)
      map['activity_level'] = Variable<String>(activityLevel.value);
    if (goal.present) map['goal'] = Variable<String>(goal.value);
    if (dailyCalorieGoal.present)
      map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal.value);
    if (proteinGoal.present)
      map['protein_goal'] = Variable<int>(proteinGoal.value);
    if (carbsGoal.present) map['carbs_goal'] = Variable<int>(carbsGoal.value);
    if (fatGoal.present) map['fat_goal'] = Variable<int>(fatGoal.value);
    if (createdAt.present)
      map['created_at'] = Variable<DateTime>(createdAt.value);
    if (updatedAt.present)
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('proteinGoal: $proteinGoal, ')
          ..write('carbsGoal: $carbsGoal, ')
          ..write('fatGoal: $fatGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _kcalPer100gMeta =
      const VerificationMeta('kcalPer100g');
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
      'kcal_per100g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinPer100gMeta =
      const VerificationMeta('proteinPer100g');
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
      'protein_per100g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsPer100gMeta =
      const VerificationMeta('carbsPer100g');
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
      'carbs_per100g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatPer100gMeta =
      const VerificationMeta('fatPer100g');
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
      'fat_per100g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
        SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
        SqlDialect.postgres: '',
      }),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUsedMeta =
      const VerificationMeta('lastUsed');
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
      'last_used', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        brand,
        barcode,
        kcalPer100g,
        proteinPer100g,
        carbsPer100g,
        fatPer100g,
        source,
        isFavorite,
        lastUsed,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
          _kcalPer100gMeta,
          kcalPer100g.isAcceptableOrUnknown(
              data['kcal_per100g']!, _kcalPer100gMeta));
    } else if (isInserting) {
      context.missing(_kcalPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
          _proteinPer100gMeta,
          proteinPer100g.isAcceptableOrUnknown(
              data['protein_per100g']!, _proteinPer100gMeta));
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
          _carbsPer100gMeta,
          carbsPer100g.isAcceptableOrUnknown(
              data['carbs_per100g']!, _carbsPer100gMeta));
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
          _fatPer100gMeta,
          fatPer100g.isAcceptableOrUnknown(
              data['fat_per100g']!, _fatPer100gMeta));
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('last_used')) {
      context.handle(_lastUsedMeta,
          lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _createdAtMeta,
          createdAt.isAcceptableOrUnknown(
              data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      kcalPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kcal_per100g'])!,
      proteinPer100g: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}protein_per100g'])!,
      carbsPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_per100g'])!,
      fatPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_per100g'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      lastUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String name;
  final String? brand;
  final String? barcode;
  final double kcalPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final String source;
  final bool isFavorite;
  final DateTime? lastUsed;
  final DateTime createdAt;
  const Food(
      {required this.id,
      required this.name,
      this.brand,
      this.barcode,
      required this.kcalPer100g,
      required this.proteinPer100g,
      required this.carbsPer100g,
      required this.fatPer100g,
      required this.source,
      required this.isFavorite,
      this.lastUsed,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['source'] = Variable<String>(source);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      name: Value(name),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      kcalPer100g: Value(kcalPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      source: Value(source),
      isFavorite: Value(isFavorite),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
      createdAt: Value(createdAt),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      source: serializer.fromJson<String>(json['source']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  factory Food.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Food.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'barcode': serializer.toJson<String?>(barcode),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'source': serializer.toJson<String>(source),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Food copyWith(
          {int? id,
          String? name,
          Value<String?> brand = const Value.absent(),
          Value<String?> barcode = const Value.absent(),
          double? kcalPer100g,
          double? proteinPer100g,
          double? carbsPer100g,
          double? fatPer100g,
          String? source,
          bool? isFavorite,
          Value<DateTime?> lastUsed = const Value.absent(),
          DateTime? createdAt}) =>
      Food(
        id: id ?? this.id,
        name: name ?? this.name,
        brand: brand.present ? brand.value : this.brand,
        barcode: barcode.present ? barcode.value : this.barcode,
        kcalPer100g: kcalPer100g ?? this.kcalPer100g,
        proteinPer100g: proteinPer100g ?? this.proteinPer100g,
        carbsPer100g: carbsPer100g ?? this.carbsPer100g,
        fatPer100g: fatPer100g ?? this.fatPer100g,
        source: source ?? this.source,
        isFavorite: isFavorite ?? this.isFavorite,
        lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
        createdAt: createdAt ?? this.createdAt,
      );
  Food copyWithCompanion(FoodsCompanion data) {
    return Food(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      kcalPer100g:
          data.kcalPer100g.present ? data.kcalPer100g.value : this.kcalPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g:
          data.fatPer100g.present ? data.fatPer100g.value : this.fatPer100g,
      source: data.source.present ? data.source.value : this.source,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      createdAt:
          data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('source: $source, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, brand, barcode, kcalPer100g,
      proteinPer100g, carbsPer100g, fatPer100g, source, isFavorite, lastUsed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.id == this.id &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.barcode == this.barcode &&
          other.kcalPer100g == this.kcalPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.source == this.source &&
          other.isFavorite == this.isFavorite &&
          other.lastUsed == this.lastUsed &&
          other.createdAt == this.createdAt);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String?> barcode;
  final Value<double> kcalPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  final Value<String> source;
  final Value<bool> isFavorite;
  final Value<DateTime?> lastUsed;
  final Value<DateTime> createdAt;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.source = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    required double kcalPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    required String source,
    this.isFavorite = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        kcalPer100g = Value(kcalPer100g),
        proteinPer100g = Value(proteinPer100g),
        carbsPer100g = Value(carbsPer100g),
        fatPer100g = Value(fatPer100g),
        source = Value(source);
  static Insertable<Food> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? barcode,
    Expression<double>? kcalPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
    Expression<String>? source,
    Expression<bool>? isFavorite,
    Expression<DateTime>? lastUsed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (source != null) 'source': source,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (lastUsed != null) 'last_used': lastUsed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? brand,
      Value<String?>? barcode,
      Value<double>? kcalPer100g,
      Value<double>? proteinPer100g,
      Value<double>? carbsPer100g,
      Value<double>? fatPer100g,
      Value<String>? source,
      Value<bool>? isFavorite,
      Value<DateTime?>? lastUsed,
      Value<DateTime>? createdAt}) {
    return FoodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      source: source ?? this.source,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUsed: lastUsed ?? this.lastUsed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (name.present) map['name'] = Variable<String>(name.value);
    if (brand.present) map['brand'] = Variable<String>(brand.value);
    if (barcode.present) map['barcode'] = Variable<String>(barcode.value);
    if (kcalPer100g.present)
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    if (proteinPer100g.present)
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    if (carbsPer100g.present)
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    if (fatPer100g.present)
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    if (source.present) map['source'] = Variable<String>(source.value);
    if (isFavorite.present)
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    if (lastUsed.present) map['last_used'] = Variable<DateTime>(lastUsed.value);
    if (createdAt.present)
      map['created_at'] = Variable<DateTime>(createdAt.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('source: $source, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MealEntriesTable extends MealEntries
    with TableInfo<$MealEntriesTable, MealEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta =
      const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES foods (id) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
      'meal_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityGMeta =
      const VerificationMeta('quantityG');
  @override
  late final GeneratedColumn<double> quantityG = GeneratedColumn<double>(
      'quantity_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, foodId, date, mealType, quantityG, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MealEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(_mealTypeMeta,
          mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta));
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('quantity_g')) {
      context.handle(
          _quantityGMeta,
          quantityG.isAcceptableOrUnknown(
              data['quantity_g']!, _quantityGMeta));
    } else if (isInserting) {
      context.missing(_quantityGMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _createdAtMeta,
          createdAt.isAcceptableOrUnknown(
              data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      mealType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_type'])!,
      quantityG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity_g'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MealEntriesTable createAlias(String alias) {
    return $MealEntriesTable(attachedDatabase, alias);
  }
}

class MealEntry extends DataClass implements Insertable<MealEntry> {
  final int id;
  final int foodId;
  final DateTime date;
  final String mealType;
  final double quantityG;
  final DateTime createdAt;
  const MealEntry(
      {required this.id,
      required this.foodId,
      required this.date,
      required this.mealType,
      required this.quantityG,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_id'] = Variable<int>(foodId);
    map['date'] = Variable<DateTime>(date);
    map['meal_type'] = Variable<String>(mealType);
    map['quantity_g'] = Variable<double>(quantityG);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MealEntriesCompanion toCompanion(bool nullToAbsent) {
    return MealEntriesCompanion(
      id: Value(id),
      foodId: Value(foodId),
      date: Value(date),
      mealType: Value(mealType),
      quantityG: Value(quantityG),
      createdAt: Value(createdAt),
    );
  }

  factory MealEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealEntry(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<int>(json['foodId']),
      date: serializer.fromJson<DateTime>(json['date']),
      mealType: serializer.fromJson<String>(json['mealType']),
      quantityG: serializer.fromJson<double>(json['quantityG']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  factory MealEntry.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      MealEntry.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<int>(foodId),
      'date': serializer.toJson<DateTime>(date),
      'mealType': serializer.toJson<String>(mealType),
      'quantityG': serializer.toJson<double>(quantityG),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MealEntry copyWith(
          {int? id,
          int? foodId,
          DateTime? date,
          String? mealType,
          double? quantityG,
          DateTime? createdAt}) =>
      MealEntry(
        id: id ?? this.id,
        foodId: foodId ?? this.foodId,
        date: date ?? this.date,
        mealType: mealType ?? this.mealType,
        quantityG: quantityG ?? this.quantityG,
        createdAt: createdAt ?? this.createdAt,
      );
  MealEntry copyWithCompanion(MealEntriesCompanion data) {
    return MealEntry(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      date: data.date.present ? data.date.value : this.date,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      quantityG:
          data.quantityG.present ? data.quantityG.value : this.quantityG,
      createdAt:
          data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealEntry(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('quantityG: $quantityG, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, foodId, date, mealType, quantityG, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealEntry &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.date == this.date &&
          other.mealType == this.mealType &&
          other.quantityG == this.quantityG &&
          other.createdAt == this.createdAt);
}

class MealEntriesCompanion extends UpdateCompanion<MealEntry> {
  final Value<int> id;
  final Value<int> foodId;
  final Value<DateTime> date;
  final Value<String> mealType;
  final Value<double> quantityG;
  final Value<DateTime> createdAt;
  const MealEntriesCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.date = const Value.absent(),
    this.mealType = const Value.absent(),
    this.quantityG = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MealEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int foodId,
    required DateTime date,
    required String mealType,
    required double quantityG,
    this.createdAt = const Value.absent(),
  })  : foodId = Value(foodId),
        date = Value(date),
        mealType = Value(mealType),
        quantityG = Value(quantityG);
  static Insertable<MealEntry> custom({
    Expression<int>? id,
    Expression<int>? foodId,
    Expression<DateTime>? date,
    Expression<String>? mealType,
    Expression<double>? quantityG,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (date != null) 'date': date,
      if (mealType != null) 'meal_type': mealType,
      if (quantityG != null) 'quantity_g': quantityG,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MealEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? foodId,
      Value<DateTime>? date,
      Value<String>? mealType,
      Value<double>? quantityG,
      Value<DateTime>? createdAt}) {
    return MealEntriesCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      quantityG: quantityG ?? this.quantityG,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (foodId.present) map['food_id'] = Variable<int>(foodId.value);
    if (date.present) map['date'] = Variable<DateTime>(date.value);
    if (mealType.present) map['meal_type'] = Variable<String>(mealType.value);
    if (quantityG.present)
      map['quantity_g'] = Variable<double>(quantityG.value);
    if (createdAt.present)
      map['created_at'] = Variable<DateTime>(createdAt.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealEntriesCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('date: $date, ')
          ..write('mealType: $mealType, ')
          ..write('quantityG: $quantityG, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeightEntriesTable extends WeightEntries
    with TableInfo<$WeightEntriesTable, WeightEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, weightKg, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WeightEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $WeightEntriesTable createAlias(String alias) {
    return $WeightEntriesTable(attachedDatabase, alias);
  }
}

class WeightEntry extends DataClass implements Insertable<WeightEntry> {
  final int id;
  final DateTime date;
  final double weightKg;
  final String? note;
  const WeightEntry(
      {required this.id,
      required this.date,
      required this.weightKg,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WeightEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: Value(weightKg),
      note:
          note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WeightEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  factory WeightEntry.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      WeightEntry.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
    };
  }

  WeightEntry copyWith(
          {int? id,
          DateTime? date,
          double? weightKg,
          Value<String?> note = const Value.absent()}) =>
      WeightEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        weightKg: weightKg ?? this.weightKg,
        note: note.present ? note.value : this.note,
      );
  WeightEntry copyWithCompanion(WeightEntriesCompanion data) {
    return WeightEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.note == this.note);
}

class WeightEntriesCompanion extends UpdateCompanion<WeightEntry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> weightKg;
  final Value<String?> note;
  const WeightEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
  });
  WeightEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required double weightKg,
    this.note = const Value.absent(),
  })  : date = Value(date),
        weightKg = Value(weightKg);
  static Insertable<WeightEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weightKg,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
    });
  }

  WeightEntriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<double>? weightKg,
      Value<String?>? note}) {
    return WeightEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (date.present) map['date'] = Variable<DateTime>(date.value);
    if (weightKg.present) map['weight_kg'] = Variable<double>(weightKg.value);
    if (note.present) map['note'] = Variable<String>(note.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $MealEntriesTable mealEntries = $MealEntriesTable(this);
  late final $WeightEntriesTable weightEntries = $WeightEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, foods, mealEntries, weightEntries];
}

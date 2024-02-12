// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SampleItem extends _SampleItem
    with RealmEntity, RealmObjectBase, RealmObject {
  SampleItem(
    int id,
  ) {
    RealmObjectBase.set(this, 'id', id);
  }

  SampleItem._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  Stream<RealmObjectChanges<SampleItem>> get changes =>
      RealmObjectBase.getChanges<SampleItem>(this);

  @override
  SampleItem freeze() => RealmObjectBase.freezeObject<SampleItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SampleItem._);
    return const SchemaObject(
        ObjectType.realmObject, SampleItem, 'SampleItem', [
      SchemaProperty('id', RealmPropertyType.int),
    ]);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistence_state_adapter.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPersistenceStateAdapterCollection on Isar {
  IsarCollection<PersistenceStateAdapter> get persistenceStateAdapters =>
      this.collection();
}

const PersistenceStateAdapterSchema = CollectionSchema(
  name: r'PersistenceStateAdapter',
  id: 7780932079689709656,
  properties: {
    r'lastPersistenceTime': PropertySchema(
      id: 0,
      name: r'lastPersistenceTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _persistenceStateAdapterEstimateSize,
  serialize: _persistenceStateAdapterSerialize,
  deserialize: _persistenceStateAdapterDeserialize,
  deserializeProp: _persistenceStateAdapterDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _persistenceStateAdapterGetId,
  getLinks: _persistenceStateAdapterGetLinks,
  attach: _persistenceStateAdapterAttach,
  version: '3.1.0+1',
);

int _persistenceStateAdapterEstimateSize(
  PersistenceStateAdapter object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _persistenceStateAdapterSerialize(
  PersistenceStateAdapter object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastPersistenceTime);
}

PersistenceStateAdapter _persistenceStateAdapterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PersistenceStateAdapter(
    id: id,
    lastPersistenceTime: reader.readDateTime(offsets[0]),
  );
  return object;
}

P _persistenceStateAdapterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _persistenceStateAdapterGetId(PersistenceStateAdapter object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _persistenceStateAdapterGetLinks(
    PersistenceStateAdapter object) {
  return [];
}

void _persistenceStateAdapterAttach(
    IsarCollection<dynamic> col, Id id, PersistenceStateAdapter object) {}

extension PersistenceStateAdapterQueryWhereSort
    on QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QWhere> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PersistenceStateAdapterQueryWhere on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QWhereClause> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PersistenceStateAdapterQueryFilter on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QFilterCondition> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> lastPersistenceTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPersistenceTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> lastPersistenceTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPersistenceTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> lastPersistenceTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPersistenceTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter,
      QAfterFilterCondition> lastPersistenceTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPersistenceTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PersistenceStateAdapterQueryObject on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QFilterCondition> {}

extension PersistenceStateAdapterQueryLinks on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QFilterCondition> {}

extension PersistenceStateAdapterQuerySortBy
    on QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QSortBy> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      sortByLastPersistenceTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPersistenceTime', Sort.asc);
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      sortByLastPersistenceTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPersistenceTime', Sort.desc);
    });
  }
}

extension PersistenceStateAdapterQuerySortThenBy on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QSortThenBy> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      thenByLastPersistenceTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPersistenceTime', Sort.asc);
    });
  }

  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QAfterSortBy>
      thenByLastPersistenceTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPersistenceTime', Sort.desc);
    });
  }
}

extension PersistenceStateAdapterQueryWhereDistinct on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QDistinct> {
  QueryBuilder<PersistenceStateAdapter, PersistenceStateAdapter, QDistinct>
      distinctByLastPersistenceTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPersistenceTime');
    });
  }
}

extension PersistenceStateAdapterQueryProperty on QueryBuilder<
    PersistenceStateAdapter, PersistenceStateAdapter, QQueryProperty> {
  QueryBuilder<PersistenceStateAdapter, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PersistenceStateAdapter, DateTime, QQueryOperations>
      lastPersistenceTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPersistenceTime');
    });
  }
}

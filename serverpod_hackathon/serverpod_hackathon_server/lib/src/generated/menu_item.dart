/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class MenuItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MenuItem._({
    this.id,
    required this.restaurantName,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.cuisine,
    bool? isVegetarian,
    bool? isHalal,
    int? spicyLevel,
    this.allergens,
    this.tags,
    this.imageUrl,
    this.embedding,
  }) : isVegetarian = isVegetarian ?? false,
       isHalal = isHalal ?? false,
       spicyLevel = spicyLevel ?? 0;

  factory MenuItem({
    int? id,
    required String restaurantName,
    required String name,
    required String description,
    required double price,
    required String category,
    required String cuisine,
    bool? isVegetarian,
    bool? isHalal,
    int? spicyLevel,
    String? allergens,
    String? tags,
    String? imageUrl,
    String? embedding,
  }) = _MenuItemImpl;

  factory MenuItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuItem(
      id: jsonSerialization['id'] as int?,
      restaurantName: jsonSerialization['restaurantName'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      category: jsonSerialization['category'] as String,
      cuisine: jsonSerialization['cuisine'] as String,
      isVegetarian: jsonSerialization['isVegetarian'] as bool,
      isHalal: jsonSerialization['isHalal'] as bool,
      spicyLevel: jsonSerialization['spicyLevel'] as int,
      allergens: jsonSerialization['allergens'] as String?,
      tags: jsonSerialization['tags'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      embedding: jsonSerialization['embedding'] as String?,
    );
  }

  static final t = MenuItemTable();

  static const db = MenuItemRepository._();

  @override
  int? id;

  String restaurantName;

  String name;

  String description;

  double price;

  String category;

  String cuisine;

  bool isVegetarian;

  bool isHalal;

  int spicyLevel;

  String? allergens;

  String? tags;

  String? imageUrl;

  String? embedding;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItem copyWith({
    int? id,
    String? restaurantName,
    String? name,
    String? description,
    double? price,
    String? category,
    String? cuisine,
    bool? isVegetarian,
    bool? isHalal,
    int? spicyLevel,
    String? allergens,
    String? tags,
    String? imageUrl,
    String? embedding,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItem',
      if (id != null) 'id': id,
      'restaurantName': restaurantName,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'cuisine': cuisine,
      'isVegetarian': isVegetarian,
      'isHalal': isHalal,
      'spicyLevel': spicyLevel,
      if (allergens != null) 'allergens': allergens,
      if (tags != null) 'tags': tags,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (embedding != null) 'embedding': embedding,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuItem',
      if (id != null) 'id': id,
      'restaurantName': restaurantName,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'cuisine': cuisine,
      'isVegetarian': isVegetarian,
      'isHalal': isHalal,
      'spicyLevel': spicyLevel,
      if (allergens != null) 'allergens': allergens,
      if (tags != null) 'tags': tags,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (embedding != null) 'embedding': embedding,
    };
  }

  static MenuItemInclude include() {
    return MenuItemInclude._();
  }

  static MenuItemIncludeList includeList({
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    MenuItemInclude? include,
  }) {
    return MenuItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MenuItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuItemImpl extends MenuItem {
  _MenuItemImpl({
    int? id,
    required String restaurantName,
    required String name,
    required String description,
    required double price,
    required String category,
    required String cuisine,
    bool? isVegetarian,
    bool? isHalal,
    int? spicyLevel,
    String? allergens,
    String? tags,
    String? imageUrl,
    String? embedding,
  }) : super._(
         id: id,
         restaurantName: restaurantName,
         name: name,
         description: description,
         price: price,
         category: category,
         cuisine: cuisine,
         isVegetarian: isVegetarian,
         isHalal: isHalal,
         spicyLevel: spicyLevel,
         allergens: allergens,
         tags: tags,
         imageUrl: imageUrl,
         embedding: embedding,
       );

  /// Returns a shallow copy of this [MenuItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItem copyWith({
    Object? id = _Undefined,
    String? restaurantName,
    String? name,
    String? description,
    double? price,
    String? category,
    String? cuisine,
    bool? isVegetarian,
    bool? isHalal,
    int? spicyLevel,
    Object? allergens = _Undefined,
    Object? tags = _Undefined,
    Object? imageUrl = _Undefined,
    Object? embedding = _Undefined,
  }) {
    return MenuItem(
      id: id is int? ? id : this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isHalal: isHalal ?? this.isHalal,
      spicyLevel: spicyLevel ?? this.spicyLevel,
      allergens: allergens is String? ? allergens : this.allergens,
      tags: tags is String? ? tags : this.tags,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      embedding: embedding is String? ? embedding : this.embedding,
    );
  }
}

class MenuItemUpdateTable extends _i1.UpdateTable<MenuItemTable> {
  MenuItemUpdateTable(super.table);

  _i1.ColumnValue<String, String> restaurantName(String value) =>
      _i1.ColumnValue(
        table.restaurantName,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> price(double value) => _i1.ColumnValue(
    table.price,
    value,
  );

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<String, String> cuisine(String value) => _i1.ColumnValue(
    table.cuisine,
    value,
  );

  _i1.ColumnValue<bool, bool> isVegetarian(bool value) => _i1.ColumnValue(
    table.isVegetarian,
    value,
  );

  _i1.ColumnValue<bool, bool> isHalal(bool value) => _i1.ColumnValue(
    table.isHalal,
    value,
  );

  _i1.ColumnValue<int, int> spicyLevel(int value) => _i1.ColumnValue(
    table.spicyLevel,
    value,
  );

  _i1.ColumnValue<String, String> allergens(String? value) => _i1.ColumnValue(
    table.allergens,
    value,
  );

  _i1.ColumnValue<String, String> tags(String? value) => _i1.ColumnValue(
    table.tags,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> embedding(String? value) => _i1.ColumnValue(
    table.embedding,
    value,
  );
}

class MenuItemTable extends _i1.Table<int?> {
  MenuItemTable({super.tableRelation}) : super(tableName: 'menu_item') {
    updateTable = MenuItemUpdateTable(this);
    restaurantName = _i1.ColumnString(
      'restaurantName',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    price = _i1.ColumnDouble(
      'price',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    cuisine = _i1.ColumnString(
      'cuisine',
      this,
    );
    isVegetarian = _i1.ColumnBool(
      'isVegetarian',
      this,
      hasDefault: true,
    );
    isHalal = _i1.ColumnBool(
      'isHalal',
      this,
      hasDefault: true,
    );
    spicyLevel = _i1.ColumnInt(
      'spicyLevel',
      this,
      hasDefault: true,
    );
    allergens = _i1.ColumnString(
      'allergens',
      this,
    );
    tags = _i1.ColumnString(
      'tags',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    embedding = _i1.ColumnString(
      'embedding',
      this,
    );
  }

  late final MenuItemUpdateTable updateTable;

  late final _i1.ColumnString restaurantName;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble price;

  late final _i1.ColumnString category;

  late final _i1.ColumnString cuisine;

  late final _i1.ColumnBool isVegetarian;

  late final _i1.ColumnBool isHalal;

  late final _i1.ColumnInt spicyLevel;

  late final _i1.ColumnString allergens;

  late final _i1.ColumnString tags;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString embedding;

  @override
  List<_i1.Column> get columns => [
    id,
    restaurantName,
    name,
    description,
    price,
    category,
    cuisine,
    isVegetarian,
    isHalal,
    spicyLevel,
    allergens,
    tags,
    imageUrl,
    embedding,
  ];
}

class MenuItemInclude extends _i1.IncludeObject {
  MenuItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MenuItem.t;
}

class MenuItemIncludeList extends _i1.IncludeList {
  MenuItemIncludeList._({
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MenuItem.t;
}

class MenuItemRepository {
  const MenuItemRepository._();

  /// Returns a list of [MenuItem]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<MenuItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MenuItem>(
      where: where?.call(MenuItem.t),
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MenuItem] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<MenuItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MenuItem>(
      where: where?.call(MenuItem.t),
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MenuItem] by its [id] or null if no such row exists.
  Future<MenuItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MenuItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MenuItem]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MenuItem>> insert(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MenuItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MenuItem] and returns the inserted row.
  ///
  /// The returned [MenuItem] will have its `id` field set.
  Future<MenuItem> insertRow(
    _i1.Session session,
    MenuItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MenuItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MenuItem>> update(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.ColumnSelections<MenuItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MenuItem>(
      rows,
      columns: columns?.call(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuItem> updateRow(
    _i1.Session session,
    MenuItem row, {
    _i1.ColumnSelections<MenuItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuItem>(
      row,
      columns: columns?.call(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MenuItem?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MenuItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MenuItem>(
      id,
      columnValues: columnValues(MenuItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MenuItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MenuItem>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MenuItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MenuItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemTable>? orderBy,
    _i1.OrderByListBuilder<MenuItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MenuItem>(
      columnValues: columnValues(MenuItem.t.updateTable),
      where: where(MenuItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItem.t),
      orderByList: orderByList?.call(MenuItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MenuItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MenuItem>> delete(
    _i1.Session session,
    List<MenuItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MenuItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MenuItem].
  Future<MenuItem> deleteRow(
    _i1.Session session,
    MenuItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MenuItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MenuItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MenuItem>(
      where: where(MenuItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MenuItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MenuItem>(
      where: where?.call(MenuItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class MenuItem implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

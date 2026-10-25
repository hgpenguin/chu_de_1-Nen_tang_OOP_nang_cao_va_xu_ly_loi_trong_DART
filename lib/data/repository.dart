import 'dart:convert';

import '../core/app_exception.dart';
import '../core/mixins.dart';
import '../models/product.dart';

/// Kho dữ liệu dùng chung cho mọi kiểu T là Entity.
class Repository<T extends Entity> with Loggable {
  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, T> _items = {};

  Repository(this.fromJson);

  @override
  String get logTag => 'Repository<$T>';

  List<T> get all => List.unmodifiable(_items.values);

  /// Nạp cả mảng JSON. Chỉ lưu khi mọi phần tử đều hợp lệ.
  List<T> loadAll(String jsonText) {
    final data = jsonDecode(jsonText); // có thể ném FormatException
    if (data is! List) throw const ParseException('root', 'Cần mảng JSON');
    final items = [for (final e in data) fromJson(e as Map<String, dynamic>)];
    for (final item in items) {
      _items[item.id] = item;
      log('Đã thêm ${item.id}');
    }
    return items;
  }

  T findById(String id) => _items[id] ?? (throw NotFoundException(id));
}

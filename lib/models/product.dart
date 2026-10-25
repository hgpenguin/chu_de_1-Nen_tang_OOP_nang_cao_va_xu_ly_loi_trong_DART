import '../core/app_exception.dart';
import '../core/mixins.dart';

/// Mọi bản ghi lưu trong Repository đều có id.
abstract class Entity {
  String get id;
}

/// Đọc một trường trong JSON và kiểm tra kiểu bằng generic.
T readField<T>(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is T) return value;
  throw ParseException(key, 'Cần kiểu $T nhưng nhận ${value.runtimeType}');
}

class Product extends Entity with Validatable {
  @override
  final String id;
  final String name;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.stock = 0,
  });

  /// Factory constructor: chuyển Map/JSON thành đối tượng đã kiểm tra.
  factory Product.fromJson(Map<String, dynamic> json) {
    final product = Product(
      id: readField<String>(json, 'id'),
      name: readField<String>(json, 'name').trim(),
      price: readField<num>(json, 'price').toDouble(),
      stock: readField<int?>(json, 'stock') ?? 0,
    );
    product.ensureValid(); // từ mixin Validatable
    return product;
  }

  @override
  List<String> validate() => [
        if (name.isEmpty) 'tên không được để trống',
        if (price < 0) 'giá phải >= 0',
        if (stock < 0) 'tồn kho phải >= 0',
      ];
}

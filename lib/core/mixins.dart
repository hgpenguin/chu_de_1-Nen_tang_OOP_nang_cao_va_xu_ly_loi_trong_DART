import 'app_exception.dart';

/// Gắn khả năng in log cho bất kỳ lớp nào mà không cần kế thừa.
mixin Loggable {
  String get logTag => runtimeType.toString();

  void log(String message) => print('[$logTag] $message');
}

/// Lớp dùng mixin tự khai báo luật trong validate();
/// mixin cung cấp sẵn isValid và ensureValid().
mixin Validatable {
  List<String> validate();

  bool get isValid => validate().isEmpty;

  void ensureValid() {
    final errors = validate();
    if (errors.isNotEmpty) throw ValidationException(errors);
  }
}

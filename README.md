# Demo Chủ đề 01 – OOP nâng cao & Xử lý lỗi trong Dart

| File | Nội dung |
|---|---|
| `lib/models/product.dart` | Factory `Product.fromJson`, generic `readField<T>` |
| `lib/core/mixins.dart` | Mixin `Loggable` (in log), `Validatable` (kiểm tra hợp lệ) |
| `lib/data/repository.dart` | `Repository<T extends Entity>` dùng chung cho mọi model |
| `lib/core/app_exception.dart` | Custom exception (sealed) có `userMessage` thân thiện |
| `lib/core/guard.dart` | Hàm bao bọc `guard<T>()` gom lỗi tập trung, trả về `Result<T>` |
| `lib/core/error_center.dart` | Singleton: factory `ErrorCenter()` + named constructor `_internal`, lưu lịch sử lỗi |
| `lib/main.dart` | Giao diện Flutter: dòng báo lỗi màu đỏ, app không crash |

```bash
flutter pub get
dart run bin/console_demo.dart   # bản console
flutter run -d macos             # hoặc chrome / windows
```

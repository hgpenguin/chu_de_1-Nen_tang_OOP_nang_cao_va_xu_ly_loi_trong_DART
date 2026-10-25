# BÁO CÁO CHUYÊN ĐỀ DART & FLUTTER
## CHỦ ĐỀ 01: Lập trình Hướng đối tượng nâng cao (OOP) & Design Patterns trong Dart kết hợp Xử lý ngoại lệ tập trung

* **Trường**: Đại học Bách Khoa – Đại học Đà Nẵng
* **Khoa**: Điện tử – Viễn thông
* **Môn học**: Lập trình đa nền tảng
* **Giảng viên hướng dẫn**: TS. Nguyễn Duy Nhật Viễn

---

## 👥 THÀNH VIÊN NHÓM & BẢNG PHÂN CÔNG CÔNG VIỆC (WBS)

| STT | Họ và Tên | Mã sinh viên | Vai trò & Nhiệm vụ phụ trách | Tỷ lệ đóng góp |
| :---: | :--- | :---: | :--- | :---: |
| **1** | **Nguyễn Thái Hoàng** | 106230011 | • Nghiên cứu lý thuyết Named & Factory constructor, Mixins, Generics.<br>• Xây dựng Model `Product` (`Product.fromJson`, `readField<T>`).<br>• Cài đặt Mixins `Loggable`, `Validatable` và Generic `Repository<T>`. | **50%** |
| **2** | **Lê Trương Uyển Nhi** | 106230054 | • Nghiên cứu lý thuyết `try-catch-finally`, Custom Exception, User Message.<br>• Định nghĩa cây ngoại lệ `AppException`, hàm bao bọc `guard<T>()`, Singleton `ErrorCenter`.<br>• Thiết kế giao diện Flutter (`main.dart`), xử lý lỗi toàn cục và tổng hợp Slide. | **50%** |

---

## 🎯 MỤC TIÊU & YÊU CẦU ĐỀ TÀI

Dự án hiện thực hóa trọn vẹn các yêu cầu kỹ thuật của **Chủ đề 01**:
1. **OOP nâng cao**: Áp dụng Named constructor, Factory constructor (`Product.fromJson`), Mixins (`Loggable`, `Validatable`) và Generics (`Repository<T extends Entity>`, `readField<T>`).
2. **Xử lý ngoại lệ nâng cao**: Cấu trúc `try-catch-finally`, định nghĩa lỗi tùy biến (`sealed class AppException`), tách biệt thông báo kỹ thuật và thông báo thân thiện cho người dùng (`userMessage`).
3. **Kiến trúc phân tầng (Clean Architecture & Patterns)**: Tách biệt rõ ràng giữa Presentation Layer, Domain Layer và Data Layer; áp dụng Repository Pattern & Factory Pattern.
4. **Cơ chế gom lỗi tập trung (Centralized Error Pipeline)**: Hàm bao bọc wrapper `guard<T>()` bắt mọi lỗi ở ranh giới thao tác và lưu lịch sử vào Singleton `ErrorCenter`, bảo đảm **ứng dụng không bao giờ bị dừng đột ngột (crash)**.

---

## 📂 CẤU TRÚC MÃ NGUỒN

```text
lib/
├── core/
│   ├── app_exception.dart   # Cây ngoại lệ tùy biến (ParseException, ValidationException, NotFoundException)
│   ├── error_center.dart    # Singleton gom và lưu vết lịch sử lỗi ứng dụng
│   ├── guard.dart           # Hàm bao bọc guard<T>() bọc try-catch-finally, trả về Result<T>
│   ├── mixins.dart          # Mixin Loggable (tự động in log) và Validatable (kiểm tra tính hợp lệ)
│   └── result.dart          # Sealed class Result<T> (Success mang dữ liệu, Failure mang thông báo lỗi)
├── data/
│   └── repository.dart      # Generic Repository<T extends Entity> with Loggable (nạp Map/JSON, lưu trữ)
├── models/
│   └── product.dart         # Entity Product with Validatable, Factory constructor Product.fromJson, readField<T>
├── demo_data.dart           # 4 bộ dữ liệu thử nghiệm (Hợp lệ, Sai cú pháp, Sai kiểu, Vi phạm luật)
└── main.dart                # Giao diện Flutter kiểm thử trực quan với lưới an toàn toàn cục
bin/
└── console_demo.dart        # Bản demo chạy độc lập trên Terminal/Console
```

---

## 🚀 HƯỚNG DẪN CÀI ĐẶT & CHẠY ỨNG DỤNG

### 1. Cài đặt các gói phụ thuộc
```bash
flutter pub get
```

### 2. Chế độ 1: Chạy nhanh bản Console (Terminal)
Chạy trực tiếp bằng Dart SDK (mất 1 giây, kiểm chứng toàn bộ luồng logic & xử lý lỗi):
```bash
dart bin/console_demo.dart
```

### 3. Chế độ 2: Chạy bản Giao diện đồ họa Flutter (Flutter UI)
Tạo tệp runner nền tảng (nếu chưa có) và khởi chạy:
```bash
# Khởi tạo runner Windows & Web
flutter create . --platforms=windows,web

# Chạy dạng cửa sổ Windows Desktop
flutter run -d windows

# Hoặc chạy trên trình duyệt Web Chrome
flutter run -d chrome
```

---

## 🧪 KỊCH BẢN KIỂM THỬ TRỰC TIẾP (TEST CASES)

Khi chạy ứng dụng, bạn có thể kiểm chứng 4 tình huống dữ liệu thông qua 4 nút bấm trên màn hình:

| Nút bấm | Dữ liệu đầu vào | Kết quả kỳ vọng trên UI | Bản chất kỹ thuật kiểm chứng |
| :--- | :--- | :--- | :--- |
| **Hợp lệ** | Mảng JSON chuẩn 2 sản phẩm | Tải thành công 2 sản phẩm (Bàn phím, Chuột), hiển thị danh sách lên ListView | `Product.fromJson` parse Map, `Validatable` xác nhận hợp lệ, `Repository` lưu và vẽ UI. |
| **Sai cú pháp** | Chuỗi JSON thiếu cú pháp `[{"id":"p3","name": }]` | Banner đỏ: *"Tệp dữ liệu bị lỗi định dạng JSON."* | `jsonDecode` ném `FormatException` $\rightarrow$ `guard` bắt và chuyển thành `Failure`. |
| **Sai kiểu** | Giá là chuỗi `"price": "300k"` | Banner đỏ: *"Dữ liệu không đúng định dạng (trường "price")."* | `readField<num>` phát hiện sai kiểu $\rightarrow$ ném `ParseException` chỉ rõ tên trường. |
| **Vi phạm luật** | Tên rỗng `""`, giá âm `-5` | Banner đỏ: *"Thông tin chưa hợp lệ: tên không được để trống, giá phải >= 0."* | `ensureValid()` gọi `validate()` $\rightarrow$ gom tất cả vi phạm ném qua `ValidationException`. |

> **Cơ chế chống Crash (No-Crash Guarantee)**: Sau khi bấm thử các nút lỗi, danh sách sản phẩm hợp lệ đã tải trước đó vẫn được bảo toàn nguyên vẹn trên màn hình. Người dùng có thể bấm lại nút `"Hợp lệ"` bất cứ lúc nào để tiếp tục sử dụng mà không cần khởi động lại ứng dụng.
---

## 📚 TÀI LIỆU THAM KHẢO & HỌC LIỆU

1. **Học liệu môn học**:
   * Bài giảng môn Lập trình đa nền tảng:
     - *Chương 2*: Nền tảng ngôn ngữ Dart, Generics và Kỹ thuật xử lý lỗi.
     - *Chương 3*: Lập trình hướng đối tượng nâng cao (OOP), Constructor, Mixins, Singleton.
     - *Chương 4*: Bất đồng bộ với Future & Stream (tham khảo cho cơ chế async guard).

2. **Tài liệu kỹ thuật chính thức từ Dart & Flutter**:
   * [Dart Constructors Specification](https://dart.dev/language/constructors) (Named & Factory constructors).
   * [Dart Mixins Guide](https://dart.dev/language/mixins) (Tái sử dụng tính năng không qua kế thừa).
   * [Dart Generics & Type System](https://dart.dev/language/generics) (Generic classes, functions & constraints).
   * [Dart Exceptions & Error Handling](https://dart.dev/language/error-handling) (try-on-catch-finally).
   * [Flutter Error Handling Guide](https://docs.flutter.dev/testing/errors) (FlutterError, PlatformDispatcher).
   * [Flutter App Architecture Guide](https://docs.flutter.dev/app-architecture/guide) (Repository Pattern, Domain Layer).

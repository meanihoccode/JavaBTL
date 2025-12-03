# BÁO CÁO HOÀN THIỆN CHỨC NĂNG ĐĂNG KÝ TÀI KHOẢN

## I. Tóm tắt công việc đã thực hiện

### 1. **Cơ sở dữ liệu (Database)**
- ✅ Thêm role `GUEST` (Khách) vào bảng `role`
- Roles hiện có:
  - `MANAGER`: Quản trị hệ thống (full access)
  - `STAFF`: Nhân viên (quản lý tòa nhà)
  - `GUEST`: Khách (chỉ xem và tìm kiếm tòa nhà)

### 2. **Backend - Model & DTO**
- ✅ Tạo `RegisterDTO.java` với validation:
  - `userName`: 3-50 ký tự, bắt buộc
  - `fullName`: 3-100 ký tự, bắt buộc
  - `email`: hợp lệ, bắt buộc
  - `password`: tối thiểu 6 ký tự, bắt buộc
  - `confirmPassword`: bắt buộc, phải khớp với password

### 3. **Backend - Repository**
- ✅ Thêm method `findByEmail()` vào `UserRepository` để check email tồn tại

### 4. **Backend - Service**
- ✅ Thêm method `register()` vào `IUserService` interface
- ✅ Implement method `register()` trong `UserService`:
  - Validate password khớp
  - Check username tồn tại
  - Check email tồn tại
  - Tạo user mới với role `GUEST` mặc định
  - Status = 1 (active)

### 5. **Backend - API**
- ✅ Tạo `RegisterAPI.java` endpoint `/api/auth/register`:
  - Method: POST
  - Nhận RegisterDTO
  - Validate dữ liệu
  - Trả về ResponseDTO với thông báo thành công/lỗi

### 6. **Backend - Controller**
- ✅ Tạo `RegisterController.java`:
  - Route GET `/register` → hiển thị trang đăng ký
  - Trả về view `register.jsp`

### 7. **Frontend - Trang đăng ký riêng**
- ✅ Tạo `register.jsp`:
  - Form: Họ và tên, Tên đăng nhập, Email, Mật khẩu, Xác nhận mật khẩu
  - Checkbox đồng ý điều khoản
  - Button Đăng ký
  - Link quay lại login
  - Hiển thị lỗi validation dưới mỗi field

### 8. **Frontend - Cập nhật Login page**
- ✅ Sửa link "Sign Up" ở login.jsp:
  - Trỏ tới `/register` thay vì `#!`
  - Dễ dàng để user chuyển từ login sang register

### 9. **Frontend - JavaScript**
- ✅ Thêm AJAX script xử lý form submit trong register.jsp:
  - Gửi dữ liệu POST đến `/api/auth/register`
  - Xử lý kết quả (success/error)
  - Hiển thị lỗi chi tiết cho mỗi field
  - Redirect đến login khi đăng ký thành công

### 10. **Backend - Security Configuration**
- ✅ Cập nhật `WebSecurityConfig.java`:
  - GUEST được phép truy cập `/san-pham` (xem tòa nhà)
  - GUEST được phép truy cập `/api/buildings/**` (search)
  - GUEST, STAFF, MANAGER đều có quyền xem tòa nhà
  - `/register` cho phép tất cả (permitAll)
  - `/api/auth/**` cho phép tất cả (permitAll)

---

## II. Quy trình đăng ký

### Cách 1: Từ trang Login
1. Truy cập `/login`
2. Click "Sign Up" ở cuối form login
3. Redirect tới `/register`

### Cách 2: Truy cập trực tiếp
1. Truy cập `/register`

### Quy trình đăng ký
1. **Điền form**: Nhập Họ tên, Username, Email, Password, Confirm Password
2. **Submit**: Click nút "Đăng ký"
3. **Validation**:
   - Frontend validate trước khi gửi
   - Backend validate lần nữa
4. **Kết quả**:
   - ✅ Thành công: Alert "Đăng ký thành công!" + Redirect tới `/login`
   - ❌ Lỗi: Hiển thị lỗi chi tiết dưới field tương ứng

---

## III. Quyền hạn GUEST

- ✅ Xem danh sách tòa nhà công khai
- ✅ Tìm kiếm tòa nhà theo quận/huyện
- ✅ Xem chi tiết tòa nhà
- ❌ Không được phép đăng tòa nhà
- ❌ Không được quản lý tòa nhà
- ❌ Không được truy cập admin panel

---

## IV. Cơ sở dữ liệu - Cần chạy

```sql
-- Cập nhật file: database/insert_database.sql
-- Những dòng sau được thêm vào:
insert into role(code,name) values('GUEST','Khách');
```

Chạy script này để cập nhật database nếu bạn đã có database cũ.

---

## V. File thay đổi / Tạo mới

### Tạo mới:
1. **DTO**: `src/main/java/com/javaweb/model/dto/RegisterDTO.java`
2. **Controller**: `src/main/java/com/javaweb/controller/web/RegisterController.java`
3. **API**: `src/main/java/com/javaweb/api/web/RegisterAPI.java`
4. **View**: `src/main/webapp/WEB-INF/views/register.jsp`

### Chỉnh sửa:
1. **Database**: `database/insert_database.sql`
2. **Service**: 
   - `src/main/java/com/javaweb/service/IUserService.java`
   - `src/main/java/com/javaweb/service/impl/UserService.java`
3. **Repository**: `src/main/java/com/javaweb/repository/UserRepository.java`
4. **Config**: `src/main/java/com/javaweb/config/WebSecurityConfig.java`
5. **View**: 
   - `src/main/webapp/WEB-INF/views/login.jsp` (cập nhật link Sign Up)
   - `src/main/webapp/WEB-INF/views/web/home.jsp` (xóa form register cũ)

---

## VI. Test chức năng

### Test case 1: Đăng ký thành công
```
Flow:
1. Click "Sign Up" ở login page hoặc truy cập /register
2. Nhập:
   - Full Name: Nguyễn Văn A
   - Username: nguyenvana123
   - Email: nguyenvana@email.com
   - Password: 123456
   - Confirm Password: 123456
3. Click "Đăng ký"

Expected: 
- Hiển thị alert "Đăng ký thành công!"
- Redirect tới /login
- Tài khoản mới được tạo với role GUEST
```

### Test case 2: Password không khớp
```
Input:
- Password: 123456
- Confirm Password: 654321

Expected: 
- Hiển thị lỗi "Mật khẩu xác nhận không khớp"
```

### Test case 3: Username tồn tại
```
Input:
- Username: admin (tồn tại trong DB)

Expected: 
- Hiển thị lỗi "Tên đăng nhập đã tồn tại"
```

### Test case 4: Email không hợp lệ
```
Input:
- Email: invalid-email

Expected: 
- Hiển thị lỗi "Email không hợp lệ"
```

### Test case 5: Đăng nhập với tài khoản mới
```
Flow:
1. Đăng ký tài khoản mới thành công
2. Redirect tới /login
3. Nhập username/password của tài khoản mới

Expected:
- Đăng nhập thành công
- Redirect tới trang chủ (với role GUEST)
- User chỉ có quyền xem/tìm kiếm tòa nhà
```

---

## VII. Lưu ý quan trọng

1. **Database**: Cần cập nhật GUEST role trước khi chạy project
2. **URL**:
   - Login: `/login`
   - Register: `/register`
   - API Register: `/api/auth/register` (POST)
3. **Email validation**: Sử dụng `@Email` annotation của Spring Validation
4. **Password encoding**: Sử dụng BCryptPasswordEncoder (cấu hình sẵn)
5. **Default role**: Tài khoản mới được gán role GUEST (status = 1)
6. **AJAX**: Sử dụng jQuery (đã include trong register.jsp)
7. **Redirect**: Sau khi đăng ký thành công sẽ redirect tới `/login`

---

## VIII. URL và Flow

```
User Flow:
1. /login (có link Sign Up)
   ↓
2. Click "Sign Up" → /register
   ↓
3. Form đăng ký
   ↓
4. Submit → POST /api/auth/register
   ↓
5a. Thành công → Redirect /login
5b. Lỗi → Hiển thị lỗi ở form

User Flow Alternate:
1. Direct access /register
   ↓
2. Form đăng ký
   ↓
3. Same as above...
```

---

## IX. Tiếp theo (Optional)

Để hoàn thiện hơn nữa, có thể thêm:
- [ ] Email verification
- [ ] CAPTCHA trên form register
- [ ] Rate limiting
- [ ] Password strength indicator
- [ ] Terms of service agreement page
- [ ] Social login (Google, Facebook)
- [ ] Auto-login sau khi đăng ký
- [ ] Remember me checkbox



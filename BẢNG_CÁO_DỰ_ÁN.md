# BÁO CÁO DỰ ÁN: QUẢN LÝ CHO THUÊ BẤT ĐỘNG SẢN

## 1. TỔNG QUAN DỰ ÁN

### 1.1 Tên dự án
**Real Estate Management System** - Hệ thống quản lý cho thuê bất động sản

### 1.2 Công nghệ sử dụng
- **Backend Framework**: Spring Boot 2.0.9.RELEASE
- **Build Tool**: Maven
- **Database**: MySQL 8.0.13
- **ORM**: Hibernate (JPA)
- **Security**: Spring Security
- **Frontend**: JSP (JavaServer Pages)
- **Template Engine**: SiteMesh 2.4.2
- **Java Version**: 1.8
- **Packaging**: WAR (Web Application Archive)

### 1.3 Cấu trúc dự án
```
Real-rental-estate-management/
├── pom.xml                          # Maven configuration
├── database/
│   └── insert_database.sql         # Dữ liệu khởi tạo
├── src/main/
│   ├── java/com/javaweb/
│   │   ├── api/                    # REST API
│   │   ├── controller/             # Spring Controllers (MVC)
│   │   ├── entity/                 # JPA Entities
│   │   ├── model/                  # DTOs, Requests, Responses
│   │   ├── service/                # Business Logic
│   │   ├── repository/             # Data Access Layer
│   │   ├── builder/                # Builder pattern
│   │   ├── converter/              # DTO converters
│   │   ├── security/               # Security configuration
│   │   ├── config/                 # Spring configurations
│   │   ├── constant/               # Constants
│   │   ├── exception/              # Exception handling
│   │   ├── enums/                  # Enumerations
│   │   └── utils/                  # Utility classes
│   ├── resources/
│   │   ├── application.properties  # Configuration
│   │   └── static/                 # Static files (CSS, JS, images)
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── decorators.xml      # SiteMesh decorators
│       │   ├── web.xml             # Web configuration
│       │   └── views/              # JSP files
│       └── index.jsp
└── target/                         # Compiled output
```

---

## 2. KIẾN TRÚC HỆ THỐNG

### 2.1 Mô hình lớp (Layered Architecture)

```
┌─────────────────────────┐
│   JSP Views / HTML      │  ← Presentation Layer
├─────────────────────────┤
│   Controllers (MVC)     │  ← Controller Layer
│   APIs (REST)           │
├─────────────────────────┤
│   Services              │  ← Business Logic Layer
├─────────────────────────┤
│   Repositories (DAO)    │  ← Data Access Layer
├─────────────────────────┤
│   Entities              │  ← Entity/Model Layer
├─────────────────────────┤
│   MySQL Database        │  ← Database Layer
└─────────────────────────┘
```

### 2.2 DTOs vs Entities - Sự khác biệt

| Tiêu chí | Entity | DTO |
|---------|--------|-----|
| **Mục đích** | Đại diện dữ liệu trong database | Đại diện dữ liệu giao tiếp với client |
| **Annotation** | @Entity, @Table, @Column | Không có JPA annotation |
| **Liên kết** | Có relationships (@OneToMany, @ManyToMany) | Thường chỉ có các field đơn giản |
| **Validation** | Không validation | Có validation (@NotBlank, @NotNull, @Min) |
| **Mối quan hệ** | Có lazy/eager loading | Không có lazy loading issues |
| **Dùng khi** | Làm việc với database | Gửi/nhận từ client |
| **Ví dụ** | `BuildingEntity` (chứa dữ liệu thực tế trong DB) | `BuildingDTO` (dữ liệu gửi từ client) |

**Lý do có cả 2:**
- **Entity**: JPA cần nó để map với table trong database
- **DTO**: Để không lộ cấu trúc database, validate input, và tránh lazy loading errors

### 2.3 Controllers vs APIs - Sự khác biệt

| Tiêu chí | Controller (MVC) | API (REST) |
|---------|-----------------|-----------|
| **Annotation** | @Controller | @RestController |
| **Return Type** | ModelAndView, String (tên view) | JSON (@ResponseBody) |
| **URL Pattern** | `/admin/building-list` | `/api/buildings` |
| **Request** | Form submission (POST, GET) | AJAX/HTTP requests |
| **Response** | JSP/HTML page | JSON data |
| **Binding** | @ModelAttribute (Form objects) | @RequestBody (JSON) |
| **Use Case** | Render web pages | Mobile app, frontend framework |

**Ví dụ:**
- **Controller**: `BuildingController.buildingList()` → trả về view `admin/building/list.jsp`
- **API**: `BuildingAPI.createOrUpdateBuilding()` → trả về JSON response

---

## 3. CÁC THÀNH PHẦN CHÍNH

### 3.1 Entities (Model dữ liệu)

#### **BuildingEntity** - Tòa nhà
```java
Properties chính:
- id: Long (PK)
- name: String
- street, ward, district: String (địa chỉ)
- numberOfBasement, floorArea: Integer (thông tin kỹ thuật)
- rentPrice, serviceFee, carFee, motoFee, waterFee, electricityFee: Integer
- managerName, managerPhone: String
- structure, direction, level: String
- deposit, payment: Integer
```

#### **UserEntity** - Người dùng/Nhân viên
```java
Properties chính:
- id: Long (PK)
- userName: String (unique)
- fullName: String
- password: String (encrypted)
- status: Integer (1=active, 0=inactive)
- email: String (unique)
- roles: List<RoleEntity> (ManyToMany relationship)
- buildings: List<BuildingEntity> (gán tòa nhà cho nhân viên)
```

#### **RoleEntity** - Vai trò
```java
Properties chính:
- id: Long (PK)
- code: String (MANAGER, USER)
- name: String (Quản trị hệ thống, Người dùng)
```

#### **RentAreaEntity** - Diện tích thuê
```java
Lưu thông tin diện tích thuê của từng tòa nhà
```

### 3.2 DTOs (Data Transfer Objects)

| DTO | Mục đích |
|-----|----------|
| **BuildingDTO** | Truyền dữ liệu tòa nhà từ/đến client, có validation |
| **UserDTO** | Truyền dữ liệu người dùng, không để lộ password |
| **RoleDTO** | Truyền dữ liệu vai trò |
| **AssignmentBuildingDTO** | Gán tòa nhà cho nhân viên |
| **MyUserDetail** | Custom user details cho Spring Security |

### 3.3 Controllers

#### **BuildingController** (`admin/building`)
```
GET  /admin/building-list      → Hiển thị danh sách tòa nhà
GET  /admin/building-edit      → Form thêm/sửa tòa nhà
POST /admin/building-update    → Xử lý lưu dữ liệu
```

#### **UserController** (`admin/user`)
```
GET  /admin/user-list          → Danh sách người dùng
GET  /admin/user-edit          → Form thêm/sửa người dùng
```

#### **HomeController**
```
GET  /admin/                   → Trang chủ admin
```

### 3.4 REST APIs

#### **BuildingAPI** (`/api/buildings`)
```java
POST   /api/buildings                   → Tạo/cập nhật tòa nhà (JSON)
DELETE /api/buildings/{ids}             → Xóa tòa nhà
GET    /api/buildings/{id}              → Lấy danh sách nhân viên gán cho tòa nhà
PUT    /api/buildings                   → Gán tòa nhà cho nhân viên
```

#### **UserAPI** (`/api/users`)
```
Xử lý các API liên quan đến người dùng
```

### 3.5 Services (Business Logic)

#### **BuildingService**
```java
Interface methods:
- Page<BuildingSearchResponse> findAll(BuildingSearchRequest, Pageable)
  → Tìm tòa nhà có phân trang
  → Được gọi từ Controller
  
- int countTotalItem(BuildingSearchRequest)
  → Đếm tổng số tòa nhà khớp điều kiện
  
- void createOrUpdateBuilding(BuildingDTO)
  → Thêm mới hoặc cập nhật tòa nhà
  → Được gọi từ API
  
- BuildingDTO findById(Long id)
  → Tìm 1 tòa nhà theo ID
  
- void deleteByIdIn(List<Long> ids)
  → Xóa nhiều tòa nhà
  
- void createAssignmentBuilding(AssignmentBuildingDTO)
  → Gán tòa nhà cho nhân viên
```

#### **UserService**
```java
Methods:
- UserDTO findOneByUserNameAndStatus(String username, int status)
  → Tìm user để login
  
- List<UserDTO> listStaff()
  → Danh sách nhân viên
  
- List<StaffResponseDTO> listStaffResponse(Long buildingId)
  → Danh sách nhân viên có gán tòa nhà
```

### 3.6 Repositories (Data Access)

#### **BuildingRepository**
- Custom query methods để tìm kiếm tòa nhà
- Sử dụng Specification pattern

#### **UserRepository**
```java
- findByUserName(String username)
- findByUserNameAndStatus(String username, int status)
```

#### **RoleRepository**
- Lấy danh sách roles

---

## 4. LUỒNG DỮ LIỆU (Data Flow)

### 4.1 Luồng tìm kiếm tòa nhà

```
1. Client gửi request:
   GET /admin/building-list?name=xxx&district=yyy

2. BuildingController.buildingList()
   - Nhận BuildingSearchRequest từ @ModelAttribute
   - Tạo Pageable

3. Gọi BuildingService.findAll(request, pageable)
   (Service chứa business logic)

4. Service gọi BuildingRepository.findAll()
   (Repository gọi database)

5. Trả kết quả về: Page<BuildingSearchResponse>

6. BuildingController đưa vào ModelAndView
   - modelAndView.addObject("response", response)

7. JSP render dữ liệu:
   - Hiển thị danh sách tòa nhà
   - Hiển thị phân trang
```

**Tại sao phải đi qua Service?**
- Service chứa business logic (tính toán, validate, transform)
- Service có thể được reuse bởi API khác
- Dễ test unit test

### 4.2 Luồng tạo mới tòa nhà

```
1. Client gửi JSON request:
   POST /api/buildings
   {
     "name": "Tòa nhà A",
     "district": "Q1",
     "rentPrice": 100000
   }

2. BuildingAPI.createOrUpdateBuilding()
   - @Valid @RequestBody BuildingDTO buildingDTO
   - Validate theo @NotBlank, @NotNull...
   - Nếu error → trả ResponseDTO with error messages

3. Gọi BuildingService.createOrUpdateBuilding(buildingDTO)

4. Service xử lý:
   - Validate thêm (business rules)
   - Convert DTO → Entity
   - Save vào database

5. Trả ResponseDTO:
   {
     "message": "Success",
     "data": {...}
   }
```

---

## 5. SECURITY & AUTHENTICATION

### 5.1 Password Hashing
```
Database: 
admin password = $2a$10$/RUbuT9KIqk6f8enaTQiLOXzhnUkiwEJRdtzdrMXXwU7dgnLKTCYG
(Sử dụng BCrypt encryption)

Plain password (khi tạo tài khoản): 1234
(Password này được hash bằng BCrypt)
```

### 5.2 Tài khoản admin mặc định
```
Username: admin
Password: 1234 (đã hash)
Role: MANAGER (Quản trị hệ thống)
```

### 5.3 CustomUserDetailService
```
Spring Security khi login:
1. LoadUserByUsername(username) được gọi
2. Tìm UserDTO từ database
3. Build GrantedAuthority từ User roles
4. Return MyUserDetail (UserDetails implementation)
```

---

## 6. DATABASE SCHEMA

### 6.1 Các bảng chính

```sql
-- Người dùng
Table: user
- id (PK)
- username (UNIQUE)
- password (BCrypt encrypted)
- fullname
- status (1=active)
- email (UNIQUE)

-- Vai trò
Table: role
- id (PK)
- code (MANAGER, USER)
- name

-- Gán vai trò cho người dùng
Table: user_role
- user_id (FK)
- role_id (FK)

-- Tòa nhà
Table: building
- id (PK)
- name
- street, ward, district
- floorarea, structure, direction, level
- rentprice, servicefee, carfee, motofee, waterfee, electricityfee
- deposit, payment
- managername, managerphone
- brokeragefee

-- Gán tòa nhà cho nhân viên
Table: assignmentbuilding
- staffid (FK → user.id)
- buildingid (FK → building.id)

-- Diện tích thuê
Table: rentarea
- buildingid (FK)
- value (diện tích)
```

### 6.2 Dữ liệu khởi tạo

```
Roles:
- MANAGER (admin)
- USER (nhân viên)

Users:
- admin / password=1234 / role=MANAGER
- nguyenvana / password=1234 / role=USER
- nguyenvanb / password=1234 / role=USER
```

---

## 7. RESPONSE & REQUEST MODELS

### 7.1 Request Models
```
BuildingSearchRequest:
- name, street, district, ward: String
- numberOfBasement, floorArea: Integer
- rentPriceFrom, rentPriceTo: Integer
- page, limit: Integer
- sortBy, sortDirection: String
```

### 7.2 Response Models
```
BuildingSearchResponse:
- id, name, street, district, ward
- numberOfBasement, floorArea
- rentPrice, serviceFee, carFee
- listResult: List<BuildingSearchResponse>
- totalItems: Integer

ResponseDTO:
- message: String (Success/Failed)
- data: Object (trả dữ liệu)
- details: List<String> (error messages)

StaffResponseDTO:
- staffId, staffName
- checked: Boolean (đã gán tòa nhà?)
```

---

## 8. CONFIGURATION

### 8.1 Server Properties
```properties
server.port=8082
```

### 8.2 Database Configuration
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/estateadvance
spring.datasource.username=root
spring.datasource.password=1234

spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true
```

### 8.3 View Configuration
```properties
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
```

---

## 9. NHỮNG CÂU HỎI CẦN HIỂU

### **Q1: Mật khẩu admin là gì?**
**A:** Mật khẩu plain text: `1234`
- Trong database được lưu dưới dạng hash BCrypt: `$2a$10$/RUbuT9KIqk6f8enaTQiLOXzhnUkiwEJRdtzdrMXXwU7dgnLKTCYG`
- Spring Security sẽ tự so sánh khi user login

### **Q2: Sự khác nhau giữa BuildingController và BuildingAPI?**

| Controller | API |
|-----------|-----|
| Trả về JSP page | Trả về JSON |
| URL: `/admin/building-list` | URL: `/api/buildings` |
| Dùng cho web browser | Dùng cho AJAX/mobile |
| @ModelAttribute (form) | @RequestBody (JSON) |
| Render HTML | Trả object JSON |
| GET /list, GET /edit, POST /update | POST, GET, DELETE, PUT |

**Ví dụ cụ thể:**
```
Controller: /admin/building-list?page=1
→ Trả về trang HTML có danh sách tòa nhà

API: POST /api/buildings
{
  "name": "Tòa A",
  "rentPrice": 1000000
}
→ Trả về JSON response: {"message": "Success"}
```

### **Q3: Khi tìm kiếm tòa nhà, nó chạy vào Service như thế nào?**

```
Request: GET /admin/building-list?name=xxx

1. Spring Router → BuildingController.buildingList(BuildingSearchRequest params)

2. params tự động được filled từ query string (name=xxx)

3. DisplayTagUtils.of(request, params) - handle pagination

4. Gọi: buildingService.findAll(params, pageable)
   (Service là một instance được inject bởi @Autowired)

5. Service chứa logic:
   - Validate params
   - Build SQL query
   - Call repository để query database
   - Transform Entity → Response DTOs
   - Return Page<BuildingSearchResponse>

6. Controller nhận Page, đưa vào ModelAndView

7. JSP render trang web
```

**Tại sao phải có Service?**
- Tách biệt logic business từ controller
- Dễ test (mock service)
- Reuse code (API cũng gọi service này)

### **Q4: Khi tạo mới tòa nhà thì sao?**

```
Khi nhấn "Thêm mới":

1. Form gửi AJAX request:
   POST /api/buildings
   {
     "name": "Tòa mới",
     "district": "Q1",
     "rentPrice": 5000000,
     ...
   }

2. BuildingAPI.createOrUpdateBuilding(@Valid BuildingDTO dto)
   - Spring validate @NotBlank, @Min, @NotNull
   - Nếu error → trả lỗi validation
   - Nếu ok → gọi buildingService.createOrUpdateBuilding(dto)

3. Service xử lý:
   - Validate thêm (business rules)
   - Convert DTO thành BuildingEntity
   - Save entity vào database
   - Return

4. API trả ResponseDTO:
   {
     "message": "Success"
   }

5. JavaScript nhận response, reload trang hoặc update list
```

### **Q5: Những chỗ bắt buộc/validation ở đâu?**

**Trong BuildingDTO có @NotBlank/@NotNull:**
```java
@NotBlank(message = "Tên tòa nhà không được để trống")
private String name;

@NotBlank(message = "Bạn chưa chọn quận")
private String district;

@NotBlank(message = "Tên phường không được để trống")
private String ward;

@NotBlank(message = "Tên đường không được để trống")
private String street;

@NotBlank(message = "Diện tích thuê không được để trống")
private String rentArea;

@NotNull(message = "Phải chọn ít nhất 1 loại tòa nhà")
private List<String> typeCode;

@Min(value = 0, message = "Giá thuê phải là số dương")
private Integer rentPrice;
```

**Để sửa validation:**
- Mở file: `BuildingDTO.java`
- Tìm @NotBlank, @NotNull, @Min annotations
- Thay đổi message hoặc thêm rule mới

### **Q6: Sao lại cần cả DTO và Entity? 2 cái này khác ở đâu?**

**Entity - Dùng cho Database:**
```java
@Entity
@Table(name = "building")
public class BuildingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "name")
    private String name;
    
    // JPA relationships
    @ManyToMany
    @JoinTable(...)
    private List<UserEntity> assignedStaffs;
}
```

**DTO - Dùng giao tiếp với client:**
```java
public class BuildingDTO extends AbstractDTO {
    private Long id;
    
    @NotBlank(message = "Tên không được để trống")
    private String name;
    
    // Validation annotations
    @Min(value = 0)
    private Integer rentPrice;
    
    // Simple types, không có relationships
    private List<String> typeCode; // không phải entities
}
```

**Lý do phải tách 2:**
1. **Database vs API**: Entity là structure DB, DTO là contract với client
2. **Validation**: DTO có @NotBlank, Entity không cần
3. **Lazy Loading**: Entity có @OneToMany gây lỗi lazy loading, DTO không có
4. **Security**: Không lộ cấu trúc internal (example: password)
5. **Flexibility**: Client không cần biết những fields internal
6. **Reuse**: API khác nhau có thể dùng cùng Entity nhưng DTOs khác

**Ví dụ cụ thể:**
```
Database BuildingEntity có:
- id, name, rentPrice, managedByUser, assignedStaffs, rentAreas

Client chỉ cần:
- id, name, rentPrice, rentArea (danh sách diện tích)

Tạo BuildingDTO chỉ có những field cần thiết
→ Tiết kiệm bandwidth
→ An toàn dữ liệu
→ Dễ validate
```

---

## 10. SPRING SECURITY FLOW

```
1. User login với username/password

2. Spring Security gọi CustomUserDetailService.loadUserByUsername(username)

3. Service:
   - Tìm UserDTO từ database theo username
   - Lấy list roles từ UserDTO
   - Build GrantedAuthority từ role codes
   - Return MyUserDetail object

4. Spring Security so sánh password (plain text vs hash)

5. Nếu match:
   - Tạo Authentication object
   - Lưu vào SecurityContext
   - Redirect đến trang được yêu cầu

6. Khi user request resource:
   - Spring check SecurityContext
   - So sánh user roles với @PreAuthorize("hasRole('MANAGER')")
   - Cho phép/chặn request
```

---

## 11. FLOW CHI TIẾT: TÌM KIẾM + HIỂN THỊ DANH SÁCH

```
Browser: GET /admin/building-list?name=&district=Q1&page=1

↓

Spring DispatcherServlet nhận request

↓

Dispatch tới: BuildingController.buildingList(
    HttpServletRequest request,
    @ModelAttribute("modelSearch") BuildingSearchRequest params
)

↓ (params.name, params.district, params.page tự động fill)

Code thực thi:
1. DisplayTagUtils.of(request, params) - xử lý pagination
2. int page = Math.max(params.getPage() - 1, 0) = 0
3. Pageable pageable = PageRequest.of(0, 20) - trang 1, 20 items
4. Page<BuildingSearchResponse> responsePage = 
     buildingService.findAll(params, pageable)

↓ (Gọi Service)

BuildingService.findAll() trong Impl:
1. Validate BuildingSearchRequest
2. Build Specification từ params
3. Gọi repository.findAll(spec, pageable)

↓ (Gọi Repository)

BuildingRepository.findAll(Specification, Pageable)
- Tạo SQL query từ specification
- Execute SELECT ... FROM building WHERE ...
- Return Page của BuildingEntity

↓ (Database)

MySQL trả kết quả

↓ (Quay lại Service)

Service convert List<BuildingEntity> → List<BuildingSearchResponse>
(Transform Entity thành DTO)

↓ (Quay lại Controller)

Controller thêm vào ModelAndView:
- modelAndView.addObject("response", response)
- modelAndView.addObject("district", districtCode.type())
- modelAndView.addObject("rentType", buildingType.type())
- modelAndView.addObject("staffList", staffList)
- modelAndView.setViewName("admin/building/list")

↓

Spring ViewResolver tìm file: /WEB-INF/views/admin/building/list.jsp

↓

JSP Engine render page:
- Iterate response.listResult
- Display từng building row
- Render pagination buttons

↓

Return HTML tới browser

↓

Browser render page
```

---

## 12. ENDPOINTS CHÍNH

### Web (MVC)
```
GET  /admin/                      → Trang chủ admin
GET  /admin/building-list         → Danh sách tòa nhà
GET  /admin/building-edit         → Form thêm/sửa tòa nhà
POST /admin/building-update       → Cập nhật tòa nhà
GET  /admin/user-list             → Danh sách người dùng
GET  /admin/user-edit             → Form thêm/sửa người dùng
```

### API (REST)
```
POST   /api/buildings              → Tạo/cập nhật tòa nhà
GET    /api/buildings/{id}         → Lấy nhân viên của tòa nhà
DELETE /api/buildings/{ids}        → Xóa tòa nhà
PUT    /api/buildings              → Gán tòa nhà cho nhân viên
POST   /api/users                  → Tạo/cập nhật người dùng
GET    /api/users/{id}             → Lấy thông tin người dùng
```

---

## 13. CÔNG NGHỆ & DEPENDENCIES

| Dependency | Phiên bản | Mục đích |
|-----------|----------|---------|
| Spring Boot Starter Web | 2.0.9 | Web framework |
| Spring Boot Starter Data JPA | 2.0.9 | ORM (Hibernate) |
| Spring Boot Starter Security | 2.0.9 | Authentication/Authorization |
| MySQL Connector | 8.0.13 | Database driver |
| Hibernate | 5.2.18 | JPA implementation |
| SiteMesh | 2.4.2 | Page decorator/template |
| DisplayTag | 1.2 | Pagination library |
| ModelMapper | 0.7.4 | DTO ↔ Entity mapping |
| Commons Lang | 2.6 | Utility functions |
| Log4j | 1.2.17 | Logging |

---

## 14. NHỮNG ĐIỂM CẦN CHÚ Ý

### 14.1 Lazy Loading
```java
// KHÔNG LÀM VIỆC ở API (N+1 query problem)
@OneToMany(fetch = FetchType.LAZY)
private List<BuildingEntity> buildings;

// Phải convert sang DTO trước khi trả JSON
```

### 14.2 Circular References
```java
// User → Roles ← User (Circular)
// Dùng DTO để tránh
```

### 14.3 Password Security
```
Không bao giờ trả password trong DTO
@JsonIgnore hoặc không include field
```

### 14.4 Validation
```
Luôn validate ở 2 chỗ:
1. DTO validation (@NotBlank, @Min)
2. Service validation (business rules)
```

---

## 15. CÁCH CHẠY DỰ ÁN

### 15.1 Prerequisites
- Java 1.8 hoặc cao hơn
- MySQL 8.0
- Maven

### 15.2 Setup Database
```bash
1. Tạo database: CREATE DATABASE estateadvance;
2. Chạy script: mysql -u root -p estateadvance < insert_database.sql
```

### 15.3 Build & Run
```bash
1. mvn clean install
2. mvn spring-boot:run
3. Truy cập: http://localhost:8082
4. Login: admin / 1234
```

---

## 16. SUMMARY

**Dự án này là hệ thống quản lý cho thuê bất động sản sử dụng:**
- Spring Boot 2.0 + JSP (fullstack web)
- Spring Security (authentication)
- MySQL + Hibernate JPA (database)
- Layered architecture (Controller → Service → Repository)
- REST API + MVC controllers
- DTOs + Entities (separation of concerns)

**Tính năng chính:**
✓ Quản lý tòa nhà (CRUD)
✓ Quản lý người dùng
✓ Gán tòa nhà cho nhân viên
✓ Tìm kiếm & filter tòa nhà
✓ Phân trang danh sách
✓ Authentication & Authorization
✓ Role-based access control (MANAGER, USER)

---

**Generated Report Date:** December 2, 2025
**Project Status:** Functional
**Architecture Pattern:** Layered MVC + REST API


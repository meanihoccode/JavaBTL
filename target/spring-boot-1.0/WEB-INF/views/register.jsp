<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        .gradient-custom {
            background: linear-gradient(to right, #ee7752, #e73c7e, #23a6d5, #23d5ab);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <section class="gradient-custom min-vh-100 d-flex align-items-center py-5">
            <div class="container">
                <div class="row d-flex justify-content-center align-items-center">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card text-white" style="border-radius: 1rem; background-color: #35bf76;">
                            <div class="card-body p-5">
                                <div class="mb-md-5 mt-md-4 pb-5 text-center">
                                    <h2 class="fw-bold mb-2 text-uppercase">Tạo tài khoản</h2>
                                    <p class="text-white-50 mb-4">Vui lòng nhập thông tin của bạn</p>

                                    <form id="registerForm">
                                        <div class="form-outline form-white mb-3">
                                            <label class="form-label" for="fullName">Họ và tên</label>
                                            <input type="text" id="fullName" name="fullName"
                                                   class="form-control form-control-lg" placeholder="Nhập họ và tên" />
                                            <small class="text-danger d-block" id="fullNameError"></small>
                                        </div>

                                        <div class="form-outline form-white mb-3">
                                            <label class="form-label" for="userName">Tên đăng nhập</label>
                                            <input type="text" id="userName" name="userName"
                                                   class="form-control form-control-lg" placeholder="Nhập tên đăng nhập" />
                                            <small class="text-danger d-block" id="userNameError"></small>
                                        </div>

                                        <div class="form-outline form-white mb-3">
                                            <label class="form-label" for="email">Email</label>
                                            <input type="email" id="email" name="email"
                                                   class="form-control form-control-lg" placeholder="Nhập email" />
                                            <small class="text-danger d-block" id="emailError"></small>
                                        </div>

                                        <div class="form-outline form-white mb-3">
                                            <label class="form-label" for="password">Mật khẩu</label>
                                            <input type="password" id="password" name="password"
                                                   class="form-control form-control-lg" placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)" />
                                            <small class="text-danger d-block" id="passwordError"></small>
                                        </div>

                                        <div class="form-outline form-white mb-3">
                                            <label class="form-label" for="confirmPassword">Xác nhận mật khẩu</label>
                                            <input type="password" id="confirmPassword" name="confirmPassword"
                                                   class="form-control form-control-lg" placeholder="Nhập lại mật khẩu" />
                                            <small class="text-danger d-block" id="confirmPasswordError"></small>
                                        </div>

                                        <div class="form-check d-flex justify-content-center mb-3">
                                            <input class="form-check-input me-2" type="checkbox" id="agreeTerms" />
                                            <label class="form-check-label">
                                                Tôi đồng ý với <a href="#!" class="text-body"><u style="color: white;">Điều khoản dịch vụ</u></a>
                                            </label>
                                        </div>

                                        <button class="btn btn-outline-light btn-lg px-5 w-100" type="submit" id="btnRegister">Đăng ký</button>
                                    </form>

                                    <div class="d-flex justify-content-center text-center mt-3 pt-1">
                                        <a href="#!" class="login-extension text-white"><i class="fab fa-facebook-f fa-lg"></i></a>
                                        <a href="#!" class="login-extension text-white"><i class="fab fa-twitter fa-lg mx-4 px-2"></i></a>
                                        <a href="#!" class="login-extension text-white"><i class="fab fa-google fa-lg"></i></a>
                                    </div>
                                </div>

                                <div class="text-center">
                                    <p class="mb-0">Đã có tài khoản? <a href="/login" class="text-white-50 fw-bold"><u style="color: white;">Đăng nhập</u></a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function() {
            $('#registerForm').on('submit', function(e) {
                e.preventDefault();

                // Reset error messages
                $('.text-danger').text('');

                // Collect form data
                var registerData = {
                    fullName: $('#fullName').val(),
                    userName: $('#userName').val(),
                    email: $('#email').val(),
                    password: $('#password').val(),
                    confirmPassword: $('#confirmPassword').val()
                };

                // Send AJAX request
                $.ajax({
                    url: '/api/auth/register',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(registerData),
                    success: function(response) {
                        alert('Đăng ký thành công! Vui lòng đăng nhập.');
                        window.location.href = '/login';
                    },
                    error: function(xhr) {
                        var response = xhr.responseJSON;
                        if (response && response.details) {
                            response.details.forEach(function(error) {
                                // Display error messages
                                if (error.includes('fullName') || error.includes('Họ')) {
                                    $('#fullNameError').text(error);
                                } else if (error.includes('userName') || error.includes('Tên') || error.includes('đăng nhập')) {
                                    $('#userNameError').text(error);
                                } else if (error.includes('email') || error.includes('Email')) {
                                    $('#emailError').text(error);
                                } else if (error.includes('password') || error.includes('Mật') || error.includes('khớp')) {
                                    if (error.includes('khớp')) {
                                        $('#confirmPasswordError').text(error);
                                    } else {
                                        $('#passwordError').text(error);
                                    }
                                } else {
                                    alert(error);
                                }
                            });
                        } else {
                            alert(response ? response.message : 'Đã xảy ra lỗi. Vui lòng thử lại.');
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>


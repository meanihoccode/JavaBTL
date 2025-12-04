<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 10/9/2024
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try { ace.settings.check('main-container', 'fixed') } catch (e) { }
    </script>

    <div id="sidebar" class="sidebar                  responsive">
        <script type="text/javascript">
            try { ace.settings.check('sidebar', 'fixed') } catch (e) { }
        </script>

<%--        <div class="sidebar-shortcuts" id="sidebar-shortcuts">--%>
<%--            <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">--%>
<%--                <button class="btn btn-success">--%>
<%--                    <i class="ace-icon fa fa-signal"></i>--%>
<%--                </button>--%>

<%--                <button class="btn btn-info">--%>
<%--                    <i class="ace-icon fa fa-pencil"></i>--%>
<%--                </button>--%>

<%--                <button class="btn btn-warning">--%>
<%--                    <i class="ace-icon fa fa-users"></i>--%>
<%--                </button>--%>

<%--                <button class="btn btn-danger">--%>
<%--                    <i class="ace-icon fa fa-cogs"></i>--%>
<%--                </button>--%>
<%--            </div>--%>

<%--            <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">--%>
<%--                <span class="btn btn-success"></span>--%>

<%--                <span class="btn btn-info"></span>--%>

<%--                <span class="btn btn-warning"></span>--%>

<%--                <span class="btn btn-danger"></span>--%>
<%--            </div>--%>
<%--        </div><!-- /.sidebar-shortcuts -->--%>

<%--        <ul class="nav nav-list">--%>
<%--            <li class="active">--%>
<%--                <a href="building-list.html">--%>
<%--                    <i class="menu-icon fa fa-tachometer"></i>--%>
<%--                    <span class="menu-text"> Dashboard </span>--%>
<%--                </a>--%>

<%--                <b class="arrow"></b>--%>
<%--            </li>--%>
<%--        </ul><!-- /.nav-list -->--%>

<%--        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">--%>
<%--            <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left"--%>
<%--               data-icon2="ace-icon fa fa-angle-double-right"></i>--%>
<%--        </div>--%>

<%--        <script type="text/javascript">--%>
<%--            try { ace.settings.check('sidebar', 'collapsed') } catch (e) { }--%>
<%--        </script>--%>
    </div>

    <div class="main-content" style="font-family: 'Poppins', sans-serif">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="/admin/building-list">Home</a>
                    </li>
                    <li class="active">Danh sách tòa nhà</li>
                </ul><!-- /.breadcrumb -->
            </div>

            <div class="page-content">

                <div class="page-header">
                    <h2 style="font-size: 30px;">Sửa hoặc thêm mới</h2>
                </div><!-- /.page-header -->



                <!-- BẢNG DANH SÁCH -->

                <div class="row mt-5">
                    <div class="col-xs-12">
                        <form:form class="form-horizontal" role="form" id="form-edit" method="POST" modelAttribute="buildingEdit" action="/api/buildings">
                            <div class="form-group">
                                <form:hidden path="id"/>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">
                                    <p style="text-align: end; line-height: 30px;">Tên tòa nhà: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="name" class="form-control" type="text"
                                           placeholder="Nhập tên tòa nhà ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">
                                    <p style="text-align: end; line-height: 30px;">Quận: </p>
                                </label>
                                <div class="col-xs-2">
                                    <form:select class="form-control" path="district">
                                        <form:option value="" label="---Chọn quận---"/>
                                        <form:options items="${district}"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phường: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="ward" class="form-control" type="text"
                                           placeholder="Nhập tên phường ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Đường: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="street" class="form-control" type="text"
                                           placeholder="Nhập tên đường ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Kết cấu: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="structure" class="form-control" type="text"
                                           placeholder="Nhập loại kết cấu ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Số tầng hầm: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="numberOfBasement" class="form-control"
                                           type="number" placeholder="Chọn số tầng hầm ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Diện tích sàn: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="floorArea" class="form-control" type="number"
                                           placeholder="Nhập diện tích sàn ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Hướng: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="direction" class="form-control" type="text"
                                           placeholder="Nhập hướng ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Hạng: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="level" class="form-control" type="number"
                                           placeholder="Nhập hạng ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Diện tích thuê: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="rentArea" class="form-control" type="text"
                                           placeholder="Nhập diện tích thuê ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Giá thuê: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="rentPrice" class="form-control" type="number"
                                           placeholder="Nhập giá thuê ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Mô tả giá: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="rentPriceDescription" class="form-control" type="text" placeholder="Nhập mô tả giá thuê ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phí dịch vụ: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="serviceFee" class="form-control" type="number"
                                           placeholder="Nhập phí dịch vụ ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phí ô tô: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="carFee" class="form-control" type="number"
                                           placeholder="Nhập phí ô tô ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phí mô tô: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="motoFee" class="form-control" type="number"
                                           placeholder="Nhập phí mô tô ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phí ngoài giờ: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="overtimeFee" class="form-control" type="number"
                                           placeholder="Nhập phí ngoài giờ ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Tiền nước: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="waterFee" class="form-control" type="number"
                                           placeholder="Nhập tiền nước ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Tiền điện: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="electricityFee" class="form-control"
                                           type="number" placeholder="Nhập tiền điện ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Đặt cọc: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="deposit" class="form-control" type="number"
                                           placeholder="Nhập tiền đặt cọc ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Thanh toán: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="payment" class="form-control" type="number"
                                           placeholder="Nhập số tiền thanh toán ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Thời hạn thuê: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="rentTime" class="form-control" type="date"
                                           placeholder="Chọn thời hạn thuê ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Thời gian trang trí: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="decorationTime" class="form-control"
                                           type="date" placeholder="Chọn thời gian trang trí ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Tên quản lý: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="managerName" class="form-control" type="text"
                                           placeholder="Nhập tên quản lý ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Số điện thoại quản lí: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="managerPhoneNumber" class="form-control"
                                           type="text" placeholder="Nhập số điện thoại quản lý ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3" style="">
                                    <p style="text-align: end; line-height: 30px;">Phí môi giới: </p>
                                </label>
                                <div class="col-xs-9">
                                    <form:input path="brokerageFee" class="form-control" type="number"
                                           placeholder="Nhập tên tòa nhà ...."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12 mt-3">
                                    <div class="col-xs-6 center">
                                        <form:checkboxes items="${rentType}" path="typeCode"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group" style="display: flex; justify-content: center; gap: 30px;">
                                <c:if test="${not empty buildingEdit.id}">
                                    <form:button type="submit" id="btnAddOrUpdateBuilding" class="btn btn-primary" style="border-radius: 7px;">Sửa thông tin</form:button>
                                </c:if>
                                <c:if test="${empty buildingEdit.id}">
                                    <form:button type="submit" id="btnAddOrUpdateBuilding" class="btn btn-primary" style="border-radius: 7px;">Thêm mới</form:button>
                                </c:if>
                                <a href="/admin/building-list">
                                    <button type="button" class="btn btn-warning" style="border-radius: 7px;">Hủy</button>
                                </a>
                            </div>
                        </form:form>
                    </div><!-- /.span -->
                </div>
            </div>
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->

<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>
    const arrP = document.querySelectorAll(".form-group p");
    arrP.forEach(p => {
        p.style.fontWeight = "bold";
    });

    $('#btnAddOrUpdateBuilding').click(function (e) {
        e.preventDefault(); // Ngăn chặn việc submit form mặc định

        var data = {};
        var typeCode = [];
        var formData = $('#form-edit').serializeArray();

        // Lặp qua từng trường trong form
        $.each(formData, function (i, v) {
            if (v.name !== 'typeCode') {
                if (v.value) {
                    data[v.name] = v.value;
                }
            } else {
                if (v.value) {
                    typeCode.push(v.value);
                }
            }
        });


        if (typeCode.length > 0) {
            data['typeCode'] = typeCode;
        }

        console.log(data); // Log dữ liệu JSON để kiểm tra
        addBuilding(data);
    });

    function addBuilding(data) {
        $.ajax({
            url: "/api/buildings",
            type: "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                alert("Cập nhật tòa nhà thành công!");
                window.location.href = "/admin/building-list"; // Chuyển hướng về trang building-list
            },
            error: function (xhr, status, error) {
                if (xhr.status === 400) {
                    let response = JSON.parse(xhr.responseText);
                    if (response.details && response.details.length > 0) {
                        alert(response.details[0]); // Hiển thị lỗi đầu tiên
                    } else {
                        alert(response.message); // Hiển thị thông điệp lỗi chung
                    }
                } else {
                    alert("Error: " + xhr.responseText);
                }
                console.log("Error:", xhr.responseText);
            }
        });
        console.log(JSON.stringify(data)); // Log dữ liệu JSON để kiểm tra
    }
</script>
</body>
</html>


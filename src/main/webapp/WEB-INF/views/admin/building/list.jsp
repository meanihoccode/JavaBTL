<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 10/9/2024
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <!-- font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
          href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
          rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>Title</title>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
    }
  </style>
</head>
<body>
<div class="main-content" style="font-family: 'Poppins', sans-serif">
  <div class="main-content-inner">
    <div class="breadcrumbs" id="breadcrumbs">
      <script type="text/javascript">
        try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
      </script>

      <ul class="breadcrumb">
        <li>
          <i class="ace-icon fa fa-home home-icon"></i>
          <a href="#">Home</a>
        </li>
        <li class="active">Danh sách tòa nhà</li>
      </ul><!-- /.breadcrumb -->
    </div>

    <div class="page-content">

      <div class="page-header">
        <h1>
          Danh sách tòa nhà
          <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            overview &amp; stats
          </small>
        </h1>
      </div><!-- /.page-header -->

      <!-- WIDGET -->
      <div class="row" style="margin-bottom: 50px;">
        <div class="col-xs-12">
          <div class="widget-box" style="position: relative;">
            <div class="widget-header">
              <h5 class="widget-title">Tìm kiếm</h5>

              <div class="widget-toolbar">
                <a href="#" data-action="collapse">
                  <i class="ace-icon fa fa-chevron-up"></i>
                </a>

              </div>
            </div>

            <div class="widget-body">
              <div class="widget-main">
                <div class="row">
                  <form:form modelAttribute="modelSearch" action="/admin/building-list" id="list-form" method="GET">
                    <div class="form-group">
                      <div class="col-xs-12">
                        <div class="col-xs-6">
                          <label for="">Tên tòa nhà</label>
<%--                          <input type="text" class="form-control" name="name" value="${modelSearch.name}">--%>
                          <form:input class="form-control" path="name"/>
                        </div>
                        <div class="col-xs-6">
                          <label for="">Diện tích sàn</label>
                          <form:input class="form-control" path="floorArea" type="number"/>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-3">
                        <div class="col-xs-2">
                          <label for="">Quận</label>
                          <form:select class="form-control" path="district">
                            <form:option value="" label="---Chọn quận---"/>
                            <form:options items="${district}"/>
                          </form:select>
                        </div>
                        <div class="col-xs-5">
                          <label for="">Phường</label>
                          <form:input class="form-control" path="ward"/>
                        </div>
                        <div class="col-xs-5">
                          <label for="">Đường</label>
                          <form:input class="form-control" path="street"/>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-3">
                        <div class="col-xs-4">
                          <label for="">Số tầng hầm</label>
                          <form:input class="form-control" path="numberOfBasement" type="number"/>
                        </div>
                        <div class="col-xs-4">
                          <label for="">Hướng</label>
                          <form:input class="form-control" path="direction"/>
                        </div>
                        <div class="col-xs-4">
                          <label for="">Hạng</label>
                          <form:input class="form-control" path="level" type="number"/>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-3">
                        <div class="col-xs-3">
                          <label for="">Diện tích từ</label>
                          <form:input class="form-control" path="startArea" type="number"/>
                        </div>
                        <div class="col-xs-3">
                          <label for="">Diện tích đến</label>
                          <form:input class="form-control" path="endArea" type="number"/>
                        </div>
                        <div class="col-xs-3">
                          <label for="">Giá thuê từ</label>
                          <form:input class="form-control" path="startRentPrice" type="number"/>
                        </div>
                        <div class="col-xs-3">
                          <label for="">Giá thuê đến</label>
                          <form:input class="form-control" path="endRentPrice" type="number"/>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-3">
                        <div class="col-xs-4">
                          <label for="">Tên quản lí</label>
                          <form:input class="form-control" path="managerName"/>
                        </div>
                        <div class="col-xs-4">
                          <label for="">Điện thoại quản lí</label>
                          <form:input class="form-control" path="managerPhone"/>
                        </div>
                        <div class="col-xs-2">
                          <label for="">Chọn nhân viên phụ trách</label>
                          <form:select path="staffId" class="form-control">
                            <form:option value="" label="---Chọn nhân viên---"/>
                            <form:options items="${staffList}"/>
                          </form:select>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-3">
                        <div class="col-xs-6">
                          <form:checkboxes items="${rentType}" path="typeCode" class="mr-3"/>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 mt-5">
                        <div class="col-xs-6">
                          <button type="button" class="btn btn-primary" id="btnSearchBuilding">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                 height="16" fill="currentColor" class="bi bi-search"
                                 viewBox="0 0 16 16">
                              <path
                                      d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0">
                              </path>
                            </svg>
                            Tìm kiếm
                          </button>
                        </div>
                      </div>
                    </div>
                  </form:form>
                </div>
              </div>
            </div>

            <div class="cta" style="position: absolute; right: 30px; transform: translateY(-50%);">
              <a href="/admin/building-edit">
                <button class="btn btn-info" style="border-radius: 4px;" id="btnAddBuilding">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                       fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                    <path
                            d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0" />
                    <path
                            d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                    <path
                            d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
                  </svg>
                </button>
              </a>
              <%-- Chỉ MANAGER mới thấy nút Xóa tòa nhà --%>
              <security:authorize access="hasRole('ROLE_MANAGER')">
                <button class="btn btn-danger" style="border-radius: 4px;" id="btnDeleteBuilding">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                       fill="currentColor" class="bi bi-building-dash" viewBox="0 0 16 16">
                    <path
                            d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1" />
                    <path
                            d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                    <path
                            d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
                  </svg>
                </button>
              </security:authorize>
            </div>
          </div>
        </div>
      </div>

      <!-- BẢNG DANH SÁCH -->
      <div class="row mt-5">
        <div class="col-xs-12">
          <div class="table-responsive">
            <display:table name="response.listResult" id="buildingList" class="table table-striped table-bordered table-hover"
                           requestURI="/admin/building-list" pagesize="5" export="false"
                           style="margin: 3em 0 1.5em;">
              <display:column title="" class="center">
                <label class="pos-rel">
                  <input type="checkbox" class="ace" value="${buildingList.id}"> <!-- Sử dụng ${buildingList.id} để lấy id -->
                  <span class="lbl"></span>
                </label>
              </display:column>
              <display:column property="name" title="Tên tòa nhà" class="center"/>
              <display:column property="address" title="Địa chỉ" class="center col-xs-2"/>
              <display:column property="numberOfBasement" title="Số tầng hầm" class="center"/>
              <display:column property="managerName" title="Tên quản lý" class="center"/>
              <display:column property="managerPhone" title="SĐT quản lý" class="center"/>
              <display:column property="floorArea" title="DT sàn" class="center"/>
              <display:column property="emptyArea" title="DT trống" class="center"/>
              <display:column property="rentArea" title="DT cho thuê" class="center"/>
              <display:column property="rentPrice" title="Giá thuê" class="center"/>
              <display:column property="serviceFee" title="Phí dịch vụ" class="center"/>
              <display:column property="brokerageFee" title="Phí môi giới" class="center"/>
              <display:column title="Thao tác" class="d-inline-flex">
                <div class="hidden-sm hidden-xs btn-group">
                  <%-- Chỉ MANAGER mới thấy nút Giao tòa nhà --%>
                  <security:authorize access="hasRole('ROLE_MANAGER')">
                    <button class="btn btn-xs btn-success" title="Giao tòa nhà" onclick="assignmentBuilding(${buildingList.id})">
                      <i class="ace-icon fa fa-check bigger-120"></i>
                    </button>
                  </security:authorize>
                  <a href="/admin/building-edit-${buildingList.id}">
                    <button class="btn btn-xs btn-info">
                      <i class="ace-icon fa fa-pencil bigger-120" title="Sửa tòa nhà"></i>
                    </button>
                  </a>
                  <%-- Chỉ MANAGER mới thấy nút Xóa --%>
                  <security:authorize access="hasRole('ROLE_MANAGER')">
                    <button class="btn btn-xs btn-danger btnDeleteSingleBuilding" value="${buildingList.id}">
                      <i class="ace-icon fa fa-trash-o bigger-120" title="Xóa tòa nhà"></i>
                    </button>
                  </security:authorize>
                </div>
              </display:column>
            </display:table>

          </div>
        </div>
      </div>
    </div>

    </div><!-- /.page-content -->
</div>
<div class="modal fade" id="assignmentBuildingModal" tabindex="-1" role="dialog" data-backdrop="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title center" style="font-family: 'Poppins', sans-serif;font-weight: bold; font-size: 30px; color: red;">
          Danh sách nhân viên
        </h5>
      </div>
      <div class="modal-body">
        <table class="table" id="staffList">
          <thead class=" thead-dark">
          <tr>
            <th scope="col" style="width: 30%; text-align: center;">Chọn</th>
            <th scope="col" style="width: 70%; border-left: 3px solid silver; text-align: center;">
              Tên nhân viên
            </th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td scope="row" style="text-align: center;">
              <input type="checkbox" id="" value="1">
            </td>
            <td style="width: 70%; text-align: center;">
              Phạm Thế Anh
            </td>
          </tr>
          <tr>
            <td scope="row" style="text-align: center;">
              <input type="checkbox" id="" value="1">
            </td>
            <td style="width: 70%; text-align: center;">
              Phạm Thế Anh
            </td>
          </tr>
          <tr>
            <td scope="row" style="text-align: center;">
              <input type="checkbox" id="" value="1">
            </td>
            <td style="width: 70%; text-align: center;">
              Phạm Thế Anh
            </td>
          </tr>

          </tbody>
        </table>
        <input type="hidden" id="buildingId" name="buildingId">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btnAssignmentBuilding">Giao tòa nhà</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>
<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>

  // Tìm kiếm
  $('#btnSearchBuilding').click((e) => {
    e.preventDefault(); // Ngăn chặn việc submit form mặc định

    // const form = $('#list-form')[0];
    const form = document.getElementById("list-form");

    const params = new URLSearchParams();

    // Duyệt qua tất cả các input trong form
    Array.from(form.elements).forEach(element => {
      if (element.name && element.type !== 'checkbox' && element.value) {
        params.append(element.name, element.value);
      }
      if (element.type === 'checkbox' && element.checked) {
        params.append(element.name, element.value);
      }
    });
    console.log(params);
    window.location.href = form.action + '?' + params.toString();
  });

  // Xóa 1 tòa nhà
  const deleteSingleBuilding = [...document.getElementsByClassName("btnDeleteSingleBuilding")];

  deleteSingleBuilding.forEach(button => {
    button.addEventListener("click", function (e) {
      e.preventDefault();
      const buildingId = this.getAttribute("value").toString();
      if (confirm("Bạn đã xác nhận muốn xóa?")) {
        deleteBuildings(buildingId);
      }
    });
  });

  // phân trang


  // Xóa nhiêu tòa nhà
  const btnDeleteBuilding = document.getElementById("btnDeleteBuilding");
  const buildingList = document.getElementById("buildingList");
  btnDeleteBuilding.addEventListener("click", (e) => {
    e.preventDefault();

    const checkedCheckboxes = buildingList.querySelectorAll('input[type="checkbox"]:checked');
    const ids = Array.from(checkedCheckboxes).map(checkbox => checkbox.value);
    if (ids.length > 0) {
      if (confirm("Bạn đã xác nhận muốn xóa?")) {
        deleteBuildings(ids);
      }
    } else {
      alert("Bạn chưa chọn tòa nhà cần xóa!");
    }
  });

  function deleteBuildings(ids) {
    var idString;
    if (Array.isArray(ids)) {
      idString = ids.join(',');
    } else {
      idString = ids.toString();
    }
    $.ajax({
      url: "/api/buildings/" + idString,
      type: "DELETE",
      success: function (response) {
        alert("Xóa tòa nhà thành công");
        window.location.href = "/admin/building-list";
      },
      error: function (xhr, status, error) {
        alert("Error: " + xhr.responseText);
        console.log("Error:", xhr.responseText);
      }
    });
  }

  let currentBuildingId = null;

  const assignmentBuilding = (buildingId) => {
    currentBuildingId = buildingId;
    $('#assignmentBuildingModal').modal();
    loadStaffs(buildingId);
    console.log(buildingId);
  }

  function loadStaffs(buildingId) {
    $.ajax({
      url: "/api/buildings/" + buildingId,
      type: "GET",
      dataType: "json",
      success: function (response) {
        var row = "";
        $.each(response.data, function (index, item) {
          row += "<tr>";
          row += "<td class='center'> <input type='checkbox' class='check-box-element' value='" + item.staffId + "' id='checkbox_" + item.staffId + "' " + item.checked + " /></td>";
          row += "<td style='width: 70%; text-align: center'>" + item.username + "</td>";
          row += "</tr>";
        });
        const staffList = document.querySelector(".modal-body .table tbody");
        staffList.innerHTML = row;
      }
    });
  }


  $("#btnAssignmentBuilding").click(function () {
    var selectedStaffIds = [];
    $("#staffList input[type='checkbox']:checked").each(function () {
      selectedStaffIds.push($(this).val());
    });

    $.ajax({
      url: "/api/buildings",
      type: "PUT",
      data: JSON.stringify({
        buildingId: currentBuildingId,
        staffIds: selectedStaffIds
      }),
      contentType: "application/json",
      success: function (response) {
        alert("Giao tòa nhà thành công!");
      },
      error: function (xhr, status, error) {
        alert("Lỗi: " + xhr.responseText);
      }
    });
  });
</script>
</body>
</html>

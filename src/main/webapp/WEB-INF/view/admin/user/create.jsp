<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Create User</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <!-- Header -->
                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Create User</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/user">Users</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>

                                <!-- Hiển thị lỗi chung -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <!-- Form tạo user -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <form:form action="/admin/user/create" method="post" modelAttribute="user"
                                            enctype="multipart/form-data">
                                            <div class="mb-3">
                                                <label class="form-label">Email:</label>
                                                <form:input path="email" cssClass="form-control" />
                                                <form:errors path="email" cssClass="text-danger" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Họ tên:</label>
                                                <form:input path="fullName" cssClass="form-control" />
                                                <form:errors path="fullName" cssClass="text-danger" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Password:</label>
                                                <form:password path="password" cssClass="form-control" />
                                                <form:errors path="password" cssClass="text-danger" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại:</label>
                                                <form:input path="phone" cssClass="form-control" />
                                                <form:errors path="phone" cssClass="text-danger" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Avatar:</label>
                                                <input type="file" class="form-control" accept=".png,.jpg,.jpeg"
                                                    id="avatarFile" name="fileImg" />
                                            </div>
                                            <div class="mb-3">
                                                <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                    id="avatarPreview" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Role:</label>
                                                <form:select path="role.id" class="form-select">
                                                    <form:options items="${roles}" itemValue="id" itemLabel="name" />
                                                </form:select>
                                            </div>
                                            <button type="submit" class="btn btn-success">
                                                <i class="fa fa-save"></i> Create User
                                            </button>
                                            <a href="/admin/user" class="btn btn-secondary">
                                                <i class="fa fa-arrow-left"></i> Back
                                            </a>

                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const avatarFile = document.getElementById('avatarFile')
                        const avatarPreview = document.getElementById('avatarPreview')
                        avatarFile.addEventListener("change", function (e) {
                            const file = e.target.files[0]
                            if (file) {
                                const imgURL = URL.createObjectURL(file)
                                avatarPreview.src = imgURL
                                avatarPreview.style.display = "block"
                            }
                        })
                    })
                </script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Register - Laptopshop</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #ffffff;
                        height: 100vh;
                    }

                    .card {
                        border: 1px solid #000;
                        border-radius: .5rem;
                    }

                    .card-header {
                        background-color: #000;
                        color: #fff;
                        text-align: center;
                        font-size: 1.5rem;
                        font-weight: 500;
                    }

                    .btn-dark {
                        background-color: #000;
                        color: #fff;
                    }

                    .btn-dark:hover {
                        background-color: #333;
                    }
                </style>
            </head>

            <body class="d-flex justify-content-center align-items-center">

                <div class="container" style="max-width: 500px;">
                    <div class="card shadow-sm w-100">
                        <div class="card-header">
                            Tạo Tài Khoản
                        </div>
                        <div class="card-body bg-white">
                            <form:form method="post" action="/register" modelAttribute="registerUser">

                                <!-- First Name -->
                                <div class="mb-3">
                                    <label for="firstName" class="form-label">Họ</label>
                                    <form:input path="firstName" id="firstName" cssClass="form-control" />
                                    <form:errors path="firstName" cssClass="text-danger" />
                                </div>

                                <!-- Last Name -->
                                <div class="mb-3">
                                    <label for="lastName" class="form-label">Tên</label>
                                    <form:input path="lastName" id="lastName" cssClass="form-control" />
                                    <form:errors path="lastName" cssClass="text-danger" />
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <form:input path="email" id="email" type="email" cssClass="form-control" />
                                    <form:errors path="email" cssClass="text-danger" />
                                </div>

                                <!-- Password -->
                                <div class="mb-3">
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <form:input path="password" id="password" type="password" cssClass="form-control" />
                                    <form:errors path="password" cssClass="text-danger" />
                                </div>

                                <!-- Confirm Password -->
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                    <form:input path="confirmPassword" id="confirmPassword" type="password"
                                        cssClass="form-control" />
                                    <form:errors path="confirmPassword" cssClass="text-danger" />
                                </div>

                                <!-- Submit -->
                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-dark">Tạo tài khoản</button>
                                </div>

                                <!-- Link to login -->
                                <div class="text-center mt-3">
                                    <small>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></small>
                                </div>

                            </form:form>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>
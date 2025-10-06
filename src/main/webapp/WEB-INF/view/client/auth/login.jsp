<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Login - Laptopshop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
            <style>
                body {
                    background-color: #ffffff;
                    /* nền trắng */
                    color: #000000;
                    /* chữ đen */
                }

                .card-login {
                    max-width: 400px;
                    margin: 5rem auto;
                    border: 1px solid #000;
                    border-radius: 0.5rem;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .card-login .card-header {
                    background-color: #000;
                    color: #fff;
                    text-align: center;
                    font-size: 1.5rem;
                    font-weight: 500;
                }

                .btn-black {
                    background-color: #000;
                    color: #fff;
                }

                .btn-black:hover {
                    background-color: #333;
                }
            </style>
        </head>

        <body>
            <div class="card card-login shadow-lg">
                <div class="card-header">
                    Login
                </div>


                <div class="card-body">
                    <form method="post" action="/login">
                        <c:if test="${param.error != null}">
                            <div class="my-2" style="color: red;">Invalid email or password.</div>
                        </c:if>


                        <c:if test="${param.logout != null}">
                            <div class="mb-2 text-success">Logout success.</div>
                        </c:if>

                        <div class="mb-3">
                            <label for="username" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="username" name="username"
                                placeholder="name@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="Password" required>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-black">Login</button>
                        </div>
                    </form>

                </div>
                <div class="card-footer text-center py-3">
                    <small>Bạn chưa có tài khoản? <a href="/register">Đăng ký ngay</a></small>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>403 - Laptopshop</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    body {
                        background-color: #121212;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        min-height: 100vh;
                    }

                    .alert-danger {
                        background-color: #d32f2f;
                        color: white;
                        border: none;
                    }

                    .btn-success {
                        background-color: #00bcd4;
                        border: none;
                        color: #000;
                        font-weight: 500;
                    }

                    .btn-success:hover {
                        background-color: #0097a7;
                        color: #fff;
                    }
                </style>
            </head>

            <body>
                <div class="container text-center">
                    <div class="row justify-content-center">
                        <div class="col-lg-6 col-md-8 mt-5">
                            <div class="alert alert-danger mb-4" role="alert">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                                Bạn không có quyền truy cập nguồn tài nguyên này
                            </div>
                            <a href="/" class="btn btn-success btn-lg">
                                <i class="fa-solid fa-house me-2"></i>
                                Trang Chủ
                            </a>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>
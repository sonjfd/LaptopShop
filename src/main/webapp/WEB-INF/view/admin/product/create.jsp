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
                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container px-4">
                                <h1 class="mt-4"> Products</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product">Product</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>
                                <div class="container-md mt-4">
                                    <h2>Create Product</h2>
                                    <hr>
                                    <form:form action="/admin/product/create" method="post"
                                        enctype="multipart/form-data" modelAttribute="product">
                                        <div class="row">
                                            <div class="col-md-6 col-sm-6 mb-3">
                                                <label class="form-label">Name:</label>
                                                <form:input type="text" cssClass="form-control" path="name" />
                                                <form:errors cssClass="text-danger " path="name" />
                                            </div>
                                            <div class="col-md-6 col-sm-6 mb-3">
                                                <label class="form-label">Price:</label>
                                                <form:input type="number" cssClass="form-control" path="price" />
                                                <form:errors cssClass="text-danger " path="price" />
                                            </div>

                                            <div class="col-md-12 col-sm-12 mb-3">
                                                <label class="form-label">Detail description:</label>
                                                <form:textarea cssClass="form-control" path="detailDesc" />
                                                <form:errors cssClass="text-danger " path="detailDesc" />
                                            </div>
                                            <div class="col-md-6 col-sm-6 mb-3">
                                                <label class="form-label">Short description:</label>
                                                <form:input type="text" cssClass="form-control" path="shortDesc" />
                                                <form:errors cssClass="text-danger " path="shortDesc" />
                                            </div>
                                            <div class="col-md-6 col-sm-6 mb-3">
                                                <label class="form-label">Quantity:</label>
                                                <form:input type="number" cssClass="form-control" path="quantity" />
                                                <form:errors cssClass="text-danger " path="quantity" />
                                            </div>
                                            <div class="mb-3 col-12 col-md-6">
                                                <label class="form-label">Factory:</label>
                                                <form:select class="form-select" path="factory">
                                                    <form:option value="APPLE">Apple (MacBook)</form:option>
                                                    <form:option value="ASUS">Asus</form:option>
                                                    <form:option value="LENOVO">Lenovo</form:option>
                                                    <form:option value="DELL">Dell</form:option>
                                                    <form:option value="LG">LG</form:option>
                                                    <form:option value="ACER">Acer</form:option>
                                                    <form:option value="MSI">MSI</form:option>
                                                    <form:option value="HP">HP</form:option>
                                                    <form:option value="SAMSUNG">Samsung</form:option>
                                                    <form:option value="MICROSOFT">Microsoft (Surface)</form:option>
                                                    <form:option value="RAZER">Razer</form:option>
                                                    <form:option value="HUAWEI">Huawei</form:option>
                                                    <form:option value="XIAOMI">Xiaomi</form:option>
                                                </form:select>
                                            </div>


                                            <div class="mb-3 col-12 col-md-6">
                                                <label class="form-label">Target:</label>
                                                <form:select class="form-select" path="target">
                                                    <form:option value="GAMING">Gaming</form:option>
                                                    <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng
                                                    </form:option>
                                                    <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                                    <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                    <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                </form:select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Image:</label>
                                                <input type="file" class="form-control" accept=".png,.jpg,.jpeg"
                                                    id="productFile" name="fileImg" />
                                            </div>
                                            <div class="mb-3">
                                                <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                    id="productPreview" />
                                            </div>

                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <button type="submit" class="btn btn-outline-warning">Create
                                                Product</button>
                                            <button class="btn btn-outline-secondary"><a href="/admin/product"
                                                    style="text-decoration: none;">Back</a></button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const productImg = document.getElementById("productFile")
                        const preview = document.getElementById("productPreview")
                        productImg.addEventListener("change", function (e) {
                            const file = e.target.files[0]
                            if (file) {
                                const imgUrl = URL.createObjectURL(file)
                                preview.src = imgUrl
                                preview.style.display = "block"
                            }
                        })
                    })
                </script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>
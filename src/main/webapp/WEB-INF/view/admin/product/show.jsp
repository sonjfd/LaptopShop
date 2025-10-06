<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" />
            <title>Product List</title>
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">List Product</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item "><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Products</li>
                            </ol>
                            <div class="d-flex justify-content-end mb-3">
                                <button class="btn btn-sm btn-outline-primary">
                                    <a href="/admin/product/create">Create Product</a>
                                </button>
                            </div>
                            <c:if test="${not empty messageCreateSuccess}">
                                <div class="alert alert-success" role="alert">
                                    ${messageCreateSuccess}
                                </div>
                            </c:if>

                            <c:if test="${not empty updateSuccess}">
                                <div class="alert alert-primary" role="alert">
                                    ${updateSuccess}
                                </div>
                            </c:if>
                            <c:if test="${not empty deleteSuccess}">
                                <div class="alert alert-success" role="alert">
                                    ${deleteSuccess}
                                </div>
                            </c:if>


                            <div>
                                <table class="table table-bordered table-hover align-middle text-center">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Sold</th>
                                            <th>Factory</th>
                                            <th>Target</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${products}">
                                            <tr>
                                                <td>${p.id}</td>
                                                <td>${p.name}</td>
                                                <td>${p.price}</td>
                                                <td>${p.quantity}</td>
                                                <td>${p.sold}</td>
                                                <td>${p.factory}</td>
                                                <td>${p.target}</td>
                                                <td>
                                                    <a href="/admin/product/update/${p.id}"
                                                        class="btn btn-outline-warning">Update</a>
                                                    <a href="/admin/product/delete/${p.id}"
                                                        class="btn btn-outline-danger"
                                                        onclick="return confirm('Bạn có chắc muốn xoá sản phẩm này không')">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <c:if test="${totalPages > 0}">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <!-- Previous -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/product?page=${currentPage - 1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>

                                            <!-- Page Numbers -->
                                            <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                                <li
                                                    class="page-item ${ (loop.index+1) eq currentPage ? 'active' : '' }">
                                                    <a class="page-link" href="/admin/product?page=${loop.index+1}">
                                                        ${loop.index+1}
                                                    </a>
                                                </li>
                                            </c:forEach>

                                            <!-- Next -->
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/product?page=${currentPage + 1}"
                                                    aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>


                            </div>
                        </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>

        </body>

        </html>
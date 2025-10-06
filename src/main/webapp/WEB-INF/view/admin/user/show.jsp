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
                            <h1 class="mt-4">Manager User</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item "><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">List User</li>
                            </ol>

                            <!-- mess thong bao -->
                            <c:if test="${not empty messageCreateUser}">
                                <div class="alert alert-success" role="alert">
                                    ${messageCreateUser}
                                </div>
                            </c:if>

                            <c:if test="${not empty messageUpdateUser}">
                                <div class="alert alert-primary" role="alert">
                                    ${messageUpdateUser}
                                </div>
                            </c:if>

                            <div class="d-flex justify-content-end mb-3">
                                <button class="btn btn-sm btn-outline-primary ">
                                    <a href="/admin/user/create">Create User</a>
                                </button>
                            </div>


                            <div class="card shadow">
                                <div class="card-body">
                                    <table class="table table-bordered table-hover align-middle text-center">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Email</th>
                                                <th>Full Name</th>
                                                <th>Phone</th>
                                                <th>Role</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${users}">
                                                <tr>
                                                    <td>${u.id}</td>
                                                    <td>${u.email}</td>
                                                    <td>${u.fullName}</td>
                                                    <td>${u.phone}</td>
                                                    <td>${u.role.name}</td>
                                                    <td>
                                                        <a href="/admin/user/${u.id}"
                                                            class="btn btn-outline-success">View</a>
                                                        <a href="/admin/user/update/${u.id}"
                                                            class="btn btn-outline-warning  mx-2">Update</a>
                                                        <a href="/admin/user/delete/${u.id}"
                                                            class="btn btn-outline-danger"
                                                            onclick="return confirm('Bạn có chắc chắn muốn xoá?');">
                                                            Delete
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <!-- Previous -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/user?page=${currentPage - 1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>

                                            <!-- Page Numbers -->
                                            <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                                <li
                                                    class="page-item ${ (loop.index+1) eq currentPage ? 'active' : '' }">
                                                    <a class="page-link" href="/admin/user?page=${loop.index+1}">
                                                        ${loop.index+1}
                                                    </a>
                                                </li>
                                            </c:forEach>

                                            <!-- Next -->
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/user?page=${currentPage + 1}"
                                                    aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>User Detail</title>
                <!-- Bootstrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="bg-light">

                <div class="container mt-5">
                    <div class="card shadow-lg">
                        <div class="card-header bg-dark text-white">
                            <h3 class="mb-0">User Detail</h3>
                        </div>
                        <div class="card-body d-flex align-items-center">
                            <!-- Avatar -->
                            <div class="me-4">
                                <c:choose>
                                    <c:when test="${user.avatar != null && user.avatar != ''}">
                                        <img src="/uploads/avatar/${user.avatar}" alt="Avatar" class="rounded-circle"
                                            style="width:120px;height:120px;object-fit:cover;border:2px solid #333;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/images/default-avatar.png" alt="Avatar" class="rounded-circle"
                                            style="width:120px;height:120px;object-fit:cover;border:2px solid #333;">
                                    </c:otherwise>
                                </c:choose>


                            </div>

                            <!-- User Info -->
                            <dl class="row mb-0">
                                <dt class="col-sm-4">ID</dt>
                                <dd class="col-sm-8">${user.id}</dd>

                                <dt class="col-sm-4">Email</dt>
                                <dd class="col-sm-8">${user.email}</dd>

                                <dt class="col-sm-4">Full Name</dt>
                                <dd class="col-sm-8">${user.fullName}</dd>

                                <dt class="col-sm-4">Phone</dt>
                                <dd class="col-sm-8">${user.phone}</dd>

                                <dt class="col-sm-4">Role</dt>
                                <dd class="col-sm-8">${user.role.name}</dd>
                            </dl>
                        </div>
                    </div>
                </div>


                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>
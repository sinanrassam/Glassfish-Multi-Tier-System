<%-- 
    Document   : createPost
    Created on : 11/03/2020, 10:29:46 AM
    Author     : sinan.rassam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Post.Post"%>

<c:if test="${sessionScope.user == null}">
    <%
        request.getSession().setAttribute("error", "You need to be logged in to see this page");
        RequestDispatcher dispatcher = getServletContext().
                getRequestDispatcher("/login.jsp");
        dispatcher.forward(request, response);
    %>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

        <title>Posts | Forum</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container"
                 <a class="navbar-brand" href="<%= response.encodeURL(request.getContextPath())%>">Forum</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="<%= response.encodeURL(request.getContextPath())%>">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="<%= response.encodeURL(request.getContextPath() + "/getForums")%>">Forum</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav nav-right">
                        <li class="nav-item dropdown">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Welcome ${user.username}
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="<%= response.encodeURL(request.getContextPath() + "/profile.jsp")%>">Profile</a>
                                        <a class="dropdown-item" href="<%= response.encodeURL(request.getContextPath() + "/logout")%>">Logout</a>
                                    </div>
                                </c:when>
                            </c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger" role="alert">
                <strong>Error:</strong> <%= request.getSession().getAttribute("error")%>
            </div>
            <% request.getSession().removeAttribute("error");%>
        </c:if>

        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-info" role="alert">
                <strong>Message</strong> <%= request.getSession().getAttribute("message")%>
            </div>
            <% request.getSession().removeAttribute("message");%>
        </c:if>

        <div class="container">
            <h1>Posts for Forum</h1>

            <h2>Create a New Post</h2>

            <form method="post" action="createPost?id=${param.id}">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Title" name="title">
                </div>

                <div class="form-group">
                    <textarea class="form-control" rows="3" placeholder="Description" name="description"></textarea>
                </div>

                <button class="btn btn-primary btn-block" type="submit">Create Post</button>
                <hr />
            </form>
                
            <h2>Forum Posts:</h2>

            <ul class="list-group">
                <c:forEach var="post" items="${requestScope.posts}">
                    <li class="list-group-item">
                        <h4><c:out value="${post.title}" /></h4>
                        <c:out value="${post.description}" />
                        <br />
                        <br />
                        Created by <c:out value="${post.username}" />
                        - On: <c:out value="${post.creationDate}" />
                    </li>
                </c:forEach>
            </ul>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: junhanyang
  Date: 2019-09-12
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="models.*" %>
<html>
<head>
    <title>My Real Estate - Property list</title>
    <tags:head/>
</head>
<body>
    <tags:navbar-log-in/>
    <% boolean isAgent = request.getSession().getAttribute("userType").equals("Agent"); %>

    <div class="container">
        <tags:flash-message/>
        <!-- Page Heading/Breadcrumbs -->
        <h1 class="mt-4 mb-3 font-weight-light">
            <% if (isAgent) { %> Published Property <% } else { %> Favourite properties <% } %>
            <i class="fas fa-list"></i>
            <small>List View</small>
        </h1>

        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="frontServlet?command=IndexPage">Home</a>
            </li>
            <li class="breadcrumb-item active">
                <% if (isAgent) { %> Published Properties <% } else { %> Favourite properties <% } %>
            </li>
        </ol>

        <hr>

        <div class="row">
            <div class="col-lg-12 m-2">
                <table class="table">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Property Type</th>
                        <th scope="col">Address</th>
                        <th scope="col">Price</th>
                        <th scope="col">Available Date</th>
                        <th scope="col">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%  if (request.getSession().getAttribute("propertyList") != null) {
                                ArrayList ps = (ArrayList) request.getSession().getAttribute("propertyList");
                                for (int i=0; i<ps.size(); i++) {
                                Property p = (Property) ps.get(i); %>
                            <tr>
                                <th scope="row">1</th>
                                <td><%=p.getType()%> - <%= p.getRent_or_buy() %></td>
                                <td><%=p.getAddress_id()%></td>
                                <td><%=p.getPrice()%></td>
                                <td><%=p.getDate_available()%></td>
                                <td>
                                    <form method="post" action="frontServlet" class="form-inline">
                                        <a href="frontServlet?command=PropertyInfo&id=<%=p.getId()%>" class="btn btn-success btn-sm mr-2" role="button">View</a>
                                        <% if (isAgent) { %>
                                        <a href="frontServlet?command=RedirectEditProperty&id=<%=p.getId()%>" class="btn btn-warning btn-sm mr-2" role="button">Edit</a>
                                        <input type="hidden" id="command" name="command" value="DeleteProperty">
                                        <button class="btn btn-danger btn-sm" type="submit"
                                                onclick="return confirm('Are you sure you want to delete this property?')">Delete
                                        </button>
                                        <% } %>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <% if (isAgent) { %>
        <div class="row mb-3">
            <form method="get" action="frontServlet">
                <input type="hidden" name="command" value="RedirectPublish">
                <div class="form-group col-lg">
                    <button class="btn btn-primary" type="submit">Publish a new property</button>
                </div>
            </form>
        </div>
        <% } %>

    </div>

    <tags:footer-copyright/>
</body>
</html>

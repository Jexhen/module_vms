<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/24
  Time: 1:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>欢迎页</title>
</head>
<body>
    <h3>欢迎您，${loginUser.mvusName}</h3>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/10/22
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>幸福村村务管理系统</title>
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/static/css/style.css">
    <link rel="icon" href="<%=basePath%>/vmsweb/frame/static/image/code.png">
</head>
<body>

<!-- layout admin -->
<div class="layui-layout layui-layout-admin"> <!-- 添加skin-1类可手动修改主题为纯白，添加skin-2类可手动修改主题为蓝白 -->
    <!-- header -->
    <div class="layui-header my-header">
        <a href="index.html">
            <!--<img class="my-header-logo" src="" alt="logo">-->
            <div class="my-header-logo">幸福村村务管理系统</div>
        </a>
        <div class="my-header-btn">
            <button class="layui-btn layui-btn-small btn-nav"><i class="layui-icon">&#xe65f;</i></button>
        </div>

        <!-- 顶部左侧添加选项卡监听 -->
        <ul class="layui-nav" lay-filter="side-top-left">
            <!--<li class="layui-nav-item"><a href="javascript:;" href-url="demo/btn.html"><i class="layui-icon">&#xe621;</i>按钮</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="layui-icon">&#xe621;</i>基础</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" href-url="demo/btn.html"><i class="layui-icon">&#xe621;</i>按钮</a></dd>
                    <dd><a href="javascript:;" href-url="demo/form.html"><i class="layui-icon">&#xe621;</i>表单</a></dd>
                </dl>
            </li>-->
        </ul>

        <!-- 顶部右侧添加选项卡监听 -->
        <ul class="layui-nav my-header-user-nav" lay-filter="side-top-right">
            <li class="layui-nav-item">
                <a class="name" href="javascript:;"><i class="layui-icon">&#xe629;</i>主题</a>
                <dl class="layui-nav-child">
                    <dd data-skin="0"><a href="javascript:;">默认</a></dd>
                    <dd data-skin="1"><a href="javascript:;">纯白</a></dd>
                    <dd data-skin="2"><a href="javascript:;">蓝白</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a class="name" href="javascript:;"><img src="<%=basePath%>/vmsweb/frame/static/image/code.png" alt="logo">${loginUser.mvusName}</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" id="modifyPassword" onclick="showPannel()"><i class="layui-icon">&#xe621;</i>修改密码</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/user/logout.shtml"><i class="layui-icon">&#x1006;</i>退出</a></dd>
                </dl>
            </li>
        </ul>

    </div>
    <!-- side -->
    <div class="layui-side my-side">
        <div class="layui-side-scroll">
            <!-- 左侧主菜单添加选项卡监听 -->
            <ul class="layui-nav layui-nav-tree" lay-filter="side-main">

                <c:forEach items="${ parentTitle }" var="pnode">

                    <li class="layui-nav-item  layui-nav-itemed">
                        <a href="javascript:;"><i class="layui-icon">&#xe620;</i>${ pnode.mvttName }</a>
                        <dl class="layui-nav-child">
                            <c:forEach items="${ childTitle }" var="cnode">
                                <c:if test="${ cnode.mvttParentId == pnode.mvttId }">
                                    <dd><a href="javascript:;" href-url="<%=basePath%>/${ cnode.mvttUrl }"><i class="layui-icon">&#xe621;</i>${cnode.mvttName}</a></dd>
                                </c:if>
                            </c:forEach>
                        </dl>
                    </li>

                </c:forEach>
                

            </ul>

        </div>
    </div>
    <!-- body -->
    <div class="layui-body my-body">

        <div class="layui-tab layui-tab-card my-tab" lay-filter="card" lay-allowClose="true">

            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="1"><span><i class="layui-icon">&#xe638;</i>欢迎页</span></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe id="iframe" src="<%=basePath%>/vmsweb/view/welcome/weclome.jsp" frameborder="0"></iframe>
                </div>
            </div>

        </div>

    </div>
    <!-- footer -->
    <div class="layui-footer my-footer">

    </div>
</div>

<!-- pay -->
<div class="my-pay-box none">
    <div><img src="<%=basePath%>/vmsweb/frame/static/image/zfb.png" alt="支付宝"><p>支付宝</p></div>
    <div><img src="<%=basePath%>/vmsweb/frame/static/image/wx.png" alt="微信"><p>微信</p></div>
</div>

<!-- 右键菜单 -->
<div class="my-dblclick-box none">
    <table class="layui-tab dblclick-tab">
        <tr class="card-refresh">
            <td><i class="layui-icon">&#x1002;</i>刷新当前标签</td>
        </tr>
        <tr class="card-close">
            <td><i class="layui-icon">&#x1006;</i>关闭当前标签</td>
        </tr>
        <tr class="card-close-all">
            <td><i class="layui-icon">&#x1006;</i>关闭所有标签</td>
        </tr>
    </table>
</div>

<!--表单-->
<div id="userForm" hidden="hidden">

    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">登录名</label>

        <div class="layui-input-inline">
            <input type="text" id="loginName" name="loginName" autocomplete="off" value="${loginUser.mvusLoginName}"
                   class="layui-input" disabled="disabled">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">原密码</label>

        <div class="layui-input-inline">
            <input type="text" id="originalPassword" name="originalPassword" lay-verify="required" placeholder="请输入原密码" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>

        <div class="layui-input-inline">
            <input type="password" id="newPassword" name="newPassword" lay-verify="required" placeholder="请输入新密码" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">重复输入</label>

        <div class="layui-input-inline">
            <input type="password" id="reNewPassword" name="reNewPassword" lay-verify="required" placeholder="请重复输入新密码" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn" lay-filter="*" id="btn-submit" onclick="submit()">立即提交</div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/static/js/vip_comm.js"></script>
<script type="text/javascript">
    // 操作对象
    var layer       = layui.layer
        ,vipNav     = layui.vip_nav
        ,$          = layui.jquery
        ,layerIndex = 0;
    layui.use(['layer','vip_nav'], function () {



        // 顶部左侧菜单生成 [请求地址,过滤ID,是否展开,携带参数]
        vipNav.top_left('./json/nav_top_left.json','side-top-left',false);
        // 主体菜单生成 [请求地址,过滤ID,是否展开,携带参数]
        vipNav.main('./json/nav_main.json','side-main',true);

        // you code ...
        $('#modifyPassword').click(function () {

        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            var user = {};
            user.loginName = $('#loginName').val();
            user.originalPassword = $('#originalPassword').val();
            user.newPassword = $('#newPassword').val();
            user.reNewPassword = $('#reNewPassword').val();
            $.ajax({
               url : '${pageContext.request.contextPath}/user/modifyPassword.shtml',
               method : 'post',
               data : user,
               success : function(result){
                   layer.alert(result.message);
               }
            });
        });

    });

    function showPannel() {
        $('#originalPassword').val('');
        $('#newPassword').val('');
        $('#reNewPassword').val('');
        layerIndex = layer.open({
            type: 1,
            title: '编辑',
            content: $('#userForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
        });
    }

    function submit() {
        var user = {};
        user.loginName = $('#loginName').val();
        user.originalPassword = $('#originalPassword').val();
        user.newPassword = $('#newPassword').val();
        user.reNewPassword = $('#reNewPassword').val();
        $.ajax({
            url : '${pageContext.request.contextPath}/user/modifyPassword.shtml',
            method : 'post',
            data : user,
            success : function(result){
                layer.alert(result.message);
            }
        });
    }
</script>
</body>
</html>

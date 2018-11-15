<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/12
  Time: 22:43
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
    <title>用户管理</title>
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/layui/css/layui.css">
    <!--<link rel="stylesheet" href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">-->
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/static/css/style.css">
    <link rel="icon" href="<%=basePath%>/vmsweb/frame/static/image/code.png">
</head>
<body class="body">

<!-- 工具集 -->
<div class="my-btn-box">
    <span class="fl">
        <a class="layui-btn layui-btn-danger radius btn-delect" id="btn-delete-all">批量删除</a>
        <a class="layui-btn btn-add btn-default" id="btn-add">添加</a>
        <a class="layui-btn btn-add btn-default" id="btn-refresh"><i class="layui-icon">&#x1002;</i></a>
    </span>
    <span class="fr">
        <span class="layui-form-label">查询条件</span>
        <div class="layui-input-inline">
            <input type="text" id="query-mvusName" autocomplete="off" placeholder="姓名" class="layui-input">
        </div>
        <div class="layui-input-inline">
            <input type="text" id="query-mvusOrganizationName" autocomplete="off" placeholder="所属组织" class="layui-input">
        </div>
        <div class="layui-input-inline">
            <input type="text" id="query-mvusRoleName" autocomplete="off" placeholder="角色" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="userTable" lay-filter="userTable"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<!--表单-->
<div id="userForm" hidden="hidden">

    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">用户ID</label>

        <div class="layui-input-inline">
            <input type="text" id="mvusId" name="mvusId" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>

        <div class="layui-input-inline">
            <input type="text" id="mvusName" name="mvusName" lay-verify="required" placeholder="请输入姓名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">登陆名</label>

        <div class="layui-input-inline">
            <input type="text" id="mvusLoginName" name="mvusLoginName" lay-verify="required" placeholder="请输入登陆名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">身份证号</label>

        <div class="layui-input-inline">
            <input type="text" id="mvusMobile" name="mvusMobile" lay-verify="required" placeholder="请输入身份证号" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            男<input type="radio" name="mvusGender" id="genderMale" value="M">
            女<input type="radio" name="mvusGender" id="genderFemale" value="F" checked>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">手机</label>

        <div class="layui-input-inline">
            <input type="text" id="mvusMail" name="mvusMail" lay-verify="required" placeholder="请输入手机" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">所属组织</label>
        <div class="layui-input-inline">
            <select name="mvusOrganizationId" id="mvusOrganizationId" lay-verify="required" class="layui-input">
                <option value=""></option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">所属角色</label>
        <div class="layui-input-inline">
            <select name="mvusRoleId" id="mvusRoleId" lay-verify="required" class="layui-input">
                <option value=""></option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn" lay-filter="*" id="btn-submit">立即提交</div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>/vmsweb/js/index.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer;
    $(function () {
        // 加载组织下拉框
        $.ajax({
            url : '${pageContext.request.contextPath}/common/options/getOrganizationOption.shtml',
            type : 'post',
            success : function(result) {
                var options = result.options;
                var option = null;
                var optionHtml = null;
                for (var i = 0; i < options.length; i++) {
                    option = options[i];
                    optionHtml = '<option value="'+ option.key +'">'+ option.value + '</option>'
                    $('#mvusOrganizationId').append(optionHtml);// 往下拉菜单里添加元素
                }
            },
            dataType : 'json'
        });

        // 加载角色下拉框
        $.ajax({
            url : '${pageContext.request.contextPath}/common/options/getRoleOption.shtml',
            type : 'post',
            success : function(result) {
                var options = result.options;
                var option = null;
                var optionHtml = null;
                for (var i = 0; i < options.length; i++) {
                    option = options[i];
                    optionHtml = '<option value="'+ option.key +'">'+ option.value + '</option>'
                    $('#mvusRoleId').append(optionHtml);// 往下拉菜单里添加元素
                }
            },
            dataType : 'json'
        });
    });

    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;

        //第一个实例
        var userTable = table.render({
            elem: '#userTable'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/user/getUsers.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'mvusId', title: 'ID', width: 80}
                , {field: 'mvusName', title: '姓名', width: 120}
                , {field: 'mvusLoginName', title: '登陆名', width:150}
                , {field: 'mvusGender', title: '性别', width:10}
                , {field: 'mvusMobile', title: '手机', width:150}
                , {field: 'mvusMail', title: '身份证号', width:200}
                , {field: 'mvusOrganizationName', title: '所属组织', width:200}
                , {field: 'mvusRoleName', title: '所属角色', width:150}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]],
            id: 'userTableId'
        });

        //监听工具条
        table.on('tool(userTable)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'edit'){
                editUser(data);
            }
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('userTableId'); //organizationTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var users = checkStatus.data;
                var ids = [];
                for (var i = 0; i < users.length; i++) {
                    ids.push(users[i].mvusId);
                }
                removeUser(ids);
            }
        });

        // 添加
        $('#btn-add').on('click', function () {
            $('#mvusId').val('');
            $('#mvusName').val('');
            $('#mvusLoginName').val('');
            $('#mvusMobile').val('');
            $('#mvusMail').val('');
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                content: $('#userForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 刷新
        $('#btn-refresh').on('click', function () {
            userTable.reload();
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitUser();
        });

        // 查询
        $('#btn-search').on('click', function () {
            userTable.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    'mvusName' : $('#query-mvusName').val()
                    , 'mvusOrganizationName' : $('#query-mvusOrganizationName').val()
                    , 'mvusRoleName' : $('#query-mvusRoleName').val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });


        /**
         * 编辑组织
         */
        function editUser(user) {
            $('#mvusId').val(user.mvusId);
            $('#mvusName').val(user.mvusName);
            $('#mvusLoginName').val(user.mvusLoginName);
            if (user.mvusGender==='M') {
                $('#genderMale').attr("checked","checked");
            } else {
                $('#genderFemale').attr("checked","checked");
            }
            $('#mvusMobile').val(user.mvusMobile);
            $('#mvusMail').val(user.mvusMail);
            $('#mvusOrganizationId').val(user.mvusOrganizationName);
            $('#mvusRoleId').val(user.mvusRoleName);
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                content: $('#userForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }

        /**
         * 提交表单
         */
        function submitUser() {
            var mvusId = $('#mvusId').val();
            var url = '';
            if (mvusId) {
                url = '${pageContext.request.contextPath}/user/modifyUser.shtml';
            } else {
                url = '${pageContext.request.contextPath}/user/addUser.shtml';
            }
            var user = {};
            user.mvusId = mvusId;
            user.mvusName = $('#mvusName').val();
            user.mvusLoginName = $('#mvusLoginName').val();
            user.mvusGender = 'F';
            if ($('#genderMale').attr('checked') == 'checked') {
                user.mvusGender = 'M';
            }
            user.mvusMobile = $('#mvusMobile').val();
            user.mvusMail = $('#mvusMail').val();
            user.mvusOrganizationId = $('#mvusOrganizationId').val();
            user.mvusRoleId = $('#mvusRoleId').val();
            $.ajax({
                url : url,
                method : 'POST',
                data : user,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        userTable.reload();
                    }
                },
                dataType : 'json'
            });
        }

        function removeUser(ids) {
            var url = '${pageContext.request.contextPath}/user/removeUser.shtml'
            $.ajax({
                url : url,
                method : 'POST',
                data : {'ids' : ids},
                success : function(result) {
                    layer.alert(result.message);
                    userTable.reload();
                },
                dataType : 'json'
            });
        }
    });


</script>
</body>
</html>
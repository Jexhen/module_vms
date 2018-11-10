<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/10/23
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>角色管理</title>
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/static/css/style.css">
    <!--<link rel="stylesheet" href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">-->
    <link rel="icon" href="<%=basePath%>/vmsweb/frame/static/image/code.png">
</head>
<body class="body">

<!-- 工具集 -->
<div class="my-btn-box">
    <span class="fl">
        <a class="layui-btn layui-btn-danger radius btn-delect" id="btn-delete-all">批量删除</a>
        <a class="layui-btn btn-add btn-default" id="btn-add" onclick="addRole()">添加</a>
        <a class="layui-btn btn-add btn-default" id="btn-refresh"><i class="layui-icon">&#x1002;</i></a>
    </span>
    <span class="fr">
        <span class="layui-form-label">搜索条件：</span>
        <div class="layui-input-inline">
            <input type="text" autocomplete="off" placeholder="请输入搜索条件" class="layui-input">
        </div>
        <button class="layui-btn mgl-20">查询</button>
    </span>
</div>

<!-- 表格 -->
<table id="roleTable" lay-filter="roleTable"></table>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer;

    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#roleTable'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/role/getRoles.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {checkbox: true, fixed: true}
                ,{field: 'mvrlId', title: '角色ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'mvrlName', title: '角色名称', width:150}
                ,{field: 'creator', title: '创建者', width:150}
                ,{field: 'createTime', title: '创建时间', width:200, sort: true}
                ,{field: 'modifier', title: '修改者', width:150}
                ,{field: 'modifyTime', title: '修改时间', width:200, sort: true}
                ,{field:'right', title: '操作', width:177,toolbar:"#operaitonBar"}
            ]],
            id: 'roleTableId'
        });

        //监听工具条
        table.on('tool(roleTable)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'edit'){
                editRole(data);
            }
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('roleTableId'); //roleTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var roles = checkStatus.data;
                var roleIds = [];
                for (var i = 0; i < roles.length; i++) {
                    roleIds.push(roles[i].mvrlId);
                }
                deleteRoles(roleIds);
            }
        });
    });

    /**
     * 编辑角色
     * @param data 行内容
     */
    function editRole(data) {
        $('#mvrlId').val(data.mvrlId);
        $('#mvrlName').val(data.mvrlName);
        layer.open({
            type: 1,
            title: '编辑',
            content: $('#roleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
        });
    }

    /**
     * 增加角色
     */
    function addRole() {
        $('#mvrlId').val('');// 防止浏览器缓存
        $('#mvrlName').val('');
        layer.open({
            type: 1,
            title: '编辑',
            content: $('#roleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
        });
    }

    /**
     * 提交表单
     */
    function submitRole() {
        var roleId = $('#mvrlId').val();
        var url = '';
        if (roleId) {
            url = '${pageContext.request.contextPath}/role/modifyRole.shtml'
        } else {
            url = '${pageContext.request.contextPath}/role/addRole.shtml'
        }
        var mvrlName = $('#mvrlName').val();
        $.ajax({
            url : url,
            method : 'POST',
            data : {'mvrlId': roleId, 'mvrlName' : mvrlName},
            success : function(result) {
                layer.alert(result.message);
            },
            dataType : 'json'
        });
    }

    /**
     * 批量删除
     * @param roleIds 角色ID集
     */
    function deleteRoles(roleIds) {
        if (roleIds && roleIds.length) {
            $.ajax({
                url : '${pageContext.request.contextPath}/role/deleteRoles.shtml',
                type : 'post',
                data : {
                    'roleIds' : roleIds
                },
                success : function(result) {
                    layer.alert(result.message);
                },
                dataType : 'json'
            });
        }
    }
</script>
<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-mini" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-mini layui-btn-normal" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-mini layui-btn-danger" lay-event="del">删除</a>
</script>
</body>
<!--表单-->
<form class="layui-form layui-form-pane"  method="post" id="roleForm" hidden="hidden">

    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">角色ID</label>

        <div class="layui-input-inline">
            <input type="text" id="mvrlId" name="mvrlId" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">角色名称</label>

        <div class="layui-input-inline">
            <input type="text" id="mvrlName" name="mvrlName" lay-verify="required" placeholder="请输入角色名称" autocomplete="off"
                   class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*" onclick="submitRole()">立即提交</button>
        </div>
    </div>
</form>
</html>

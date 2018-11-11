<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/10/23
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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
        <a class="layui-btn btn-add btn-default" id="btn-add">添加</a>
        <a class="layui-btn btn-add btn-default" id="btn-refresh"><i class="layui-icon">&#x1002;</i></a>
    </span>
    <span class="fr">
        <span class="layui-form-label">角色名称：</span>
        <div class="layui-input-inline">
            <input type="text" id="query-mvrlName" autocomplete="off" placeholder="请输入搜索条件" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<table id="roleTable" lay-filter="roleTable"></table>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<!--表单-->
<div id="roleForm" hidden="hidden">

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
            <div class="layui-btn" lay-submit lay-filter="*" id="btn-sumbit">立即提交</div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer;

    layui.use('table', function(){
        var table = layui.table;
        var layerIndex = 0;

        //第一个实例
        var roleTable = table.render({
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

        // 添加
        $('#btn-add').on('click',function(){
            $('#mvrlId').val('');// 防止浏览器缓存
            $('#mvrlName').val('');
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                content: $('#roleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 刷新
        $('#btn-refresh').on('click', function () {
            roleTable.reload();
        });

        // 提交
        $('#btn-sumbit').on('click',function() {
            submitRole();
        });

        // 查询
        $('#btn-search').on('click',function () {
            roleTable.reload({
                where : {
                    'mvrlName' : $('#query-mvrlName').val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
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
            layerIndex = layer.open({
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
                    if (result.success) {
                        layer.close(layerIndex);
                        roleTable.reload();
                    }
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
                        roleTable.reload();
                    },
                    dataType : 'json'
                });
            }
        }
    });

</script>
<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-mini" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-mini layui-btn-normal" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-mini layui-btn-danger" lay-event="del">删除</a>
</script>
</body>

</html>

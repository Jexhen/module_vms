<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/10/23
  Time: 10:58
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
    <title>组织管理</title>
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
        <span class="layui-form-label">组织名称：</span>
        <div class="layui-input-inline">
            <input type="text" id="query-mogzName" autocomplete="off" placeholder="请输入搜索条件" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="organizationTable" lay-filter="organizationTable"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<!--表单-->
<div id="organizationForm" hidden="hidden">

    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">组织ID</label>

        <div class="layui-input-inline">
            <input type="text" id="mogzId" name="mogzId" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">组织名称</label>

        <div class="layui-input-inline">
            <input type="text" id="mogzName" name="mogzName" lay-verify="required" placeholder="请输入组织名称" autocomplete="off"
                   class="layui-input">
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
    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;

        //第一个实例
        var organizationTable = table.render({
            elem: '#organizationTable'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/organization/getOrganization.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'mogzId', title: 'ID', width: 80}
                , {field: 'mogzName', title: '组织名称', width: 120}
                , {field: 'creator', title: '创建者', width:150}
                , {field: 'createTime', title: '创建时间', width:200, sort: true}
                , {field: 'modifier', title: '修改者', width:150}
                , {field: 'modifyTime', title: '修改时间', width:200, sort: true}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]],
            id: 'organizationTableId'
        });

        //监听工具条
        table.on('tool(organizationTable)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'edit'){
                editOrganization(data);
            }
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('organizationTableId'); //organizationTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var organizations = checkStatus.data;
                var ids = [];
                for (var i = 0; i < organizations.length; i++) {
                    ids.push(organizations[i].mogzId);
                }
                removeOrganization(ids);
            }
        });

        // 添加
        $('#btn-add').on('click', function () {
            $('#mogzId').val('');
            $('#mogzName').val('');
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                content: $('#organizationForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 刷新
        $('#btn-refresh').on('click', function () {
            organizationTable.reload();
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitOrganization();
        });

        // 查询
        $('#btn-search').on('click', function () {
            organizationTable.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    'mogzName' : $('#query-mogzName').val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        /**
         * 编辑组织
         */
        function editOrganization(organization) {
            $('#mogzId').val(organization.mogzId);
            $('#mogzName').val(organization.mogzName);
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                content: $('#organizationForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }

        /**
         * 提交表单
         */
        function submitOrganization() {
            var mogzId = $('#mogzId').val();
            var url = '';
            if (mogzId) {
                url = '${pageContext.request.contextPath}/organization/modifyOrganization.shtml';
            } else {
                url = '${pageContext.request.contextPath}/organization/addOrganization.shtml';
            }
            var mogzName = $('#mogzName').val();
            $.ajax({
                url : url,
                method : 'POST',
                data : {'mogzId': mogzId, 'mogzName' : mogzName},
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        organizationTable.reload();
                    }
                },
                dataType : 'json'
            });
        }

        function removeOrganization(ids) {
            var url = '${pageContext.request.contextPath}/organization/removeOrganization.shtml'
            $.ajax({
                url : url,
                method : 'POST',
                data : {'ids' : ids},
                success : function(result) {
                    layer.alert(result.message);
                    organizationTable.reload();
                },
                dataType : 'json'
            });
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

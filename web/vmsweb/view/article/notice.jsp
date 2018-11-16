<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/16
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>通知</title>
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/layui/css/layui.css">
    <!--<link rel="stylesheet" href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">-->
    <link rel="stylesheet" href="<%=basePath%>/vmsweb/frame/static/css/style.css">
    <link rel="icon" href="<%=basePath%>/vmsweb/frame/static/image/code.png">
</head>
<body class="body">

<!-- 工具集 -->
<div class="my-btn-box">
    <span class="fl">
        <a class="layui-btn btn-add btn-default" id="btn-refresh"><i class="layui-icon">&#x1002;</i></a>
    </span>
    <span class="fr">
        <span class="layui-form-label">查询条件</span>
        <div class="layui-input-inline">
            <input type="text" id="query-matcTitle" autocomplete="off" placeholder="文章标题" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="noticeTab" lay-filter="noticeTab"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="view">查看</a>
</script>


<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>/vmsweb/js/index.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer;

    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;

        //第一个实例
        var noticeTab = table.render({
            elem: '#noticeTab'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/article/getArticles.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'matcId', title: 'ID', width: 80}
                , {field: 'matcTitle', title: '标题', width: 200}
                , {field: 'matcContent', title: '文章', width: 0}
                , {field: 'matcType', title: '类型', width:150}
                , {field: 'matcOrganizationId', title: '组织', width:150}
                , {field: 'creator', title: '创建者', width:150}
                , {field: 'createTime', title: '创建时间', width:100, sort: true}
                , {field: 'modifier', title: '修改者', width:150}
                , {field: 'modifyTime', title: '修改时间', width:100, sort: true}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , where: {'articleType':'01'}
            , id: 'noticeTabId'
        });

        //监听工具条
        table.on('tool(noticeTab)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'view'){
                view(data);
            }
        });


        // 查询
        $('#btn-search').on('click', function () {
            noticeTab.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    'matcTitle' : $('#query-matcTitle').val()
                    , 'articleType':'01'
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });


        /**
         * 查看文章
         */
        function view(data){
            layerIndex = layer.open({
                type: 1,
                title: '查看',
                content: data.matcContent //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }
    });


</script>
</body>
</html>

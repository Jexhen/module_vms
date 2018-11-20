<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/20
  Time: 20:54
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
            <input type="text" id="query-madvTitle" autocomplete="off" placeholder="标题" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="adviseResponseTab" lay-filter="adviseResponseTab"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="answer">回复</a>
</script>

<!--表单-->
<div id="adviseForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">建议ID</label>

        <div class="layui-input-block">
            <input type="text" id="mvarAdivseId" name="mvarAdivseId" lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">建议投诉</label>
        <div class="layui-input-block">
            <textarea name="madvContent" id="madvContent" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">回复内容</label>
        <div class="layui-input-block">
            <textarea name="mvarContent" id="mvarContent" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn" lay-filter="*" id="btn-submit">立即提交</div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js?v=1120"></script>
<script type="text/javascript" src="<%=basePath%>/vmsweb/js/index.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer;


    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;


        //第一个实例
        var adviseResponseTab = table.render({
            elem: '#adviseResponseTab'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/advise/getAdviseOfAnswerer.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'madvId', title: 'ID', width: 80}
                , {field: 'madvTitle', title: '标题', width: 200}
                , {field: 'madvContent', title: '内容', style:'display:none;'}
                , {field: 'madvStatus', title: '状态', width:150}
                , {field: 'madvToUserId', title: '目标对象', width:150}
                , {field: 'creator', title: '提出人', width:150}
                , {field: 'createTime', title: '提出时间', width:150}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , id: 'adviseResponseTabId'
        });

        // 隐藏内容列标题
        $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');

        // 监听工具条
        table.on('tool(adviseResponseTab)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'answer'){
                answer(data);
            }
        });


        // 查询
        $('#btn-search').on('click', function () {
            adviseResponseTab.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    'madvTitle' : $('#query-madvTitle').val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
            // 隐藏文章内容列标题
            $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitAnswer();
        });

        /**
         * 回复
         */
        function answer(data){
            $('#mvarAdivseId').val(data.madvId);
            $('#madvContent').val(data.madvContent);
            $('#madvContent').attr('disabled', 'disabled');
            var status = data.madvStatus;
            var id = data.madvId;
            if (status=='已回复') {
                $.ajax({
                    url : '${pageContext.request.contextPath}/advise/getAdviseResponse.shtml',
                    method : 'post',
                    data : {'id' : id},
                    success : function (result) {
                        if (result.success) {
                            $('#mvarContent').val(result.data.mvarContent);
                            $('#mvarContent').attr('disabled', 'disabled');
                            $('#btn-submit').attr('style',"display:none");
                            layerIndex = layer.open({
                                type: 1,
                                title: '回复',
                                area: ['800px', '550px'],
                                content: $('#adviseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                            });
                        } else {
                            layer.alert(result.message);
                        }
                    },
                    dataType : 'json'
                });
            } else {
                $('#mvarContent').removeAttr('disabled');
                // $('#btn-submit').removeAttr('style');
                layerIndex = layer.open({
                    type: 1,
                    title: '回复',
                    area: ['800px', '550px'],
                    content: $('#adviseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                });
            }
        }

        /**
         * 提交回复
         */
        function submitAnswer() {
            var url = '${pageContext.request.contextPath}/advise/addAdviseResponse.shtml';
            var adviseResponse = {};
            adviseResponse.mvarAdivseId = $('#mvarAdivseId').val();
            adviseResponse.mvarContent = $('#mvarContent').val();
            $.ajax({
                url : url,
                method : 'POST',
                data : adviseResponse,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        adviseResponseTab.reload();
                    }
                },
                dataType : 'json'
            });
        }

    });


</script>
</body>
</html>

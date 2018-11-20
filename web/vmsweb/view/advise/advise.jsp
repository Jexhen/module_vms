<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/20
  Time: 18:02
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
        <a class="layui-btn btn-add btn-default" id="btn-add">投诉建议</a>
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
<div id="adviseTab" lay-filter="adviseTab"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="view">查看回复</a>
</script>

<!--表单-->
<div id="adviseForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item">
        <label class="layui-form-label">处理人</label>
        <div class="layui-input-block">
            <select name="madvToUserId" id="madvToUserId" lay-verify="required" class="layui-input">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">标题</label>

        <div class="layui-input-block">
            <input type="text" id="madvTitle" name="madvTitle" lay-verify="required" placeholder="请输入标题" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">投诉建议</label>
        <div class="layui-input-block">
            <textarea name="madvContent" id="madvContent" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn" lay-filter="*" id="btn-submit">立即提交</div>
        </div>
    </div>
</div>

<!--表单-->
<div id="responseForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">建议ID</label>

        <div class="layui-input-block">
            <input type="text" id="mvarAdivseId" name="mvarAdivseId" lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">我的建议投诉</label>
        <div class="layui-input-block">
            <textarea name="adviceContent" id="adviceContent" placeholder="请输入内容" class="layui-textarea" disabled="disabled"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回复人</label>

        <div class="layui-input-block">
            <input type="text" id="creator" name="creator" lay-verify="required" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">回复内容</label>
        <div class="layui-input-block">
            <textarea name="mvarContent" id="mvarContent" placeholder="请输入内容" class="layui-textarea" disabled="disabled"></textarea>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=basePath%>/vmsweb/frame/layui/layui.all.js?v=1120"></script>
<script type="text/javascript" src="<%=basePath%>/vmsweb/js/index.js"></script>
<script type="text/javascript">
    var $ = layui.jquery,
        layer = layui.layer,
        layEdit = layui.layedit;

    $(function () {
        // 加载目标对象下拉框
        $.ajax({
            url : '${pageContext.request.contextPath}/common/options/getAnswererOption.shtml',
            type : 'post',
            success : function(result) {
                var options = result.options;
                var option = null;
                var optionHtml = null;
                for (var i = 0; i < options.length; i++) {
                    option = options[i];
                    optionHtml = '<option value="'+ option.key +'">'+ option.value + '</option>'
                    $('#madvToUserId').append(optionHtml);// 往下拉菜单里添加元素
                }
            },
            dataType : 'json'
        });
    });

    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;


        //第一个实例
        var adviseTab = table.render({
            elem: '#adviseTab'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/advise/getAdviseOfAdvisor.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'madvId', title: 'ID', width: 80}
                , {field: 'madvTitle', title: '标题', width: 200}
                , {field: 'madvContent', title: '内容', style:'display:none;'}
                , {field: 'madvStatus', title: '状态', width:150}
                , {field: 'madvToUserId', title: '目标对象', width:150}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , id: 'adviseTabId'
        });

        // 隐藏内容列标题
        $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');

        // 监听工具条
        table.on('tool(adviseTab)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'view'){
                view(data);
            }
        });


        // 查询
        $('#btn-search').on('click', function () {
            adviseTab.reload({
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

        // 添加
        $('#btn-add').on('click', function () {
            $('#madvTitle').val('');
            $('#madvContent').val('');
            layerIndex = layer.open({
                type: 1,
                title: '投诉建议',
                area: ['800px', '550px'],
                content: $('#adviseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitAdvise();
        });

        /**
         * 查看回复
         */
        function view(data){
            var status = data.madvStatus;
            var id = data.madvId;
            if (status=='未回复') {
                layer.alert('该投诉建议还未被回复，请稍后');
            } else {
                $.ajax({
                    url : '${pageContext.request.contextPath}/advise/getAdviseResponse.shtml',
                    method : 'post',
                    data : {'id' : id},
                    success : function (result) {
                        if (result.success) {
                            var adviseResponse = result.data;
                            $('#adviceContent').val(data.madvContent);
                            $('#creator').val(adviseResponse.creator);
                            $('#mvarContent').val(adviseResponse.mvarContent);
                            layerIndex = layer.open({
                                type: 1,
                                title: '投诉建议',
                                area: ['800px', '550px'],
                                content: $('#responseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                            });
                        } else {
                            layer.alert(result.message);
                        }
                    },
                    dataType : 'json'
                });
            }
        }

        /**
         * 提交建议
         */
        function submitAdvise() {
            var url = '${pageContext.request.contextPath}/advise/addAdvise.shtml';
            var advise = {};
            advise.madvToUserId = $('#madvToUserId').val();
            advise.madvTitle = $('#madvTitle').val();
            advise.madvContent = $('#madvContent').val();
            $.ajax({
                url : url,
                method : 'POST',
                data : advise,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        adviseTab.reload();
                    }
                },
                dataType : 'json'
            });
        }

    });


</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/21
  Time: 8:53
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
    <title>证明类型</title>
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
            <input type="text" id="query-mctfName" autocomplete="off" placeholder="标题" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="noticeTab" lay-filter="noticeTab"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<!--表单-->
<div id="articleForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div hidden="hidden">
        <input type="text" id="mvctId" name="mvctId" autocomplete="off"
               class="layui-input" disabled="disabled">
    </div>
    <div class="layui-form-item" id="mctfAttachment">
        <label class="layui-form-label">标题</label>

        <div class="layui-input-block">
            <input type="text" id="mvctName" name="mvctName" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">证明要求</label>
        <div class="layui-input-block">
            <textarea name="mvctDesc" id="mvctDesc" placeholder="证明要求" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">证明对接人</label>
        <div class="layui-input-block">
            <select name="mvctAuditor" id="mvctAuditor" lay-verify="required" class="layui-input">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否需要附件</label>

        <input type="checkbox" name="zzz" lay-skin="switch" id="mvctIsNeedAttachment" lay-text="是|否">
    </div>

    <div class="layui-form-item" style="margin-top: 10px; text-align: center">
        <div class="layui-btn" lay-filter="*" id="btn-submit">立即提交</div>
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
                    $('#mvctAuditor').append(optionHtml);// 往下拉菜单里添加元素
                }
            },
            dataType : 'json'
        });
    });

    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;


        //第一个实例
        var noticeTab = table.render({
            elem: '#noticeTab'
            ,height: 500
            ,url: '${pageContext.request.contextPath}/certification/getCertificationTypeByExample.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'mvctId', title: 'ID', width: 80}
                , {field: 'mvctName', title: '标题', width: 200}
                , {field: 'mvctDesc', title: '描述', style:'display:none;'}
                , {field: 'mvctAuditor', title: '证明对接人', width:150}
                , {field: 'mvctIsNeedAttachment', title: '是否需要附件', style:'display:none;'}
                , {field: 'creator', title: '创建者', width:150}
                , {field: 'createTime', title: '创建时间', width:100, sort: true}
                , {field: 'modifier', title: '修改者', width:150}
                , {field: 'modifyTime', title: '修改时间', width:100, sort: true}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , id: 'noticeTabId'
        });

        // 隐藏文章内容列标题
        $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');
        $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');

        // 监听工具条
        table.on('tool(noticeTab)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'edit'){
                edit(data);
            }
        });


        // 查询
        $('#btn-search').on('click', function () {
            noticeTab.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    'mvctName' : $('#query-mctfName').val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
            // 隐藏列标题
            $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');
        });

        // 添加
        $('#btn-add').on('click', function () {
            $('#mvctId').val('');
            $('#mvctName').val('');
            $('#mvctDesc').val('');
            layerIndex = layer.open({
                type: 1,
                title: '新增',
                area: ['800px', '550px'],
                content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitCertificationType();
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('noticeTabId'); //organizationTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var certifications = checkStatus.data;
                var ids = [];
                for (var i = 0; i < certifications.length; i++) {
                    ids.push(certifications[i].mvctId);
                }
                removeCertificationType(ids);
            }
        });

        // 刷新
        $('#btn-refresh').on('click', function () {
            noticeTab.reload();
            // 隐藏文章内容列标题
            $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
        });

        /**
         * 查看处理进度
         */
        function edit(data){
            $('#mvctId').val(data.mvctId);
            $('#mvctName').val(data.mvctName);
            $('#mvctDesc').val(data.mvctDesc);
            if (data.mvctIsNeedAttachment==1) {
                $('#mvctIsNeedAttachment').prop('checked', 'checked');
            } else {
                $('#mvctIsNeedAttachment').removeAttr('checked');
            }
            var options = $('#mvctAuditor option');
            for (var i = 0; i < options.length; i++) {
                if (options[i].innerHTML == data.mvctAuditor) {
                    $(options[i]).prop('selected', 'selected');
                    break;
                }
            }
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                area: ['800px', '550px'],
                content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }

        /**
         * 提交证明申请
         */
        function submitCertificationType() {
            var certificationType = {};
            certificationType.mvctId = $('#mvctId').val();
            certificationType.mvctName = $('#mvctName').val();
            certificationType.mvctDesc = $('#mvctDesc').val();
            certificationType.mvctAuditor = $('#mvctAuditor').val();
            console.log($('#mvctIsNeedAttachment').prop('checked'));
            if ($('#mvctIsNeedAttachment').prop('checked')) {
                certificationType.mvctIsNeedAttachment = 1;
            } else {
                certificationType.mvctIsNeedAttachment = 0;
            }
            var url;
            if (certificationType.mvctId) {
                url = '${pageContext.request.contextPath}/certification/modifyCertificationType.shtml';
            } else {
                url = '${pageContext.request.contextPath}/certification/addCertificationType.shtml';
            }
            $.ajax({
                url : url,
                method : 'POST',
                data : certificationType,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        noticeTab.reload();
                        // 隐藏列标题
                        $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');
                        $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
                    }
                },
                dataType : 'json'
            });
        }

        /**
         * 删除证明
         * @param ids
         */
        function removeCertificationType(ids) {
            var url = '${pageContext.request.contextPath}/certification/removeCertificationType.shtml';
            $.ajax({
                url : url,
                method : 'POST',
                data : {'ids' : ids},
                success : function(result) {
                    layer.alert(result.message);
                    noticeTab.reload();
                    // 隐藏列标题
                    $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');
                    $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
                },
                dataType : 'json'
            });
        }
    });
</script>
</body>
</html>

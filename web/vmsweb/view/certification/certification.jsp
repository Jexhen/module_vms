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
    <title>证明</title>
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
    <a class="layui-btn layui-btn-mini" lay-event="view">查看进度</a>
</script>

<!--表单-->
<div id="articleForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item">
        <label class="layui-form-label">证明类型</label>
        <div class="layui-input-block">
            <select name="mctfCertificationTypeId" id="mctfCertificationTypeId" lay-verify="required" class="layui-input" onchange="onCertificationTypeSelect()">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">证明要求</label>
        <div class="layui-input-block">
            <textarea name="mvctDesc" id="mvctDesc" placeholder="证明要求" class="layui-textarea" disabled="disabled"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">证明对接人</label>

        <div class="layui-input-block">
            <input type="text" id="mvctAuditor" name="mvctAuditor" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否需要附件</label>

        <input type="checkbox" name="zzz" lay-skin="switch" id="mvctIsNeedAttachment" lay-text="是|否" disabled="disabled">
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">证明名称</label>

        <div class="layui-input-block">
            <input type="text" id="mctfName" name="mctfName" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" id="mctfAttachment">
        <label class="layui-form-label">附件名称</label>

        <div class="layui-input-block">
            <input type="text" id="mctfAttachmentName" name="mctfAttachmentName" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">附件URL</label>

        <div class="layui-input-block">
            <input type="text" id="mctfAttachmentUrl" name="mctfAttachmentUrl" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <button type="button" class="layui-btn" id="test1">
        <i class="layui-icon">&#xe67c;</i>上传附件
    </button>
    <div class="layui-form-item" style="margin-top: 10px; text-align: center">
        <div class="layui-btn" lay-filter="*" id="btn-submit">立即提交</div>
    </div>
</div>

<!--表单-->
<div id="responseForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item">
        <label class="layui-form-label">处理人</label>

        <div class="layui-input-block">
            <input type="text" id="auditor" name="auditor" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理状态</label>

        <div class="layui-input-block">
            <input type="text" id="mctfStatus" name="mctfStatus" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理意见</label>

        <div class="layui-input-block">
            <textarea name="mctfRejectReason" id="mctfRejectReason" placeholder="处理中，请您稍后" class="layui-textarea" disabled="disabled"></textarea>
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
        // 加载证明类型下拉框
        $.ajax({
            url : '${pageContext.request.contextPath}/common/options/getCertificationTypeOption.shtml',
            type : 'post',
            success : function(result) {
                var options = result.options;
                var option = null;
                var optionHtml = null;
                for (var i = 0; i < options.length; i++) {
                    option = options[i];
                    optionHtml = '<option value="'+ option.key +'">'+ option.value + '</option>'
                    $('#mctfCertificationTypeId').append(optionHtml);// 往下拉菜单里添加元素
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
            ,url: '${pageContext.request.contextPath}/certification/getCertificationForApplicant.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'mctfId', title: 'ID', width: 80}
                , {field: 'mctfName', title: '标题', width: 200}
                , {field: 'mctfStatus', title: '状态', width:150}
                , {field: 'mctfCertificationTypeId', title: '证明类型', width:150}
                , {field: 'mvctAuditor', title: '处理人', style:'display:none;'}
                , {field: 'mctfRejectReason', title: '处理意见', style:'display:none;'}
                , {field: 'creator', title: '申请人', width:150}
                , {field: 'organizationName', title: '所在组织', width:150}
                , {field: 'createTime', title: '申请时间', width:200, sort: true}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , id: 'noticeTabId'
        });

        // 隐藏文章内容列标题
        $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
        $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');

        // 监听工具条
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
                    'mctfName' : $('#query-mctfName').val()
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
            layui.use('upload', function(){
                var upload = layui.upload;
                //执行实例
                var uploadInst = upload.render({
                    elem: '#test1' //绑定元素
                    ,url: '${pageContext.request.contextPath}/certification/upload.shtml' //上传接口
                    ,done: function(res){
                        var certification = res.data;
                        //上传完毕回调
                        $('#mctfAttachmentName').val(certification.mctfAttachmentName);
                        $('#mctfAttachmentUrl').val(certification.mctfAttachmentUrl);
                    }
                    ,error: function(){
                        //请求异常回调
                    }
                    ,accept: 'file' //允许上传的文件类型
                    ,size: 2048 //最大允许上传的文件大小
                });
            });
            layerIndex = layer.open({
                type: 1,
                title: '证明申请',
                area: ['800px', '550px'],
                content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitCertification();
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('noticeTabId'); //organizationTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var certifications = checkStatus.data;
                var ids = [];
                for (var i = 0; i < certifications.length; i++) {
                    ids.push(certifications[i].mctfId);
                }
                removeCertification(ids);
            }
        });

        // 刷新
        $('#btn-refresh').on('click', function () {
            noticeTab.reload();
            // 隐藏文章内容列标题
            $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');
        });

        /**
         * 查看处理进度
         */
        function view(data){
            $('#mctfStatus').val(data.mctfStatus);
            $('#auditor').val(data.mvctAuditor);
            $('#mctfRejectReason').val(data.mctfRejectReason);
            layerIndex = layer.open({
                type: 1,
                title: '查看处理进度',
                area: ['800px', '550px'],
                content: $('#responseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }

        /**
         * 提交证明申请
         */
        function submitCertification() {
            var certification = {};
            certification.mctfName = $('#mctfName').val();
            certification.mctfCertificationTypeId = $('#mctfCertificationTypeId').val();
            certification.mctfAttachmentName = $('#mctfAttachmentName').val();
            certification.mctfAttachmentUrl = $('#mctfAttachmentUrl').val();
            $.ajax({
                url : '${pageContext.request.contextPath}/certification/addCertification.shtml',
                method : 'POST',
                data : certification,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        noticeTab.reload();
                        // 隐藏列标题
                        $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
                        $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');
                    }
                },
                dataType : 'json'
            });
        }

        /**
         * 删除证明
         * @param ids
         */
        function removeCertification(ids) {
            var url = '${pageContext.request.contextPath}/certification/removeCertification.shtml';
            $.ajax({
                url : url,
                method : 'POST',
                data : {'ids' : ids},
                success : function(result) {
                    layer.alert(result.message);
                    noticeTab.reload();
                    // 隐藏列标题
                    $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
                    $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');
                },
                dataType : 'json'
            });
        }
    });

    function onCertificationTypeSelect() {
        var id = $('#mctfCertificationTypeId').val();
        if (id) {
           $.ajax({
               url : '${pageContext.request.contextPath}/certification/getCertificationType.shtml',
               method : 'post',
               data : {'mvctId' : id},
               success : function(result) {
                   if (result.success) {
                        var certificationType = result.data;
                        $('#mvctDesc').val(certificationType.mvctDesc);
                        $('#mvctAuditor').val(certificationType.mvctAuditor);
                        if (certificationType.mvctIsNeedAttachment==1) {
                            $('#mvctIsNeedAttachment').attr('checked', 'checked');
                            $('#mctfAttachment').removeAttr('hidden');
                        } else {
                            $('#mvctIsNeedAttachment').removeAttr('checked');
                            $('#mctfAttachment').attr('hidden','hidden');
                        }
                   }
               },
               dataType : 'json'
           });
        } else {
            $('#mvctDesc').val('');
            $('#mvctAuditor').val('');
            $('#mvctIsNeedAttachment').removeAttr('checked');
            $('#mctfAttachment').attr('hidden','hidden');
        }
    }
</script>
</body>
</html>

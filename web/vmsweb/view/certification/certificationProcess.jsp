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
            <input type="text" id="query-mctfName" autocomplete="off" placeholder="标题" class="layui-input">
        </div>
        <div class="layui-btn mgl-20" id="btn-search">查询</div>
    </span>
</div>

<!-- 表格 -->
<div id="noticeTab" lay-filter="noticeTab"></div>
<!-- 工具条 -->
<script type="text/html" id="operaitonBar">
    <a class="layui-btn layui-btn-mini" lay-event="process">处理</a>
</script>

<!--表单-->
<div id="articleForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item">
        <label class="layui-form-label">证明类型</label>
        <div class="layui-input-block">
            <input type="text" id="mctfCertificationTypeId" name="mctfCertificationTypeId" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">证明要求</label>
        <div class="layui-input-block">
            <textarea name="mvctDesc" id="mvctDesc" placeholder="证明要求" class="layui-textarea" disabled="disabled"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">证明名称</label>

        <div class="layui-input-block">
            <input type="text" id="mctfName" name="mctfName" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">申请人</label>

        <div class="layui-input-block">
            <input type="text" id="creator" name="creator" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所在组织</label>

        <div class="layui-input-block">
            <input type="text" id="organizationName" name="organizationName" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <button type="button" class="layui-btn" id="attachDownload" hidden="hidden">
        <a class="layui-icon" id="download" style="color: white">&#xe601;下载附件</a>
    </button>
    <div class="layui-form-item" style="margin-top: 10px; text-align: center">
        <div class="layui-btn" lay-filter="*" id="btn-yes">通过</div>
        <div class="layui-btn layui-btn-danger" lay-filter="*" id="btn-no">驳回</div>
    </div>
</div>

<!--表单-->
<div id="responseForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div hidden="hidden">
        <input id="mctfId" type="text">
    </div>
    <div class="layui-form-item" id="agreeDiv">
        <label class="layui-form-label">通知取单时间</label>

        <div class="layui-input-block">
            <input type="text" class="layui-input" id="mctfPickUpTime">
        </div>
    </div>
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">处理状态</label>

        <div class="layui-input-block">
            <input type="text" id="mctfStatus" name="mctfStatus" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item" id="rejectDiv">
        <label class="layui-form-label">驳回原因</label>

        <div class="layui-input-block">
            <textarea name="mctfRejectReason" id="mctfRejectReason" placeholder="处理中，请您稍后" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item" style="margin-top: 10px; text-align: center">
        <div class="layui-btn" lay-filter="*" id="btn-submit">提交</div>
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
            ,url: '${pageContext.request.contextPath}/certification/getCertificationForAuditor.shtml' //数据接口
            ,page: true //开启分页
            ,cols: [[                  //标题栏
                {checkbox: true, sort: true, fixed: true, space: true}
                , {field: 'mctfId', title: 'ID', width: 80}
                , {field: 'mctfName', title: '标题', width: 200}
                , {field: 'mctfStatus', title: '状态', width:150}
                , {field: 'mctfCertificationTypeId', title: '证明类型', width:150}
                , {field: 'mvctAuditor', title: '处理人', style:'display:none;'}
                , {field: 'mvctDesc', title: '申请要求', style:'display:none;'}
                , {field: 'mctfRejectReason', title: '处理意见', style:'display:none;'}
                , {field: 'mctfAttachmentName', title: '附件地址', style:'display:none;'}
                , {field: 'mctfAttachmentUrl', title: '附件url', style:'display:none;'}
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
        $('table.layui-table thead tr th:eq(7)').addClass('layui-hide');
        $('table.layui-table thead tr th:eq(8)').addClass('layui-hide');
        $('table.layui-table thead tr th:eq(9)').addClass('layui-hide');

        // 监听工具条
        table.on('tool(noticeTab)', function(obj){ // tool工具条 参数为表格layer-filter的值
            var data = obj.data;
            if(obj.event === 'process'){
                process(data);
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
            $('table.layui-table thead tr th:eq(7)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(8)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(9)').addClass('layui-hide');
        });

        // 通过
        $('#btn-yes').on('click', function () {
            $('#mctfStatus').val('01');
            $('#agreeDiv').removeAttr('hidden');
            $('#rejectDiv').attr('hidden', 'hidden');
            layui.use('laydate', function(){
                var laydate = layui.laydate;

                //执行一个laydate实例
                laydate.render({
                    elem: '#mctfPickUpTime' //指定元素
                    ,done: function(value, date, endDate){
                        console.log(value); //得到日期生成的值，如：2017-08-18
                        console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                        console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
                        $('#mctfPickUpTime').val(value);
                    }
                });
            });
            layerIndex = layer.open({
                type: 1,
                title: '通过',
                area: ['800px', '550px'],
                content: $('#responseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 驳回
        $('#btn-no').on('click', function () {
            $('#mctfStatus').val('02');
            $('#rejectDiv').removeAttr('hidden');
            $('#agreeDiv').attr('hidden', 'hidden');
            layerIndex = layer.open({
                type: 1,
                title: '驳回',
                area: ['800px', '550px'],
                content: $('#responseForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
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
            reload();
        });

        /**
         * 处理申请
         */
        function process(data){
            if (data.mctfStatus=='新增') {
                $('#mctfId').val(data.mctfId);
                $('#mctfCertificationTypeId').val(data.mctfCertificationTypeId);
                $('#mvctDesc').val(data.mvctDesc);
                $('#mctfName').val(data.mctfName);
                $('#creator').val(data.creator);
                $('#organizationName').val(data.organizationName);
                if (data.mctfAttachmentUrl) {
                    $('#attachDownload').removeAttr('hidden');
                    var url = '${pageContext.request.contextPath}/' + data.mctfAttachmentUrl;
                    $('#download').attr('href', url);
                } else {
                    $('#attachDownload').attr('hidden', 'hidden');
                }
                layerIndex = layer.open({
                    type: 1,
                    title: '处理证明申请',
                    area: ['800px', '550px'],
                    content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                });
            } else {
                layer.alert('证明申请已处理，不能重复操作');
            }
        }

        /**
         * 处理证明申请
         */
        function submitCertification() {
            var certification = {};
            certification.mctfId = $('#mctfId').val();
            certification.mctfStatus = $('#mctfStatus').val();
            certification.mctfPickUpTime = $('#mctfPickUpTime').val();
            certification.mctfRejectReason = $('#mctfRejectReason').val();
            $.ajax({
                url : '${pageContext.request.contextPath}/certification/updateCertification.shtml',
                method : 'POST',
                data : certification,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        reload();
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
                    reload();
                },
                dataType : 'json'
            });
        }

        /**
         * 刷新数据表格
         */
        function reload() {
            noticeTab.reload();
            // 隐藏列标题
            $('table.layui-table thead tr th:eq(5)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(6)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(7)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(8)').addClass('layui-hide');
            $('table.layui-table thead tr th:eq(9)').addClass('layui-hide');
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

<%--
  Created by IntelliJ IDEA.
  User: Jexhen
  Date: 2018/11/20
  Time: 8:40
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
        <a class="layui-btn layui-btn-danger radius btn-delect" id="btn-delete-all">批量删除</a>
        <a class="layui-btn btn-add btn-default" id="btn-add">添加</a>
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
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</script>

<!--表单-->
<div id="articleForm" hidden="hidden" style="text-align: center; padding: 0px 5px 0px 5px">
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">文章ID</label>

        <div class="layui-input-inline">
            <input type="text" id="matcId" name="matcId" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item" hidden="hidden">
        <label class="layui-form-label">文章类型</label>

        <div class="layui-input-inline">
            <input type="text" id="matcType" name="matcType" autocomplete="off"
                   class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;margin-top: 10px">
        <input type="text" id="matcTitle" name="matcTitle" lay-verify="required" placeholder="请输入标题" autocomplete="off"
               class="layui-input">
    </div>
    <textarea id="matcContent" style="display: none;"></textarea>
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

    layui.use('table', function(){

        var table = layui.table;
        var layerIndex = 0;
        var layEditIndex;

        // 获取文章类型
        var queryString = location.search;
        var index = queryString.indexOf('=');
        var articleType = queryString.substr(index+1, queryString.length);

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
                , {field: 'matcContent', title: '文章', style:'display:none;'}
                , {field: 'matcType', title: '类型', width:150}
                , {field: 'matcOrganizationId', title: '组织', width:150}
                , {field: 'creator', title: '创建者', width:150}
                , {field: 'createTime', title: '创建时间', width:100, sort: true}
                , {field: 'modifier', title: '修改者', width:150}
                , {field: 'modifyTime', title: '修改时间', width:100, sort: true}
                , {fixed: 'right', title: '操作', width: 150, align: 'center', toolbar: '#operaitonBar'} //这里的toolbar值是模板元素的选择器
            ]]
            , where: {'isEdit':'1','articleType':articleType}
            , id: 'noticeTabId'
        });

        // 隐藏文章内容列标题
        $('table.layui-table thead tr th:eq(3)').addClass('layui-hide');

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
                    'matcTitle' : $('#query-matcTitle').val()
                    , 'articleType':articleType
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
            $('#matcId').val('');
            $('#matcType').val(articleType);
            $('#matcTitle').val('');
            layui.use('layedit', function(){
                layEditIndex = layEdit.build('matcContent',{
                    height: 300 //设置编辑器高度
                }); //建立编辑器
            });
            layEdit.setContent(layEditIndex,'');
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                area: ['800px', '550px'],
                content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        });

        // 表单提交
        $('#btn-submit').on('click',function () {
            submitArticle();
        });

        // 批量删除
        $('#btn-delete-all').on('click', function(){
            var checkStatus = table.checkStatus('noticeTabId'); //organizationTableId 即为基础参数 id 对应的值

            if (checkStatus.data.length) {
                var articles = checkStatus.data;
                var ids = [];
                for (var i = 0; i < articles.length; i++) {
                    ids.push(articles[i].matcId);
                }
                removeArticle(ids);
            }
        });

        /**
         * 编辑文章
         */
        function edit(data){
            $('#matcId').val(data.matcId);
            $('#matcTitle').val(data.matcTitle);
            $('#matcType').val(articleType);
            layui.use('layedit', function(){
                layEditIndex = layEdit.build('matcContent',{
                    height: 300 //设置编辑器高度
                    ,tool: [
                        'strong' //加粗
                        ,'italic' //斜体
                        ,'underline' //下划线
                        ,'del' //删除线

                        ,'|' //分割线

                        ,'left' //左对齐
                        ,'center' //居中对齐
                        ,'right' //右对齐
                        ,'link' //超链接
                        ,'unlink' //清除链接
                        ,'face' //表情
                        ,'image' //插入图片
                        ,'help' //帮助
                    ]
                }); //建立编辑器
            });
            layEdit.setContent(layEditIndex,data.matcContent);
            layerIndex = layer.open({
                type: 1,
                title: '编辑',
                area: ['800px', '550px'],
                content: $('#articleForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            });
        }

        /**
         * 提交文章
         */
        function submitArticle() {
            var matcId = $('#matcId').val();
            var url = '';
            if (matcId) {
                url = '${pageContext.request.contextPath}/article/modifyArticle.shtml';
            } else {
                url = '${pageContext.request.contextPath}/article/addArticle.shtml';
            }
            var article = {};
            article.matcId = matcId;
            article.matcTitle = $('#matcTitle').val();
            article.matcType = articleType;
            article.matcContent = layEdit.getContent(layEditIndex);
            $.ajax({
                url : url,
                method : 'POST',
                data : article,
                success : function(result) {
                    layer.alert(result.message);
                    if (result.success) {
                        layer.close(layerIndex);
                        noticeTab.reload();
                    }
                },
                dataType : 'json'
            });
        }

        /**
         * 删除文章
         * @param ids
         */
        function removeArticle(ids) {
            var url = '${pageContext.request.contextPath}/article/removeArticle.shtml'
            $.ajax({
                url : url,
                method : 'POST',
                data : {'ids' : ids},
                success : function(result) {
                    layer.alert(result.message);
                    noticeTab.reload();
                },
                dataType : 'json'
            });
        }
    });


</script>
</body>
</html>

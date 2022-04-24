
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>

    <base href="<%=basePath%>">
    <meta charset="utf-8" />
    <!-- 引入刚刚下载的 ECharts 文件 -->
    <script src="ECharts/echarts.min.js"></script>

    <script>
        $(function () {
            getCharts();
        });

        function getCharts() {


        var chartDom = document.getElementById('main');
        var myChart = echarts.init(chartDom);
        var option;



            option && myChart.setOption(option);}

    </script>
</head>
<body>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>
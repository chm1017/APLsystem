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
    <script src="jquery/jquery-1.11.1-min.js"></script>
    <script>
        $(function () {
            getCharts();
        });

        function getCharts() {

            var ROOT_PATH =
                'https://cdn.jsdelivr.net/gh/apache/echarts-website@asf-site/examples';

            var chartDom = document.getElementById('main');
            var myChart = echarts.init(chartDom);
            var option;

            myChart.showLoading();
            $.get(ROOT_PATH + '/data/asset/data/flare.json', function (data) {
                myChart.hideLoading();
                data.children.forEach(function (datum, index) {
                    index % 2 === 0 && (datum.collapsed = true);
                });
                myChart.setOption(
                    (option = {
                        tooltip: {
                            trigger: 'item',
                            triggerOn: 'mousemove'
                        },
                        series: [
                            {
                                type: 'tree',
                                data: [data],
                                top: '1%',
                                left: '7%',
                                bottom: '1%',
                                right: '20%',
                                symbolSize: 7,
                                label: {
                                    position: 'left',
                                    verticalAlign: 'middle',
                                    align: 'right',
                                    fontSize: 9
                                },
                                leaves: {
                                    label: {
                                        position: 'right',
                                        verticalAlign: 'middle',
                                        align: 'left'
                                    }
                                },
                                emphasis: {
                                    focus: 'descendant'
                                },
                                expandAndCollapse: true,
                                animationDuration: 550,
                                animationDurationUpdate: 750
                            }
                        ]
                    })
                );
            });

            option && myChart.setOption(option);

        }
    </script>
</head>
<body>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>
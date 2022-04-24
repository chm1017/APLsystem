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

            $.ajax({

                url : "workbench/chart/getProductNumber.do",
                data : {
                },
                type : "get",
                dataType : "json",
                success : function (data) {
                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main'));
                    const data1 = genData(data.dataList);
                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: '同名数量统计',
                            subtext: '纯属虚构',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },
                        legend: {
                            type: 'scroll',
                            orient: 'vertical',
                            right: 10,
                            top: 20,
                            bottom: 20,
                            data: data1.legendData
                        },
                        series: [
                            {
                                name: '姓名',
                                type: 'pie',
                                radius: '55%',
                                center: ['40%', '50%'],
                                data: data1.seriesData,
                                emphasis: {
                                    itemStyle: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                }
            })

        });

        function genData(list) {

            const legendData = [];
            const seriesData = [];
            for (var i = 0; i < list.length; i++) {
                var name =list[i].name;
                 var value=list[i].tol;
                legendData.push(name);
                seriesData.push({
                    name: name,
                    value: value
                });
            }
            return {
                legendData: legendData,
                seriesData: seriesData
            };
        }
    </script>
</head>
<body>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>
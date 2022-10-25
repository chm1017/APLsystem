
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>

    <base href="<%=basePath%>">
    <meta charset="utf-8" />

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <!-- 引入刚刚下载的 ECharts 文件 -->
    <script src="ECharts/echarts.min.js"></script>
    <script src="ECharts/echarts-gl.min.js"></script>

</head>
<body>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->
<div id="main" style="width: 1000px;height:800px;left:50px"></div>

<script>

    $(function () {
        $.ajax({
            url : "workbench/chart/getMPBoss.do",
            data : {
            },
            type : "get",
            dataType : "json",
            success : function (data) {
                var chartDom = document.getElementById('main');
                var myChart = echarts.init(chartDom);
                var option;
                var hours=data.m;
                var days = data.p;
                var data1 = data.data;
                option = {
                    tooltip: {},
                    visualMap: {
                        max: 20,
                        inRange: {
                            color: [
                                '#313695',
                                '#4575b4',
                                '#74add1',
                                '#abd9e9',
                                '#e0f3f8',
                                '#ffffbf',
                                '#fee090',
                                '#fdae61',
                                '#f46d43',
                                '#d73027',
                                '#a50026'
                            ]
                        }
                    },
                    xAxis3D: {
                        type: 'category',
                        data: hours
                    },
                    yAxis3D: {
                        type: 'category',
                        data: days
                    },
                    zAxis3D: {
                        type: 'value'
                    },
                    grid3D: {
                        boxWidth: 200,
                        boxDepth: 80,
                        viewControl: {
                        },
                        light: {
                            main: {
                                intensity: 1.2,
                                shadow: true
                            },
                            ambient: {
                                intensity: 0.3
                            }
                        }
                    },
                    series: [
                        {
                            type: 'bar3D',
                            data: data1.map(function (item) {
                                return {
                                    value: [item[1], item[0], item[2]]
                                };
                            }),
                            shading: 'lambert',
                            label: {
                                fontSize: 40,
                                borderWidth: 1
                            },
                            emphasis: {
                                label: {
                                    fontSize: 20,
                                    color: '#900'
                                },
                                itemStyle: {
                                    color: '#900'
                                }
                            }
                        }
                    ]
                };

                option && myChart.setOption(option);
            }
        })
    });
</script>
</body>
</html>
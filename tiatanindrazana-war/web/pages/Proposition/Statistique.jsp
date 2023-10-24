
  
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="map.Proposition.Maladie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

 Maladie  a = new Maladie();
 Maladie[] statM = a.statMaladie("maladie", null, 4);

%>

  <div class="wrapper">          
            <aside class="main-sidebar">

                <section class="sidebar">

                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="../../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Alexander Pierce</p>
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>

                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </form>

                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header"></li>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-dashboard"></i> <span>Maladie</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu" data-widget="tree">
                                <li><a href="module.jsp?but=Proposition/maladie-liste.jsp"><i class="fa fa-circle-o"></i> Liste</a></li>
                                <li><a href="module.jsp?but=/Proposition/maladie-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout</a></li>
                            </ul>
                        </li>
                        <li class="treeview" data-widget="tree">
                            <a href="#">
                                <i class="fa fa-files-o"></i>
                                <span>Plat</span>
                                <span class="pull-right-container">
                                    <span class="label label-primary pull-right"></span>
                                </span>
                            </a>
                            <ul class="treeview-menu" data-widget="tree">
                                <li><a href="module.jsp?but=Proposition/plat-liste.jsp"><i class="fa fa-circle-o"></i>Liste</a></li>
                                <li><a href="module.jsp?but=Proposition/plat-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout </a></li>                                                                
                            </ul>
                        </li>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-files-o"></i>
                                <span>Ingredient</span>
                                <span class="pull-right-container">
                                    <span class="label label-primary pull-right"></span>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="module.jsp?but=Proposition/ingredient-liste.jsp"><i class="fa fa-circle-o"></i>Liste</a></li>
                                <li><a href="module.jsp?but=Proposition/ingredient-saisie.jsp"><i class="fa fa-circle-o"></i> Ajout </a></li>                                                                
                            </ul>
                        </li>
                        <li>
                           <a href="module.jsp?but=Proposition/Statistique.jsp">
                                <i class="fa fa-th"></i> <span>Statistiques</span>
                                <span class="pull-right-container">
                                    <small class="label pull-right bg-green">new</small>
                                </span>
                            </a>
                        </li>
                        
                    </ul>
                </section>

            </aside>

            <div class="content-wrapper">

                <section class="content-header">
                    <h1>
                        Statistique
                        <small></small>
                    </h1>                    
                </section>

                <section class="content">
                    <div class="row">
                        <div class="col-md-6">

                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Maladies ou intolérances fréquentes</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="chart">
                                        <canvas id="areaChart" style="height:250px"></canvas>
                                    </div>
                                </div>

                            </div>


                            <div class="box box-danger">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Statistique des plats les plus demandés</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <canvas id="pieChart" style="height:250px"></canvas>
                                </div>

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Line Chart</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="chart">
                                        <canvas id="lineChart" style="height:250px"></canvas>
                                    </div>
                                </div>

                            </div>


                            <div class="box box-success">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Bar Chart</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="chart">
                                        <canvas id="barChart" style="height:230px"></canvas>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                </section>

            </div>
            <div class="control-sidebar-bg"></div>
        </div>

        <script>
            $(function () {
            /* ChartJS
             * -------
             * Here we will create a few charts using ChartJS
             */

            //--------------
            //- AREA CHART -
            //--------------

            // Get context with jQuery - using jQuery's .get() method.
            var areaChartCanvas = $('#areaChart').get(0).getContext('2d')
                    // This will get the first returned node in the jQuery collection.
                    var areaChart = new Chart(areaChartCanvas)

                    var areaChartData = {
                    labels  : ['Ulcère gastrique', 'Diarrhée', 'Diabète type 2', 'Fièvre'],
                            datasets: [                            
                            {
                            label               : 'Digital Goods',
                                    fillColor           : '#A85FD2',
                                    strokeColor         : '#A85FD2',
                                    pointColor          : '#A85FD2',
                                    pointStrokeColor    : '#A85FD2',
                                    pointHighlightFill  : '#A85FD2',
                                    pointHighlightStroke: '#A85FD2',
                                    data                : [6, 10, 9, 5]
                            }
                            ]
                    }

            var areaChartOptions = {
            //Boolean - If we should show the scale at all
            showScale               : true,
                    //Boolean - Whether grid lines are shown across the chart
                    scaleShowGridLines      : false,
                    //String - Colour of the grid lines
                    scaleGridLineColor      : 'rgba(0,0,0,.05)',
                    //Number - Width of the grid lines
                    scaleGridLineWidth      : 1,
                    //Boolean - Whether to show horizontal lines (except X axis)
                    scaleShowHorizontalLines: true,
                    //Boolean - Whether to show vertical lines (except Y axis)
                    scaleShowVerticalLines  : true,
                    //Boolean - Whether the line is curved between points
                    bezierCurve             : true,
                    //Number - Tension of the bezier curve between points
                    bezierCurveTension      : 0.3,
                    //Boolean - Whether to show a dot for each point
                    pointDot                : false,
                    //Number - Radius of each point dot in pixels
                    pointDotRadius          : 4,
                    //Number - Pixel width of point dot stroke
                    pointDotStrokeWidth     : 1,
                    //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
                    pointHitDetectionRadius : 20,
                    //Boolean - Whether to show a stroke for datasets
                    datasetStroke           : true,
                    //Number - Pixel width of dataset stroke
                    datasetStrokeWidth      : 2,
                    //Boolean - Whether to fill the dataset with a color
                    datasetFill             : true,
                    //String - A legend template
                    //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
                    maintainAspectRatio     : true,
                    //Boolean - whether to make the chart responsive to window resizing
                    responsive              : true
            }

            //Create the line chart
            areaChart.Line(areaChartData, areaChartOptions)

                    //-------------
                    //- LINE CHART -
                    //--------------
                    var lineChartCanvas = $('#lineChart').get(0).getContext('2d')
                    var lineChart = new Chart(lineChartCanvas)
                    var lineChartOptions = areaChartOptions
                    lineChartOptions.datasetFill = false
                    lineChart.Line(areaChartData, lineChartOptions)

                    //-------------
                    //- PIE CHART -
                    //-------------
                    // Get context with jQuery - using jQuery's .get() method.
                    var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
                    var pieChart = new Chart(pieChartCanvas)
                    var PieData = [
                    {
                    value    : 20,
                            color    : '#ffc8dd',
                            highlight: '#FFE2ED',
                            label    : 'plats principaux'
                    },
                    {
                    value    : 5,
                            color    : '#cdb4db',
                            highlight: '#C589E8',
                            label    : 'petit dejeuner'
                    },
                    {
                    value    : 5,
                            color    : '#a2d2ff',
                            highlight: '#83C3FF',
                            label    : 'plat de fête'
                    },
                    {
                    value    : 8,
                            color    : '#FF92BA',
                            highlight: '#f871a3',
                            label    : 'snacks'
                    }                    
                    ]
                    var pieOptions = {
                    //Boolean - Whether we should show a stroke on each segment
                    segmentShowStroke    : true,
                            //String - The colour of each segment stroke
                            segmentStrokeColor   : '#fff',
                            //Number - The width of each segment stroke
                            segmentStrokeWidth   : 2,
                            //Number - The percentage of the chart that we cut out of the middle
                            percentageInnerCutout: 50, // This is 0 for Pie charts
                            //Number - Amount of animation steps
                            animationSteps       : 100,
                            //String - Animation easing effect
                            animationEasing      : 'easeOutBounce',
                            //Boolean - Whether we animate the rotation of the Doughnut
                            animateRotate        : true,
                            //Boolean - Whether we animate scaling the Doughnut from the centre
                            animateScale         : false,
                            //Boolean - whether to make the chart responsive to window resizing
                            responsive           : true,
                            // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
                            maintainAspectRatio  : true,
                    }
            //Create pie or douhnut chart
            // You can switch between pie and douhnut using the method below.
            pieChart.Doughnut(PieData, pieOptions)

                    //-------------
                    //- BAR CHART -
                    //-------------
                    var barChartCanvas = $('#barChart').get(0).getContext('2d')
                    var barChart = new Chart(barChartCanvas)
                    var barChartData = areaChartData
                    barChartData.datasets[1].fillColor = '#00a65a'
                    barChartData.datasets[1].strokeColor = '#00a65a'
                    barChartData.datasets[1].pointColor = '#00a65a'
                    var barChartOptions = {
                    //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
                    scaleBeginAtZero        : true,
                            //Boolean - Whether grid lines are shown across the chart
                            scaleShowGridLines      : true,
                            //String - Colour of the grid lines
                            scaleGridLineColor      : 'rgba(0,0,0,.05)',
                            //Number - Width of the grid lines
                            scaleGridLineWidth      : 1,
                            //Boolean - Whether to show horizontal lines (except X axis)
                            scaleShowHorizontalLines: true,
                            //Boolean - Whether to show vertical lines (except Y axis)
                            scaleShowVerticalLines  : true,
                            //Boolean - If there is a stroke on each bar
                            barShowStroke           : true,
                            //Number - Pixel width of the bar stroke
                            barStrokeWidth          : 2,
                            //Number - Spacing between each of the X value sets
                            barValueSpacing         : 5,
                            //Number - Spacing between data sets within X values
                            barDatasetSpacing       : 1,
                            //Boolean - whether to make the chart responsive
                            responsive              : true,
                            maintainAspectRatio     : true
                    }

            barChartOptions.datasetFill = false
                    barChart.Bar(barChartData, barChartOptions)
            })
        </script>
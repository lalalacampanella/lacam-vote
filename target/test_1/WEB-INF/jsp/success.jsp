<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title>sudoku</title>
	<link rel="Stylesheet" href="static/css/main.css" />
    <link rel="Stylesheet" href="static/css/bootstrap.min.css" />
    <script language="javascript" type="text/javascript" src="static/js/jquery.js?126"></script>
    <script language="javascript" type="text/javascript" src="static/js/jquery.js?126"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var url = '/test_1/getRecord/';
            $.get(url,function(data){
                console.log(data);
            });
        });
    </script>
</head>
<body>
	<div id="tools" class="row">
        <div id="logo" class="col">
            琅琊榜
        </div>
        <div class="row" style="position:relative;width:80%;left:10%;">
            <table class="table table-striped" style="border:0px;">
  				<thead>
    				<tr>
     					<th>排名</th>
        				<th>id</th>
        				<th>数独分数</th>
        				<th>总分数</th>
    				</tr>
  				</thead>
  				<tbody id="rank">
    				<tr>
        				<th>1</th>
        				<th>qianqian</th>
        				<th>10000</th>
        				<th>10000</th>
    				</tr>
    				<tr>
        				<th>2</th>
        				<th>shijie</th>
        				<th>10</th>
        				<th>10</th>
    				</tr>
  				</tbody>
			</table>
        </div>
        <div id="err"></div>
    </div>
</body>


</html>
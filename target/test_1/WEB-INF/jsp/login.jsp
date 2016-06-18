<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>sudoku</title>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <link rel="Stylesheet" href="static/css/bootstrap.min.css" />
    <link rel="Stylesheet" href="static/css/main.css" />
    <script language="javascript" type="text/javascript" src="static/js/jquery.js?126"></script>
    <script language="javascript" type="text/javascript" src="static/js/sudoku.js"></script>
    <script language="javascript" type="text/javascript" src="static/js/mousewheel.js"></script>
    <script language="javascript" type="text/javascript" src="static/js/timers.js"></script>
    <script language="javascript" type="text/javascript" src="static/js/data.js?1"></script>
    <script language="javascript" type="text/javascript" src="static/js/blockUI.js?2"></script>
    <script language="javascript" type="text/javascript">
$(document).ready(function(){
                                  finit(0);
                                  $(this).keydown(function(event){
        if(event.keyCode==8||event.keyCode==46)
            $(g.selectedsquare).setempty();
        if(event.keyCode<58 && event.keyCode>48){
            $(g.selectedsquare).setnum(event.keyCode)
        }
    }).keyup(function(){$(g.selectedsquare).check();});
    document.oncontextmenu=function(e){return false;};
})
    </script>
</head>
<body><div class="container">
    <div id="tools" class="row">
        <div id="logo" class="col">
            SUDOKU
        </div>
        <div class="row" style="margin:0px;">
            <div class="col-sm-1"></div>
            <div id="level" class="col-sm-4">    
                Level:
            </div>
            <div class="col-sm-1"></div>
            <div id="timer" class="col-sm-4">
                Timer:
            </div>
        </div>
        
        <div id="btns" class="row">
            <input class="col-lg-3 btn btn-lg btn-info" type='button' value='Easy' onclick="$(g.canvas).gensukudo(2);$('#level').html('Level:'+$(this).val());">
            <input class="col-lg-2 btn btn-lg btn-info" type='button' value='Med' onclick="$(g.canvas).gensukudo(3);$('#level').html('Level:'+$(this).val());">
            <input class="col-lg-2 btn btn-lg btn-info" type='button' value='Hard' onclick="$(g.canvas).gensukudo(4);$('#level').html('Level:'+$(this).val());">
            <input class="col-lg-2 btn btn-lg btn-info" type='button' value='Restart' onclick="$('#SukudoTable').fadeOut(500);$('.c').each(function(){if(this.num()!=0)$(this).setempty().check();});$('#SukudoTable').fadeIn(500);">
            
        </div>
        <div id="err"></div>
    </div>
    <div id="canvas" style='position:relative;left:12%;'>      
    </div>
    <div class="row" style="margin:0px;">
        <div class="col-sm-1"></div>
        <div id="score" class="col-sm-4" style="font-size: 3em;">    
            Score:
        </div>
        <div id="player" class="col-sm-4" style="font-size: 3em;">    
            <input id="name" type="text" placeholder="ID在这里呀～" style="width:300px;">
        </div>
    </div>
    <div class="row" style="position:relative;margin-top:30px;left:20%;">
        <input class="col-lg-3 btn btn-lg btn-success" style="margin:20px;" type='button' value='upLoad the record！' onclick="">
        <input class="col-lg-3 btn btn-lg btn-warning" style="margin:20px;" type='button' value='see the rank list？' onclick="javascript:window.location.href='/test_1/rank'">       
    </div>
    
</div></body>
</html>

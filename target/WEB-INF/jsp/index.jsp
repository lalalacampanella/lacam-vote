<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
    </head>
    <style>
* {
    padding:0px;
    margin:0px;
}
            body {
                text-align:center;
            } 
            #listJoiner {
                margin-top:20px;
                text-align:left;
            }
            .floatRight {
                float:right;
            }
    </style>
    <body>

        <div data-role="page" id="homepage">
            <div data-role="header">
                <h1>æç¥¨ç»è®¡ç³»ç»</h1>
            </div>

            <div data-role="content">
                <div id="homeShow">
                    <div style="width:80%;margin:0 auto;">
                        <canvas id="homeCanvas" witdh="400" height="400"></canvas>
                    </div>
                    <div id="homeWord" style="opacity:0;">
                        <h1 style="padding-bottom:20px">æç¥¨ç»è®¡ç³»ç»</h1>
                        <a href="#pushVote" data-role="button" data-inline="true">åèµ·æç¥¨</a>
                        <a href="#showVote" data-role="button" data-inline="true">æ¥çå·²ææç¥¨</a>
                    </div>
                </div>
            </div>
        </div> 

        <div data-role="page" id="pushVote">
            <div data-role="header">
                <h1>åèµ·æç¥¨</h1>
            </div>

            <div data-role="content">
                <form method="post" action="demoform.asp">
                    <div data-role="fieldcontain">
                        <label for="title">æ é¢ï¼</label>
                        <input type="text" name="title" id="title" />

                        <label for="describe">æè¿°ï¼</label>
                        <textarea name="describe" id="describe"> </textarea>

                        <label for="startdate">å¼å§æ¶é´ï¼</label>
                        <input type="date" name="startdate" id="startdate"/>

                        <label for="enddate">ç»ææ¶é´ï¼</label>
                        <input type="date" name="enddate" id="enddate"/>
                        <div id="joiner">
                            <h2 style="margin-top:50px">ç«éè</h2>
                            <input type="text" name="joiner1" id="joiner1"/>
                        </div>
                    </div>
                </form>
                <input type="button" id="addJoiner" value="æ·»å ç«éè" data-inline="true"/>
                <a href="#confirmSubmit" data-role="button" data-inline="true" data-rel="dialog">ç¡®è®¤</a>
            </div> 
        </div>

        <div data-role="page" id="confirmSubmit">
            <div data-role="content">
                <h1>æ¯å¦ç¡®è®¤åèµ·æç¥¨ï¼</h1>
                <a id="voteNow" href="#" data-role="button" data-inline="true">ç¡®è®¤åèµ·</a>
            </div>
        </div> 

        <div data-role="page" id="showVote">
            <div data-role="header">
                <h1>å±ç¤ºæç¥¨</h1>
            </div>

            <div data-role="content">
                <ul data-role="listview" data-inset="true">
                    <li><a href="#vote" class="voteList" tag="1">èèå¥½ç½</a></li>
                    <li><a href="#vote" class="voteList" tag="1">èèå¥½ç½</a></li>
                    <li><a href="#vote" class="voteList" tag="1">èèå¥½ç½</a></li>
                    <li><a href="#vote" class="voteList" tag="1">èèå¥½ç½</a></li>
                    <li><a href="#vote" class="voteList" tag="1">èèå¥½ç½</a></li>
                </ul>
            </div>
        </div> 

        <div data-role="page" id="vote">
            <div data-role="header">
                <h1>æç¥¨</h1>
            </div>

            <div data-role="content">
                <h1>vote</h1>
                <p>èèå¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½å¥½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½ç½å¥½ç½</p>
                <form method="post" action="demoform.asp">
                    <fieldset data-role="fieldcontain">
                        <label for="day">éæ©å¤©</label>
                        <select name="day" id="day" data-native-menu="false">
                            <option value="mon">ææä¸</option>
                            <option value="tue">ææäº</option>
                            <option value="wed">ææä¸</option>
                            <option value="thu">ææå</option>
                            <option value="fri">ææäº</option>
                            <option value="sat">ææå­</option>
                            <option value="sun">æææ¥</option>
                        </select>
                    </fieldset>
                    <input type="submit" data-inline="true" value="æäº¤">
                </form>
            </div>
        </div> 

        <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
        <script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.min.js"></script>
        <script>
window.onload=function(){
    var randomNum = function(max) {
        return Math.round(Math.random() * max)+1;
    }
    var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };
    var randomColorFactor = function() {
        return Math.round(Math.random() * 255);
    };
    var randomColor = function(opacity) {
        return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',' + (opacity || '.3') + ')';
    };
    ininum = randomNum(10);
    initdata = []; initback = [];
    for (var i = 0; i < ininum; i ++) {
                initdata.push(randomScalingFactor());
                initback.push(randomColor(0.7));
                }

                var homeConfig = {
                type: 'pie',
                data: {
                datasets: [{
                data: initdata,
                backgroundColor: initback,
                }],
                labels: initback
                },
                options: {
                responsive: true,
                legend: {
                display: false
                },
                tooltips: {
                enabled: false,
                }
                }
                };
                var homeCtx = document.getElementById("homeCanvas").getContext("2d");
                window.myPie = new Chart(homeCtx, homeConfig);
                }
                $('#homeWord').fadeTo(1000, 1);
                ///>






                $('#voteNow').click(function(){
                    console.log("wawa");
                })
$('#addJoiner').on('click', function(){
    console.log()
        var nowNum = parseInt($($(joiner).find('input')[$(joiner).find('input').length - 1]).attr('id').substr(-1))+1;
    $(joiner).append('<input type="text" name="joiner'+nowNum+'" id="joiner'+nowNum+'" data-inline="true"/>').trigger('create');
})


        </script>
    </body>
</html>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="static/css/jquery.mobile-1.3.2.min.css">
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
            div[data-role="content"] {
                display:none;
            }
    </style>
    <body>

        <div data-role="page" id="homepage">
            <div data-role="header">
                <h1>投票统计系统</h1>
            </div>

            <div data-role="content">
                <div id="homeShow">
                    <div style="width:80%;margin:0 auto;">
                        <canvas id="homeCanvas" witdh="400" height="400"></canvas>
                    </div>
                    <div id="homeWord" style="display:none;">
                        <h1 style="padding-bottom:20px">投票统计系统</h1>
                        <a href="#pushVote" data-role="button" data-inline="true">发起投票</a>
                        <a href="#showVote" data-role="button" data-inline="true">查看已有投票</a>
                    </div>
                </div>
            </div>
        </div> 

        <div data-role="page" id="pushVote">
            <div data-role="header">
                <a href="#" data-role="button" data-icon="back" data-theme="b" data-rel="back">返回</a>
                <h1>发起投票</h1>
            </div>

            <div data-role="content">
                <form method="post">
                    <div data-role="fieldcontain">
                        <label for="title">标题：</label>
                        <input type="text" name="title" id="title" />

                        <label for="describe">描述：</label>
                        <textarea name="describe" id="describe"> </textarea>

                        <label for="startdate">开始时间：</label>
                        <input type="date" name="startdate" id="startdate"/>

                        <label for="enddate">结束时间：</label>
                        <input type="date" name="enddate" id="enddate"/>
                        <div id="joiner">
                            <h2 style="margin-top:50px">竞选者</h2>
                            <input type="text" name="joiner1" id="joiner1"/>
                        </div>
                    </div>
                </form>
                <input type="button" id="addJoiner" value="添加竞选者" data-inline="true"/>
                <a href="#confirmSubmit" data-role="button" data-inline="true" data-rel="dialog">确认</a>
            </div> 
        </div>

        <div data-role="page" id="confirmSubmit">
            <div data-role="content">
                <h1>是否确认发起投票？</h1>
                <a id="voteNow" href="#" data-role="button" data-inline="true">确认发起</a>
                <a href="#" data-role="button" data-icon="back" data-theme="b" data-rel="back">取消</a>
            </div>
        </div> 

        <div data-role="page" id="showVote">
            <div data-role="header">
                <a href="#" data-role="button" data-icon="back" data-theme="b" data-rel="back">返回</a>
                <h1>展示投票</h1>
            </div>

            <div data-role="content">
                <ul data-role="listview" data-inset="true" id="showVoteList">
                    <li><a href="#vote" class="voteList" tag="1">芊芊好白</a></li>
                </ul>
            </div>
        </div> 

        <div data-role="page" id="vote">
            <div data-role="header">
                <a href="#" data-role="button" data-icon="back" data-theme="b" data-rel="back">返回</a>
                <h1>投票</h1>
            </div>

            <div data-role="content">
                <div id="nowVote" style="display:none">
                    <h1 id="nowVoteTitle"></h1>
                    <p id="nowVoteText"></p>
                    <form method="post">
                        <fieldset data-role="fieldcontain">
                            <label for="joiner_id">选择要投给的人：</label>
                            <select name="joiner_id" id="joiner_id" data-native-menu="false">
                            </select>
                        </fieldset>
                    </form>
                    <input data-inline="true" value="提交" id="submitVote" type="button"/>
                </div>
                <div id="checkVote" style="width:80%; margin:0 auto; display:none;">
                    <canvas id="barCanvas" witdh="400" height="400"></canvas>
                    <canvas id="pieCanvas" witdh="400" height="400"></canvas>
                </div>
                <a href="#addJoinerPage" data-role="button" data-rel="dialog">添加竞选者</a>
            </div>
        </div> 

        <div data-role="page" id="addJoinerPage">
            <div data-role="header">
                <a href="#" data-role="button" data-icon="back" data-theme="b" data-rel="back">返回</a>
                <h1>添加竞选者</h1>
            </div>
            <div data-role="content">
                <div id="moreJoiner">
                    <input type="text" name="moreJoiner1" id="moreJoiner1"/>
                </div>
                <input type="button" id="addMoreJoiner" value="添加竞选者" data-inline="true"/>
                <input data-inline="true" value="提交" id="addJoinerSubmit" type="button"/>
            </div>
        </div> 

        <script src="static/js/jquery-1.8.3.min.js"></script>
        <script src="static/js/jquery.mobile-1.3.2.min.js"></script>
        <script src="static/js/Chart.min.js"></script>
        <script src="static/js/main.js"></script>
        <script>
        </script>
    </body>
</html>

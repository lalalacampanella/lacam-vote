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
    if (window.location.hash!='' || window.location.hash!='#'){
        window.location.hash='';
    }
    $.ajax({
        type : 'GET',
        contentType : 'application/json',
        url : 'getVote',
        processData : false,
        dataType : 'json',
        success : function(res) {
            $('div[data-role="content"]').show();
            var ininum = randomNum(10);
            var initdata = []; var initback = [];
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
            $('#homeWord').fadeIn();

            console.log(res);
            $('#showVoteList').html('');
            for (var i = 0; i < res.length; i++) {
                //>
                $('#showVoteList').append('<li><a href="#vote" class="voteList" corner="'+ i +'" tag="'+ res[i].id +'">'+ res[i].title +'</a></li>').trigger('create');
            }
            $('.voteList').on('click', function(){
                console.log("inin")
                var i = parseInt($(this).attr('corner'));
                var vote_id = parseInt($(this).attr('tag'));
                $('#checkVote').hide();
                $('#nowVote').hide();
                if ( res[i].haveVote === true ) {
                    $('#checkVote').show();
                    $('#nowVote').attr('vote_id',vote_id);
                    var initdata= {
                        datasets: [{
                            data: [],
                            backgroundColor: []
                        }],
                        labels: []
                    }
                    for (var j = 0; j < res[i].joiners.length; j ++) {
                        initdata.datasets[0].data.push(res[i].joiners[j].number);
                        initdata.datasets[0].backgroundColor.push(randomColor());
                        initdata.labels.push(res[i].joiners[j].name);
                    }
                    var pieConfig = {
                        type: 'pie',
                        data: initdata,
                        options: {
                            responsive: true,
                            legend: {
                                position: 'right'
                            },
                            tooltips: {
                                enabled: false
                            },
                            legend: {
                                display: false
                            },
                            title: {
                                display: true,
                                text: '票数统计'
                            }
                        }
                    };
                    var barConfig = {
                        type: 'horizontalBar',
                        data: initdata,
                        options: {
                            responsive: true,
                            legend: {
                                position: 'right'
                            },
                            tooltips: {
                                enabled: false
                            },
                            legend: {
                                display: false
                            },
                            title: {
                                display: true,
                                text: '票数统计'
                            }
                        }
                    };
                    var barCtx = document.getElementById("barCanvas").getContext("2d");
                    window.myBar = new Chart(barCtx, barConfig);
                    var pieCtx = document.getElementById("pieCanvas").getContext("2d");
                    window.myVotePie = new Chart(pieCtx, pieConfig);
                    $('#checkVote').show();
                }
                else {
                    console.log('show');
                    var circle = '';
                    for ( var j = 0; j < res[i].joiners.length; j++ ) {
                        circle += '<option value="'+ res[i].joiners[j].id +'">'+ res[i].joiners[j].name +'</option>';
                    }
                    $('#joiner_id').html('');
                    $('#joiner_id').append(circle);
                    $('#nowVote').attr('vote_id',vote_id);
                    $('#nowVoteTitle').html(res[i].title);
                    $('#nowVoteText').html(res[i].text);
                    $('#joiner_id').selectmenu();
                    $('#joiner_id').selectmenu('refresh');
                    $('#nowVote').show();
                }
            })
        },
        error : function() {
            alert('Err...');
        }
    });
    $('#submitVote').on('click', function(){
        data = JSON.stringify({'vote_id':$('#nowVote').attr('vote_id'),'joiner_id':$('#joiner_id').val()});
        console.log(data);
        $.ajax({
            type : 'POST',
            contentType : 'application/json',
            url : 'voteFor',
            processData : false,
            dataType : 'json',
            data : data,
            success : function(res) {
                console.log(res)
            },
            error : function() {
                alert('Err...');
            }
        });
    })
    $('#voteNow').on('click',function(){
        inputs = $('#joiner').find('input');
        joiner = '';
        for ( var i = 0; i < inputs.length; i++ ) {
            if (i != 0) {
                joiner += ',';
            }
            joiner +=$(inputs[i]).val();
        }
        data = JSON.stringify({'title':$('#title').val(), 'text':$('#describe').val(), 'start_time':$('#startdate').val(), 'end_time':$('#enddate').val(),'joiner':joiner});
        console.log(data);
        $.ajax({
            type : 'POST',
            contentType : 'application/json',
            url : 'uploadVote',
            processData : false,
            dataType : 'json',
            data : data,
            success : function(res) {
                console.log(res)
            },
            error : function() {
                alert('Err...');
            }
        });
    })
    $('#addJoinerSubmit').on('click',function(){
        inputs = $('#moreJoiner').find('input');
        joiner = '';
        for ( var i = 0; i < inputs.length; i++ ) {
            if (i != 0) {
                joiner += ',';
            }
            joiner +=$(inputs[i]).val();
        }
        data = JSON.stringify({'vote_id':$('#nowVote').attr('vote_id'), 'joiner_id':joiner});
        console.log(data);
        $.ajax({
            type : 'POST',
            contentType : 'application/json',
            url : 'moreJoiner',
            processData : false,
            dataType : 'json',
            data : data,
            success : function(res) {
                console.log(res)
            },
            error : function() {
                alert('Err...');
            }
        });
    })
    $('#addJoiner').on('click', function(){
        var nowNum = parseInt($($('#joiner').find('input')[$('#joiner').find('input').length - 1]).attr('id').substr(-1))+1;
        $('#joiner').append('<input type="text" name="joiner'+nowNum+'" id="joiner'+nowNum+'" data-inline="true"/>').trigger('create');
    })
    $('#addMoreJoiner').on('click', function(){
        var nowNum = parseInt($($('#moreJoiner').find('input')[$('#moreJoiner').find('input').length - 1]).attr('id').substr(-1))+1;
        $('#moreJoiner').append('<input type="text" name="moreJoiner'+nowNum+'" id="moreJoiner'+nowNum+'" data-inline="true"/>').trigger('create');
    })
}

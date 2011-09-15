var selected = '';
var target_html = {};
function with_json_request(url,fn) {
    $.ajax({
        url: url,
        type: 'GET',
        datatype: 'json',
        success: fn
    });
}
function with_metadata(pid,fn) {
    with_json_request('../resolve.py?detail=head&format=json&pid='+pid,fn);
}
function with_mosaic(pid,size,fn) {
    with_json_request('../mosaic.py?format=json&size='+size+'&pid='+pid,fn);
}
function describe_bin(pid,tag) {
    with_metadata(pid,function(bin) {
        var instrument = bin['instrument']
        var time = bin['time'];
        var temp = Math.round(bin['temperature'])+'&deg;C';
        $('#'+tag+'d').html('<br>IFCB#'+instrument+' '+time+' (<abbr class="timeago" title="'+time+'"></abbr>), '+temp).find('abbr').timeago();
    });
}
function render(bin,width,size,tag,targetLinks) {
    describe_bin(bin['pid'],tag);
    with_mosaic(bin['pid'], size, function(mosaic) {
        var tile, x, y, w, h, pid;
        var scale = width / mosaic['width'];
        var canvas = $('#'+tag+'c')[0];
        var ctx;
        if(canvas.getContext == undefined) {
            alert('This browser does not support canvas.');
        } else {
            ctx = canvas.getContext('2d');
        }
        var img = new Image();
        $(img).bind('load', function(event) {
            ctx.drawImage(this, 0, 0, width, width * 0.5625); // 16:9
        });
        img.src = '../mosaic.py?format=jpg&size='+size+'&pid='+bin['pid'];
        if(!targetLinks) {
	    $(canvas).unbind('click');
            $(canvas).bind('click', {date:bin['time']}, function(event) {
                asof(event.data.date);
                window.history.pushState('ignore', 'IFCB Dashboard', 'dashboard.html?date='+event.data.date);
            });
        }
        ctx.fillStyle = '#999'; /* gray */
        ctx.fillRect(0,0,mosaic['width'] * scale,mosaic['height'] * scale);
        var tiles = mosaic['tiles']
        ctx.fillStyle = '#bbb'; /* light gray */
        for(i = 0; i < mosaic['tiles'].length; i++) {
            tile = mosaic['tiles'][i];
            x = tile['x'] * scale;
            y = tile['y'] * scale;
            w = tile['width'] * scale;
            h = tile['height'] * scale;
            pid = tile['pid'];
            ctx.fillRect(x+1,y+1,w-2,h-2);
            if(targetLinks) {
                $('#'+tag+'c').bind('click',{left:x, top:y, w:w, h:h, right:x+w, bottom:y+h, pid:pid},function(event) {
                    mx = event.pageX - $(this).offset().left;
                    my = event.pageY - $(this).offset().top;
                    if(mx >= event.data.left && mx <= event.data.right &&
                       my >= event.data.top && my <= event.data.bottom) {
                        location.href = event.data.pid+'.html';
                    }
                });
                $('#'+tag+'c').bind('mousemove',{left:x, top:y, w:w, h:h, right:x+w, bottom:y+h, pid:pid, tag:tag},function(event) {
                    mx = event.pageX - $(this).offset().left;
                    my = event.pageY - $(this).offset().top;
                    if(mx >= event.data.left && mx <= event.data.right &&
                       my >= event.data.top && my <= event.data.bottom) {
                        if(selected != event.data.pid) {
                            ctx.drawImage(img, 0, 0, width, width * 0.5625);
                            ctx.strokeStyle = '#f00'; // red
                            ctx.strokeRect(event.data.left+1, event.data.top+1, event.data.w-2, event.data.h-2);
                            selected = event.data.pid;
                            // TODO show metadata for the thang
                            showTheMetadataForTheThang(event.data.pid);
                            // TODO remove the highlights from previous selection
                        }
                    }
                });
            }
       }
    });
}
function asof(date,fn) {
    $('#topc').unbind('click');
    $('#topc').unbind('mousemove');
    with_json_request('../rss.py?format=json&date='+date, function(bin) {
        render(bin[0],800,'medium','top',true);
        for (index = 1; index <= 6; index++) {
            render(bin[index],264,'small','s'+index,false);
        }
    });
}
function keys(obj) {
    var keys = [];
    for(var key in obj) {
        if(obj.hasOwnProperty(key)) {
            keys.push(key);
        }
    }
    return keys;
}
function showTheMetadataForTheThang(pid) {
    if(pid in target_html) {
        $('#metadata').html(target_html[pid]);
    } else {
        with_metadata(pid, function(target) {
		html = '<img width="224px" src="'+pid+'.jpg">';
		for(var key in target) {
		    if(target.hasOwnProperty(key)) {
			var text = key + ': ' + target[key];
			html += '<div>' + text + '</div>';
		    }
		}
                target_html[pid] = html;
                if(selected == pid) {
                    $('#metadata').html(html);
                }
	    });
    }
}

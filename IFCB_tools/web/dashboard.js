var selected = '';
var target_html = {};
var aspect_ratio = 0.5625; /* 16:9 */
var time_series_prefix = '/mvco';
function read_prefix() {
    var regex = /.*\/\/[^\/]+(\/[^\/]+)\/.*/;
    var groups = regex.exec(window.location.href);
    time_series_prefix = groups[1];
}
function with_json_request(url, fn) {
    $.ajax({
        url : url,
        type : 'GET',
        dataType : 'json',
        success : fn
    });
}
function with_metadata(pid, fn) {
    with_json_request(pid+'/head.json', fn);
}
function with_mosaic(pid, size, fn) {
    with_json_request(pid+'/mosaic/small.json',fn);
}
function describe_bin(pid, tag) {
    /* generate a short description of the bin */
    with_metadata(pid, function(bin) {
        var instrument = bin['instrument']; /* instrument number */
        var time = bin['time']; /* time */
        var dayhref = pid.replace(/(IFCB._\d+_\d+).*/,'$1.html');
        var time_href = time.replace(/(\d+-\d+-\d+)/,'<a href="'+dayhref+'">$1</a>');
        var time_href = time_href.replace(/(\d\d:\d\d:\d\d)/,'<a href="'+pid+'.html">$1</a>');
        var temp = Math.round(bin['temperature']) + '&deg;C'; /* temperature */
        $('#' + tag + 'd').html('<br>IFCB#' + instrument + ' ' + time_href + ' (<abbr class="timeago" title="' + time + '"></abbr>), ' + temp + ' (<a href="'+pid+'.csv">CSV</a> <a href="'+pid+'.xml">XML</a> <a href="'+pid+'.rdf">RDF</a>)').find('abbr').timeago();
        /* "timeago" converts absolute time to constantly updated relative time e.g., "about 5 minutes ago" */
    });
}
/* draw a mosaic for a bin and add behavior to it */
function render(bin, width, size, tag, targetLinks) {
    var ctx;
    var canvas = $('#' + tag + 'c')[0];
    /* describe the bin based on its metadata */
    describe_bin(bin['pid'], tag);
    if (canvas.getContext == undefined) {
        alert('This browser does not support canvas.');
    } else {
        ctx = canvas.getContext('2d');
    }
    ctx.fillStyle = '#999'; /* gray */
    ctx.fillRect(0, 0,  width, width * aspect_ratio);
    /* get the mosaic layout */
    with_mosaic(bin['pid'], size, function(mosaic) {
        var tile, x, y, w, h, pid;
        var scale = width / mosaic['width'];
        var red = 0;
        /* load the mosaic image */
        var img = new Image();
        $(img).bind('load', function(event) {
            ctx.drawImage(this, 0, 0, width, width * aspect_ratio); // 16:9
            red = 1;
        });
        img.src = bin['pid'] + '/mosaic/' + size + '.jpg';
        /* on the top mosaic, targetLinks is true and a click takes you to the target */
        /* on the smaller mosaics, targetLinks is false and a click changes the date to the date of the bin */
        if (!targetLinks) {
            $(canvas).bind('click', {
                date : bin['time']
            }, function(event) {
                /* change the date */
                push_date(event.data.date);
            });
        }
        /* while the image is loading, draw its layout as a bunch of gray boxes */
        /* fill the background in darker gray */
        ctx.fillStyle = '#999'; /* gray */
        ctx.fillRect(0, 0, mosaic['width'] * scale, mosaic['height'] * scale);
        var tiles = mosaic['tiles']
        ctx.fillStyle = '#bbb'; /* light gray */
        /* for each tile */
        for (i = 0; i < mosaic['tiles'].length; i++) {
            tile = mosaic['tiles'][i];
            x = tile['x'] * scale;
            y = tile['y'] * scale;
            w = tile['width'] * scale;
            h = tile['height'] * scale;
            pid = tile['pid'];
            /* draw a light gray rectangle where it is */
            ctx.fillRect(x + 1, y + 1, w - 2, h - 2);
            /* if we're linking to targets, */
            if (targetLinks) {
                $(canvas).bind('click', {
                    left : x,
                    top : y,
                    w : w,
                    h : h,
                    right : x + w,
                    bottom : y + h,
                    pid : pid
                }, function(event) {
                    mx = event.pageX - $(this).offset().left;
                    my = event.pageY - $(this).offset().top;
                    /* then a click in this rectangle */
                    if (mx >= event.data.left && mx <= event.data.right && my >= event.data.top && my <= event.data.bottom) {
                        /* takes us to its target */
                        location.href = event.data.pid + '.html';
                    }
                });
            }
            /* moving around highlights the target in a red box */
            $(canvas).bind('mousemove', {
                left : x,
                top : y,
                w : w,
                h : h,
                right : x + w,
                bottom : y + h,
                pid : pid,
                tag : tag
            }, function(event) {
                mx = event.pageX - $(this).offset().left;
                my = event.pageY - $(this).offset().top;
                if (mx >= event.data.left && mx <= event.data.right && my >= event.data.top && my <= event.data.bottom) {
                    /* hovering over this rectangle means to select this target */
                    if (selected != event.data.pid) { /* if it's not already selected */
                        if(red==1) {
                            ctx.drawImage(img, 0, 0, width, width * aspect_ratio); /* erase any current selection by redrawing the mosaic */
                            ctx.strokeStyle = '#f00'; // red
                            /* draw the red rectangle */
                            ctx.strokeRect(event.data.left + 1, event.data.top + 1, event.data.w - 2, event.data.h - 2);
                        }
                        selected = event.data.pid; /* note that we've done it */
                        showTheMetadataForTheThang(event.data.pid); /* display this target's metadata */
                    }
                }
            });
            /* if we're leaving this canvas we need to erase any lingering selection rectangles */
            $(canvas).bind('mouseleave', function(event) {
                if(red==1) {
                    ctx.drawImage(img, 0, 0, width, width * aspect_ratio);
                }
            });
        }
    });
}
/* change the date */
function asof(date, fn) {
    /* clear the handlers */
    $('#topc').unbind('click').unbind('mousemove').unbind('mouseleave');
    /* fetch the feed */
    with_json_request(time_series_prefix+'/feed.json&date=' + date, function(bin) {
        /* the first item is the large (800px wide) mosaic at the top */
        render(bin[0], 800, 'medium', 'top', true);
        /* the following 4 items are the small mosaics below */
        for (index = 1; index <= 6; index++) {
            /* clear handlers */
            $('#s' + index + 'c').unbind('click').unbind('mousemove').unbind('mouseleave');
            render(bin[index], 264, 'small', 's' + index, false);
        }
    });
}
function showTheMetadataForTheThang(pid) {
    if (pid in target_html) { /* look to see if we've already cached this metadata description */
        $('#metadata').html(target_html[pid]);
    } else {
        /* otherwise make the AJAX call to get the metadata */
        with_metadata(pid, function(target) {
            /* draw a half-size image */
            var h = target['width'] * 0.5;
            var w = target['height'] * 0.5;
            html = '<img width="' + w + 'px" height="' + h + '" src="' + pid + '.jpg">';
            /* now show all the metadata key/value pairs as divs */
            for ( var key in target) {
                if (target.hasOwnProperty(key)) {
                    var text = key + ': ' + target[key];
                    html += '<div>' + text + '</div>';
                }
            }
            target_html[pid] = html; /* cache the html */
            if (selected == pid) {
                /* check to make sure this target is still selected; the user may have selected another
                 * target in the time it took the AJAX call to return */
                $('#metadata').html(html);
            }
        });
    }
}

// given a date, draw an analog clock face in a canvas
function clock(ctx,x,y,w,h,date) {
    ctx.save();
    // draw the numbers
    var diameter = Math.min(w,h);
    var scale = Math.min(w,h);
    var fs = scale / 7.5;
    ctx.font = fs+"px sans-serif";
    ctx.textAlign = "center";
    ctx.translate(x+(w/2),y+(h/2));
    // translate down proportional to font size
    ctx.save();
    var r = diameter * 0.4;
    for(var n = 0; n <= 60; n++) {
        ctx.save();
        ctx.rotate((Math.PI / 30) * n);
        ctx.beginPath();
        if(n % 5 == 0) {
            ctx.lineWidth = 0.6;
            ctx.moveTo(0,0-(r*1.02));
        } else {
            ctx.lineWidth = 0.5;
            ctx.moveTo(0,0-(r*1.09));
        }
        ctx.lineTo(0,0-(r*1.13));
        ctx.stroke();
        ctx.restore();
    }
    for(var n = 1; n <= 12; n++) {
        ctx.save();
        ctx.translate(0,r*0.05);
        ctx.rotate((Math.PI / 6) * n);
        ctx.translate(0,0-(r*0.8));
        ctx.rotate(0 - (Math.PI / 6) * n);
        ctx.fillText(n+"",0.75,r*(fs*0.0125));
        ctx.moveTo(0,r)
        ctx.restore();
    }
    ctx.restore();
    // compute scale factor for entire ifc
    ctx.scale(scale,scale);
    ctx.lineWidth = 1.5/scale;
    //
    ctx.beginPath();
    ctx.arc(0,0,0.48,0,Math.PI*2,false);
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(0,0,0.04,0,Math.PI*2,false);
    ctx.fill();
    // big hand
    ctx.save();
    ctx.lineWidth = 1.5/scale;
    ctx.rotate(((date.getMinutes() / 60) + (date.getSeconds() / 60 / 60)) * Math.PI * 2);
    ctx.beginPath();
    ctx.moveTo(0,0.1);
    ctx.lineTo(0,-0.45);
    ctx.stroke();
    ctx.restore();
    // small hand
    ctx.save();
    ctx.lineWidth = 1.5/scale;
    ctx.rotate(((date.getHours() / 12) + (date.getMinutes() / 60 / 12)) * Math.PI * 2);
    ctx.beginPath();
    ctx.moveTo(0,0);
    ctx.lineTo(0,-0.25);
    ctx.stroke();
    ctx.restore();
    //
    ctx.restore();
}

// draws a thermometer in the given rectangle, with
// text below it indicating the temperature
// ctx - a graphics context from a canvas
// x - leftmost coord of rectangle
// y - topmost coord of rectangle
// w - width of rectangle
// h - height of rectangle
// value - numerical value (e.g., in degrees)
// min - minimum value (value at the top of the bulb)
// max - maximum value (value at the top of the stem)
// text - suffix to append to the value text (e.g., "F")
// the value zero is shown as a bulb full of mercury
// with no mercury in the stem.
// negative values are shown as a partially-filled bulb.
// the maximum value will show as mercury up to the top
// of the stem.
function thermometer(ctx,x,y,w,h,value,min,max,text) {
    ctx.save();
    // compute scale factor for entire ifc
    var scale = Math.min(w,h) / 10;
    // write the temperature value
    var fs = 3.25 * scale;
    ctx.font = fs+"px sans-serif";
    ctx.textAlign = "center";
    ctx.fillText(value+text,x+(w/2),y+h-2);
    // set up our coordinate transform
    ctx.translate(x+(w/2),y+(h/2));
    ctx.scale(scale,scale);
    ctx.translate(0,-1);
    ctx.lineWidth = 1.5/scale;
    // build the thermometer shape
    ctx.beginPath();
    ctx.moveTo(-1,3);
    ctx.lineTo(-1,-5);
    ctx.arc(0,-5,1,0-Math.PI,0,false);
    ctx.lineTo(1,3);
    ctx.arc(0,4.5,2,0-(Math.PI/3),Math.PI*1.33,false);
    // stroke the thermometer shape
    ctx.stroke();
    // clip to the thermometer shape
    ctx.clip();
    // fill the thermometer with red
    ctx.fillStyle = "red";
    // draw mercury
    var normalizedValue = (value - min) / (max - min);
    ctx.fillRect(-2,6.5,4,-4-(normalizedValue/0.12));
    // restroke to get the interior of the outline
    ctx.stroke();
    //
    ctx.restore();
}
function [timestamp] = utcdate(dt,useMs)
% Return a Matlab date (e.g., "now") in ISO8601 UTC format
% e.g., "2011-09-22T15:45:38Z"
if nargin < 2 || isempty(useMs),
    useMs = false;
end

import java.text.SimpleDateFormat;
import java.util.TimeZone;
import java.util.Date;

if useMs,
    fmt = 'yyyy-MM-dd''T''HH:mm:ss''.''SSS''Z''';
else
    fmt = 'yyyy-MM-dd''T''HH:mm:ss''Z''';
end
dateFormatUtc = SimpleDateFormat(fmt);
dateFormatUtc.setTimeZone(TimeZone.getTimeZone('UTC'));
dv = datevec(dt);
d = Date(dv(1)-1900, dv(2)-1, dv(3), dv(4), dv(5), dv(6));
if useMs,
    d = Date(d.getTime() + floor(rem(dt * 86400000,1000)));
end
timestamp = char(dateFormatUtc.format(d));
end
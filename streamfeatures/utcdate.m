function [timestamp] = utcdate(dt)
% Return a Matlab date (e.g., "now") in ISO8601 UTC format
% e.g., "2011-09-22T15:45:38Z"
import java.text.SimpleDateFormat;
import java.util.TimeZone;
import java.util.Date;

dateFormatUtc = SimpleDateFormat('yyyy-MM-dd''T''HH:mm:ss''Z''');
dateFormatUtc.setTimeZone(TimeZone.getTimeZone('UTC'));
dv = datevec(dt);
d = Date(dv(1)-1900, dv(2)-1, dv(3), dv(4), dv(5), dv(6));

timestamp = char(dateFormatUtc.format(d));
end
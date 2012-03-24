function [ ] = logmsg( msg, debug )
if nargin < 2 || isempty(debug),
    debug = false;
end
if debug,
    dm = '[DEBUG] ';
else
    dm ='';
end;
disp([dm utcdate(now) ' ' msg]);
end


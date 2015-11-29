function [ r ] = webwrap( fn )
% pass a handle to a webread or other MATLAB web API
% and this catches exceptions and sets a status code
% on an output structure

try
    r = fn();
    r.http = 200;
catch exc
    s = get_status_code(exc);
    if s > 0
        r = struct('http',s);
    else
        rethrow(exc);
    end
end


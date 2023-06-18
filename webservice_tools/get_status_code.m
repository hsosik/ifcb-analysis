function [ r ] = get_status_code ( exc )
% get the HTTP status code from an exception thrown by webwrite
% exc - the exception

r = 0;

re = 'MATLAB:webservices:HTTP(?<status>...)StatusCodeError';
groups = regexp(exc.identifier,re,'names');
if ~isempty(groups)
    r = str2double(groups.status);
end

end

 
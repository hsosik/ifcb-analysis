function [ classlist_str, classlist_num ] = classlist2classstr( classlist_in, class2use )
%   function [ classlist_str, classlist_num ] = classlist2classstr( classlist_in, class2use )
%   Take classlist from manual files as input, expects 3 colums: {'roi number'  'manual'  'auto'}
%   output one result column that combines any auto results with manual
%   correction, outputs both cell array of class strings and column of
%   corresponding indices into class2use
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

%   Update later to handle possible subdivide columns

classlist_num = classlist_in(:,3);
ii = find(~isnan(classlist_in(:,2)));
classlist_num(ii) = classlist_in(ii,2);
classlist_str = class2use(classlist_num)';
end


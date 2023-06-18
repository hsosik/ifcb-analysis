function [ n, class_all, varargin ] = handle_train_class2skip( class2use, class2skip, n, class_all, varargin )
% function [ n, varargin ] = handle_train_class2skip( class2use, class2skip, n, varargin )
% ifcb-analysis; function called by compile_train_features*; subsample a training set to remove classes to be skipped
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2017


for classcount = 1:length(class2skip),
    ind = strmatch(class2skip(classcount),class2use,'exact');
    if isempty(ind),
        disp([class2skip(classcount) ' does not exist in class2use; skip aborted' ])
    else
        ii = find(class_all == ind);
        class_all(ii) = [];
        for vc = 1:length(varargin)
            varargin{vc}(ii,:) = [];
        end
        n(ind) = 0;
    end
end;

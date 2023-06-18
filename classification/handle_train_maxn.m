function [ n, class_all, varargin ] = handle_train_maxn( class2use, maxn, class_all, varargin )
% function [ n, class_all, varargin ] = handle_train_maxn( class2use, maxn, class_all, varargin )
% ifcb-analysis; function called by compile_train_features*; randomly subsample a training set to limit maximum number of cases in any
% one class
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2017


for classcount = 1:length(class2use),
    ii = find(class_all == classcount);
    n(classcount) = size(ii,1);
    n2del = n(classcount)-maxn;
    if n2del > 0,
        shuffle_ind = randperm(n(classcount));
        shuffle_ind = shuffle_ind(1:n2del);
        class_all(ii(shuffle_ind)) = [];
        for vc = 1:length(varargin)
            varargin{vc}(ii(shuffle_ind),:) = [];
        end
        n(classcount) = maxn;
    end;
end;

end


function [ n, class_all, varargin ] = handle_train_minn( minn, n, class_all, varargin )
% function [ n, class_all, varargout ] = handle_train_minn( minn, n, class_all, vargargin );
% ifcb-analysis; function called by compile_train_features*; subsample a
% training set to remove classes with less than the specified miniumum
% number of examples
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2017


ind = find(n < minn);
for icount = 1:length(ind)
   ii = find(class_all == ind(icount)); 
   class_all(ii) = [];
   for vc = 1:length(varargin)
     varargin{vc}(ii,:) = [];
   end
   n(ind(icount)) = 0;
end


function [ n, class_all, class2use, varargin ] = handle_train_class2group( class2use, class2group, maxn, n, class_all, varargin )
% function [ n, class_all, class2use, varargin ] = handle_train_class2group( class2use, class2group, maxn, n, class_all, varargin )
% ifcb-analysis; function called by compile_train_features*; subsample a training set to group specified classes
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2017

for classcount = 1:length(class2group{1})
    num2group = length(class2group{1}{classcount});
    if num2group > 1
        class2group{1}{classcount} = sort(class2group{1}{classcount}); %alphabetize
        [~, ~, indc] = intersect(class2group{1}{classcount},class2use);   
        if length(indc) ~= length(class2group{1}{classcount})
            [class_missing] = setdiff(class2group{classcount}, class2use);
            disp('grouping aborted; Missing:')
            disp(class_missing)
        else
            newclass = char(class2group{1}{classcount}(1));
            for ii = 2:length(class2group{1}{classcount})
                newclass = [newclass ',' char(class2group{1}{classcount}(ii))];
            end;
            class2use = [class2use newclass]; %add new class label to end of list
            ind2group = ismember(class_all,indc, 'rows');
            ind2group = find(ind2group); %indices of original classes
            class_all(ind2group) = length(class2use); %reset class number to new grouped class
            n = [n length(ind2group)]; %add count for new class to end of list
            n(indc) = 0; %reset original classes to 0 count
            n2del = n(end)-maxn;
            if n2del > 0, %randomly remove some if more than maxn
                shuffle_ind = randperm(n(end));
                shuffle_ind = shuffle_ind(1:n2del);
                class_all(ind2group(shuffle_ind)) = [];
                for vc = 1:length(varargin)
                    varargin{vc}(ind2group(shuffle_ind),:) = [];
                end
                %fea_all(ind2group(shuffle_ind),:) = [];
                %files_all(ind2group(shuffle_ind)) = [];
                %roinum(ind2group(shuffle_ind)) = [];
                n(end) = maxn; %reset new class count to maxn
            end
        end
    else
        disp('grouping requires more than one class; aborting grouping for:')
        disp(class2group{classcount})
    end
end

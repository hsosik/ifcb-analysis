clear all 

load 'C:\Users\Emily Fay\Documents\Ciliate_Code\Summary\ciliate_abundance_manual_11Jul2013.mat'

%  for x=1:length(ciliate_label)
%     for y=1:length(ciliate_label)
%         Ciliate_pairwise(x).(ciliate_label{x})=[Ciliate_week_mean_mat(:,x), Ciliate_week_mean_mat(:,y)];
%     end 
% end
% 
for x=1:length(ciliate_label)
       Ciliate_mix_pairwise.(ciliate_label{x})=[Ciliate_week_mean_mat(:,1), Ciliate_week_mean_mat(:,x)]; 
end 
% 
%     for x=1:length(ciliate_label)
%     for y=1:length(ciliate_label)
%         Ciliate_pairwise=[Ciliate_week_mean_mat(:,x), Ciliate_week_mean_mat(:,y)];
%     end 
%     end
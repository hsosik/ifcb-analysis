function [ mhd ] = ModHausdorffDistKDT( A, B )

a_kdt = KDTreeSearcher(A);
b_kdt = KDTreeSearcher(B);

[~, fhd] = knnsearch(a_kdt,B,'K',1);
[~, rhd] = knnsearch(b_kdt,A,'K',1); % this can be optimized by pruning A

mhd = max(mean(fhd), mean(rhd));

end


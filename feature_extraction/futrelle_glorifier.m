clear;
%d = uigetdir();
%d2 = uigetdir();
dr = '/Users/jfutrelle/dev/workspace/ifcb/IFCB_tools/stitch/IFCB5_2010_264_102403';
d = '/Users/jfutrelle/dev/workspace/ifcb/IFCB_tools/stitch/IFCB5_2010_264_102403_orig';
d2 = '/Users/jfutrelle/dev/workspace/ifcb/IFCB_tools/stitch/IFCB5_2010_264_102403_r212';
disp(d);
rfs = dir([d '/*.png']);
for i = 1:length(rfs),
    name = char(rfs(i).name);
    if regexp(name,'.*_[a-z]+.png'),
        disp(['skipping ' name]);
    else
        pnr = [dr '/' strrep(name,'.png','_mask.png')];
        pn = [d '/' name];
        pn2 = [d2 '/' name];
        imgr = imread(pnr,'png');
        img = imread(pn,'png');
        img2 = imread(pn2,'png');
        [M m] = phasecong3(imgr, 4, 6, 2, 2.5, 0.55, 2.0, 0.3, 5,-1);
        pcr = M + m;
        [M m] = phasecong3(img, 4, 6, 2, 2.5, 0.55, 2.0, 0.3, 5,-1);
        pc = M + m;
        [M m] = phasecong3(img2, 4, 6, 2, 2.5, 0.55, 2.0, 0.3, 5,-1);
        pc2 = M + m;
        pc_diff = pc .* pcr;
        pc2_diff = pc2 .* pcr;
        pc_sum = sum(sum(pc_diff));
        pc2_sum = sum(sum(pc2_diff));
        if pc2_sum < pc_sum,
            label = 'Joe wins';
        else
            label = 'Heidi wins';
        end;
        if pc_sum > 0 & pc2_sum > 0,
         figure(98), clf;
         subplot(3,3,1), imshow(imgr), title('mask');
         subplot(3,3,4), imshow(pcr), title('pc3(mask)');
         subplot(3,3,2), imshow(img), title('Heidi stitch');
         subplot(3,3,5), imshow(pc), title('pc3(Heidi)');
         subplot(3,3,8), imshow(pc_diff * 10), title('pc3(Heidi) * pc3(mask)');
         subplot(3,3,3), imshow(img2), title('Joe stitch');
         subplot(3,3,6), imshow(pc2), title('pc3(Joe)');
         subplot(3,3,9), imshow(pc2_diff * 10), title('pc3(Joe) * pc3(mask)');
         subplot(3,3,7), bar([pc_sum, pc2_sum]), title(label);
         pause
        end;
    end
end 
function [ target ] = blob_binary_symmetry( target )

target.blob_props.B180 = NaN(1,max(1,target.blob_props.numBlobs));
target.blob_props.B90 = target.blob_props.B180;
target.blob_props.Bflip = target.blob_props.B180;

if target.blob_props.numBlobs > 0,
    for i = 1:target.blob_props.numBlobs,
        [b180, b90, bflip] = binary_symmetry(target.rotated_blob_images{i});
        target.blob_props.B180(i) = b180;
        target.blob_props.B90(i) = b90;
        target.blob_props.Bflip(i) = bflip;
    end;
end

end


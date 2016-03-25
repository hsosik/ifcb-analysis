function [ target ] = blob_binary_symmetry( target )

if target.blob_props.numBlobs > 0,
    for i = 1:target.blob_props.numBlobs,
        [b180, b90, bflip] = binary_symmetry(target.rotated_blob_images{i});
        target.blob_props.B180(i) = b180;
        target.blob_props.B90(i) = b90;
        target.blob_props.Bflip(i) = bflip;
    end;
else %empty blob image
    % not sure what to do here - jf
end

end


function [ target ] = blob_invmoments( target )
% given blob mask, return 7 invariant momemts from
% from DIPUM function invmoments (http://www.imageprocessingplace.com/)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

invarmom = invmoments(target.blob_image); 

target.blob_props.moment_invariant1 = invarmom(1);
target.blob_props.moment_invariant2 = invarmom(2);
target.blob_props.moment_invariant3 = invarmom(3);
target.blob_props.moment_invariant4 = invarmom(4);
target.blob_props.moment_invariant5 = invarmom(5);
target.blob_props.moment_invariant6 = invarmom(6);
target.blob_props.moment_invariant7 = invarmom(7);

end


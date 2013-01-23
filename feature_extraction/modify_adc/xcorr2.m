function c = xcorr2(a,b)
%XCORR2 Two-dimensional cross-correlation.
%   XCORR2(A,B) computes the crosscorrelation of matrices A and B.
%   XCORR2(A) is the autocorrelation function.
%
%   See also CONV2, XCORR and FILTER2.

%   Author(s): M. Ullman, 2-6-86
%   	   J.N. Little, 6-13-88, revised
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.9 $  $Date: 2002/11/21 15:47:07 $

if nargin == 1
	b = a;
end

c = conv2(a, rot90(conj(b),2));


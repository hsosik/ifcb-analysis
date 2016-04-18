%Getfeatures.m should call this function and append fw to features1
%Kaccie Li, summer 2005
%Joe Futrelle made optimizations 9/2011

function fw = getRW_fast(img)

dim = 301; %we will work with a 301 by 301 matrix when representing
% fearow = 1; %91 features now 7/19/2005
% featitles = {'total power' 'power ratio' 'w1' 'w2' 'w3' 'w4' 'w5' 'w6' 'w7'...
% 'w8' 'w9' 'w10' 'w11' 'w12' 'w13' 'w14' 'w15' 'w16' 'w17' 'w18' 'w19'...
% 'w20' 'w21' 'w22' 'w23' 'w24' 'w25' 'w26' 'w27' 'w28' 'w29' 'w30' 'w31'...
% 'w32' 'w33' 'w34' 'w35' '36' 'w37' 'w38' 'w39' 'w40' 'w41' 'w42' 'w43'...
% 'w44' 'w45' 'w46' 'w47' 'w48'...
% 'r1' 'r2' 'r3' 'r4' 'r5' 'r6' 'r7' 'r8' 'r9' 'r10' 'r11' 'r12' 'r13'...
% 'r14' 'r15' 'r16' 'r17' 'r18' 'r19' 'r20' 'r21' 'r22' 'r23' 'r24' 'r25'...
% 'r26' 'r27' 'r28' 'r29' 'r30' 'r31' 'r32' 'r33' 'r34' 'r35' 'r36' 'r37'...
% 'r38' 'r39' 'r40' 'r41' 'r42' 'r43' 'r44' 'r45' 'r46' 'r47' 'r48' 'r49' 'r50'};

persistent ring_cell wedge_cell
if isempty(ring_cell),
    load RW %mat file that contain ring and wedge masks
    % FIXME RW.mat assumes that dim is 301
end;

persistent filter mask
if isempty(filter),
    disp('# getRW_fast precomputing');
    %define coordinates in frequency space
    df = (1/(dim-1))*(1/6.45);
    f = -0.5/6.45: df :0.5*1/6.45;

    %calculate the area (circular) needed in the center to obtain 85% of total
    %spectral power
    [x, y] = meshgrid(f,f);
    [~, r] = cart2pol(x,y);
    filter = r > 15*df;
    mask = 1 - filter;
    clear x
    clear y
end

%pixel_pitch = 6.45; %microns  %Heidi 11/29/11 seems unused

%Begin the fourier transform part
amp_trans = fftshift(fft2(img));
int_trans = (amp_trans.*conj(amp_trans));

% now resize intensity matrix to dim x dim
[h, w] = size(int_trans);
y = linspace(1,h,dim);
x = linspace(1,w,dim);
[Y, X] = meshgrid(x,y);
int_trans = interp2(int_trans,Y,X);

clear amp_trans;
clear input_image;

filter_img = mask.*int_trans;
inner_int = sum(sum(filter_img));
total_int = sum(sum(int_trans));
pwr_ratio = inner_int/total_int; %this may be used as another feature
clear inner_int total_int

wedge_int_trans = filter.*int_trans; %filter out "dc" portion for wedges
%only half of the int_trans is needed
%wedge_half = zeros(301,301);
%ring_half = zeros(301,301);
%for ii = 152:301
%    for jj = 1:301
%       wedge_half(ii,jj) = wedge_int_trans(ii,jj);
%        ring_half(ii,jj) = int_trans(ii,jj);
%    end
%end
half = [zeros(301,151) ones(301,150)]';
wedge_half = half .* wedge_int_trans;
ring_half = half .* int_trans;

%calculate the mask sum of wedges and save them as vectors
for ii = 1:size(wedge_cell,2)
    wedge_mat{ii} = wedge_cell{ii}.*wedge_half;
    wedge_vector(ii,1) = sum(sum(wedge_mat{ii}));            
end 
for ii = 1:size(ring_cell,2)
    ring_mat{ii} = ring_cell{ii}.*ring_half;
    ring_vector(ii,1) = sum(sum(ring_mat{ii}));      
end 

clear wedge_half ring_half
%"total_wedge" equals "total_ring"
pwr_integral = sum(wedge_vector);%both wedge or ring vectors are same
fw = [pwr_integral; pwr_ratio; wedge_vector./pwr_integral;...
    ring_vector/pwr_integral];%this is the primary output of the function
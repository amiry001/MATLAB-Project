close all;
clear;
filename = 'img/flower.jpg';

img = imread(filename);
img = double(img);

a = 24;  % Quantization Factor 

img_smooth = img;
%% Apply Median Filter to remove Salt and Pepper noise
img_smooth(:,:,1) = medfilt2(img(:,:,1),[7,7]);
img_smooth(:,:,2) = medfilt2(img(:,:,2),[7,7]);
img_smooth(:,:,3) = medfilt2(img(:,:,3),[7,7]);

%%
for i=1:3
    %Apply 
    img_smooth = toonifying(img_smooth,10,20,3);
end
filtered = img_smooth;

edges = edgedetectoin(img);
edges = edges/max(edges(:));
cartoon_img = filtered;

%
for i = 1:3
    % Quantize the Values
    t = a*floor(filtered(:,:,i)./a);
    t(edges>0.18) = 0;
    cartoon_img(:,:,i) = t;
end

figure
subplot(1,4,1)
imshow(mat2gray(img));
title('Original')
subplot(1,4,2)
imshow(mat2gray(filtered));
title('Smoothing')
subplot(1,4,3)
imshow(edges);
title('Edges')
subplot(1,4,4)
imshow(mat2gray(cartoon_img));
title('Cartoon')

% figure
% imshow(mat2gray(img));
% title('Original')
% figure
% imshow(mat2gray(cartoon_img));
% title('Cartoon')
% figure
% imshow(edges);
% title('Edges')
% figure
% imshow(mat2gray(filtered));
% title('Smoothing')
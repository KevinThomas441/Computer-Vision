img1 = imread('bicycle.bmp');
img1 = im2double(img1);
img1 = rgb2gray(img1);

img2 = imread('motorcycle.bmp');
img2 = im2double(img2);
img2 = rgb2gray(img2);

hs = 20;
filtersize = 512;

lowpassfilter = fspecial('gaussian', hs*2+1, 6);
fft_img1 = fft2(img1, filtersize, filtersize);
fft_lowpass = fft2(lowpassfilter, filtersize, filtersize);
lowpassed_image = ifft2(fft_img1.*fft_lowpass);
lowpassed_image = lowpassed_image(1+hs:size(img1,1)+hs, 1+hs:size(img1,2)+hs);

lowpassfilter = fspecial('gaussian', hs*2+1, 3.5);
fft_img2 = fft2(img2, filtersize, filtersize);
fft_lowpass = fft2(lowpassfilter, filtersize, filtersize);
img2_filtered = ifft2(fft_img2.*fft_lowpass);
img2_filtered = img2_filtered(1+hs:size(img2,1)+hs, 1+hs:size(img2,2)+hs);
highpassed_image = img2 - img2_filtered;

hybrid_image = real(lowpassed_image + highpassed_image);
figure, imshow(lowpassed_image), title("Low Passed Image");
figure, imshow(highpassed_image), title("High Passed Image");
figure, imshow(hybrid_image), title("Hybrid Image");
imwrite(hybrid_image, "Motorbicyle.bmp");




  

% Please edit this function only, and submit this Matlab file in a zip file
% along with your PDF report

function [left_x, right_x, left_y, right_y] = eye_detection(img)
% INPUT: RGB image
% OUTPUT: x and y coordinates of left and right eye.
% Please rewrite this function, and submit this file in Canvas (in a zip file with the report).
left_x = 100;
right_x = 300;
left_y = 50;
right_y = 50;
img = rgb2gray(img);
resize = 0;
[m n] = size(img);
while (m>2000 || n>2000)
    img = imresize(img, 0.9);
    resize = resize + 1;
    [m n] = size(img);
end
img = imgaussfilt(img, 0.3);
img = imcrop(img, [1 1 n (3*m)/4]); 
e = edge(img, 'Canny', 0.65);
sens = 0.7;
col = zeros(100);
circles=0;
flag = 0;
while circles ~= 2 && sens <1
    [col ~] = imfindcircles(e, [6 15], 'ObjectPolarity', 'bright', 'Sensitivity', sens);
    [circles , ~] = size(col);
    if circles>2 && sens<1 
        sens = (sens - 0.01);
        flag = flag+1;
    elseif circles<2
        sens = (sens + 0.01);
        flag = flag+1;
    end
    if ((sens>0.99 && circles~=2) || flag>30)
        break
    end
end
if circles >=2
    if(col(1, 1)<col(2,1))
        lx = col(1, 1);
        rx = col(2, 1);
        ly = col(1, 2);
        ry = col(2, 2);
    else
        lx = col(2, 1);
        rx = col(1, 1);
        ly = col(1, 2);
        ry = col(2, 2);
    end
    while(resize~=0)
        lx  =lx + (0.1*lx);
        rx = rx + (0.1*rx);
        ly = ly + (0.1*ly);
        ry = ry + (0.1*ry);
        resize = resize-1;
    end
left_x = lx;
right_x = rx;
left_y = ly;
right_y = ry;
end
end
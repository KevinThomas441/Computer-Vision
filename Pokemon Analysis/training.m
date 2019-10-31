clear all;
image_path = './train/';
image_dir = dir([image_path,'*HP*']);
image_size = length(image_dir);
ID_label = zeros(image_size,1);
image_vector=[];
%letter_templates= load('letter_templates.mat')
for i = 1:image_size
    name = image_dir(i).name;
    idx = strfind(name,'_'); 
    ID_label(i) = str2double(name(1:idx(1)-1));
    img1 = imread([image_path,image_dir(i).name]);
    [y,x]=size(img1);
    img2 = imcrop(img1, [0, 0, x, 0.3*y]); 
    img2 = imresize(img2,[600 600]);
      if size(img2,3)==3
        img2 = rgb2gray(img2);
        img2 = imgaussfilt(img2);
      end
     [r, c] = size(img2);
    I = reshape(img2, [r*c, 1]);
        image_vector=[image_vector, I];
    
end
    fprintf('Done! ---> With image vector');
%%%%%%%%%%%%%%%%%%%%%%%%%%% Generate%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% the first %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% principle %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% component%%%%%%%%%%%%%%%

%Mean of all the images
image_mean = mean(image_vector,2);
fprintf('Done! ---> With image mean');
% Calculating the standard deviation of each image from the mean
[y,x] = size(image_vector);
image_sd = ones(y,x);

for i=1:image_size
    vector= double(image_vector(:,i));
    image_sd(:,i) = vector- image_mean;
end

image_cv = cov(image_sd);
[eigen_vector, eigen_value] = eig(image_cv);

% forming the Eigenvector face vector
eigenvectorfeature =[];
eigenvector = eigen_vector' * image_sd';

for i=1:image_size
        temp = eigenvector * image_sd(:,i);
        eigenvectorfeature = [eigenvectorfeature temp];
end
save('model.mat','eigenvectorfeature','eigenvector','image_mean','ID_label','-v7.3');
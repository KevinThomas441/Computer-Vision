function predict_label = your_kNN(feat)
% Output should be a fixed length vector [num of img, 1]. 
% Please do NOT change the interface.
% predict_label = zeros(size(feat,1),1); %dummy. replace it with your own code

img_path = './train/';
class_num = 30;
img_per_class = 55;
img_num = class_num .* img_per_class;
feat_dim = size(feature_extraction(imread('./train/Balloon/329000.JPG')),2);

folder_dir = dir(img_path);
KNN = zeros(img_num,feat_dim);
label = zeros(img_num,1);


for i = 1:length(folder_dir)-2
    
    img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
    end
    
     label((i-1)*img_per_class+1:i*img_per_class) = i;
    
    for j = 1:length(img_dir)        
        img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
        KNN((i-1)*img_per_class+j,:) = feature_extraction(img);
    end
    
end
%model = fitcknn(KNN,label,'OptimizeHyperparameters','auto',...
%    'HyperparameterOptimizationOptions',...
%    struct('AcquisitionFunctionName','expected-improvement-plus'));

%display(size(KNN));
%display(size(label));

model = fitcknn(KNN, label,'NumNeighbors', 20,'Standardize',1, 'BreakTies', 'nearest');
predict_label = predict(model,feat);

end
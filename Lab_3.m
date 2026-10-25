%% Lab 03 - Machine Learning Lab Matlab Script Template
% Traffic Sign Classification Using Machine Learning

%% Step 1: Data Import
trainingAnnotationsFolder = '3B_training_image_annotations';
testingAnnotationsFolder = '3B_test_image_annotations';
trainingImagesFolder = '3B_training_images';
testingImagesFolder = '3B_test_images';

[trainingFilenames, trainingLabels] = parseAnnotations(trainingAnnotationsFolder);
[testingFilenames, testingLabels] = parseAnnotations(testingAnnotationsFolder);

% % Display labels and sample images
% sampleIdx = [1 10 15 25 50];
% 
% figure(1)
% tiledlayout("horizontal")
% for i = 1:5
%     nexttile
%     imshow(trainingFilenames{sampleIdx(i)})
%     title(strcat(trainingFilenames{sampleIdx(i)}, ": ", trainingLabels{sampleIdx(i)}))
% end

%% Step 2: Feature Extraction for Training Data;
features = extractFeatures(trainingFilenames, trainingImagesFolder);

[N,C,S] = normalize(features)

%% Step 3: Train K-Nearest Neighbors (KNN) Model
knnModel = fitcknn(N, transpose(trainingLabels), 'NumNeighbors', 1, ...
    'ClassNames', {'stop', 'crosswalk', 'speedlimit'});

%% Step 4: Feature Extraction for Test Data
features2 = extractFeatures(testingFilenames, testingImagesFolder);

N2 = normalize(features2,"center",C,"scale",S)


%% Step 5: Evaluate the Model
predictedLabels = predict(knnModel, N2); % no fitcknn here
confMat = confusionmat(transpose(testingLabels), predictedLabels);
confusionchart(confMat, {'stop', 'crosswalk', 'speedlimit'});
title('KNN Model Confusion Matrix - Test Data');
accuracy = sum(strcmp(transpose(testingLabels), predictedLabels)) / length(testingLabels);
disp(['Test Accuracy: ', num2str(accuracy*100), '%']);

%% Function for Feature Extraction
function features = extractFeatures(filenames, folder)
features = [];

    for i = 1:length(filenames)
        imgFile = fullfile(folder, filenames{i});

        img_original = imread(imgFile);
        img = img_original;
        % Add your feature extraction code here
        % Convert to gray scale
        

        gimg = im2gray(img);

        binaryImg = imbinarize(gimg);

        imgopened = bwareaopen(binaryImg,1000);

        imgfilled = imfill(imgopened,'holes');

        stats = regionprops(imgfilled, 'Area', 'BoundingBox','Circularity','SubarrayIdx','Perimeter',"MajorAxisLength",'MinorAxisLength');  
        [~, idx] = max([stats.Area]);  

         
         largestRegion = stats(idx);
         subIdx = largestRegion.SubarrayIdx;

        perimeter = stats.Perimeter;

         circularity = stats.Circularity;

         croppedRGB = img(subIdx{:}, :);
        

        
        meanR = mean(croppedRGB(:,:,1), 'all');
        meanG = mean(croppedRGB(:,:,2), 'all');
        meanB = mean(croppedRGB(:,:,3), 'all');

        
        sumRGB = meanR + meanG + meanB;
        r_ratio = meanR/sumRGB; g_ratio = meanG/sumRGB; b_ratio = meanB/sumRGB;

        boundbox = largestRegion.BoundingBox; 

        %Debug Lines
        %imshow(croppedRGB);
        %imshowpair(img,temp,'montage');
        %rectangle('Position', boundbox, 'EdgeColor', 'r', 'LineWidth', 2);

        featureVector = [r_ratio,g_ratio,b_ratio,perimeter, circularity, meanR, meanG, meanB, boundbox];
        features = [features; featureVector];

    end

end
# Traffic Sign Classification (KNN)

## Overview
A MATLAB-based K-Nearest Neighbors (KNN) classification model designed to identify and categorize traffic signs (Stop, Crosswalk, Speed Limit). This project focuses on custom image processing and physical feature extraction to train a lightweight machine learning classifier.

<img width="917" height="543" alt="KNN_Result_Table" src="https://github.com/user-attachments/assets/f95a406a-1617-4988-9286-320e93c984c0" />


**Dependencies:** 
* MATLAB
* Statistics and Machine Learning Toolbox (for KNN model training)

## Methodology & Feature Extraction
Instead of relying on deep learning black boxes, this model extracts explicit geometric and color-based features from raw images:
* **Image Preprocessing:** Converts images to grayscale, applies binarization, and utilizes morphological operations (hole filling, area thresholding) to isolate the target sign.
* **Geometric Feature Extraction:** Calculates bounding box dimensions, perimeter, and circularity using region properties.
* **Color Space Analysis:** Extracts RGB ratios from the isolated regions to differentiate signs based on standardized traffic colors.
* **Classification:** Normalizes the extracted feature vectors and trains a K-Nearest Neighbors (KNN) model, evaluated via a confusion matrix and test accuracy metrics.

## Repository Structure
* `traffic_sign_knn.m`: Main execution script containing feature extraction logic, model training, and performance evaluation. *(Note: Renamed from Lab_3B_template)*
* `parseAnnotations.m`: Helper function to parse image dataset annotations (Provided by university).
* `normalizationParams.mat`: Required parameter file for data normalization.

*Note: The raw image datasets (training and testing) have been intentionally excluded from this repository.*

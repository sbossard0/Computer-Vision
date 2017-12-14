%% cv_driver.m
% This is the main file the some computer vision techniques
%Images provided
clear;
close all;

%Initial Image Readings
im_pic1   = imread('pic1.tif');
im_pic2   = imread('pic2.jpg');
bright = imread('brightness.jpg');
bchrome = imread('bchrominance.jpg');
rchrome = imread('rchrominance.jpg');
bcDec2x2 = imread('bcDecimation2.jpg');
bcDec4x4 = imread('bcDecimation4.jpg');
rcDec2x2 = imread('rcDecimation2.jpg');
rcDec4x4 = imread('rcDecimation4.jpg');

%Quantize an image
%Quantize a real number
%Enter real number, # of levels, min value, max value
quantize(241,4,100,240);
quantize(241.1,32,0,255);

%Quantize an image
Enter image & #bits per pixel
quantizeImg(im_pic1,6)
quantizeImg(im_pic1,3)

%Color Transform
colorTransform(im_pic2);

%Decimation
decimation(bchrome,2,2);
decimation(bchrome,4,4);
decimation(rchrome,2,2);
decimation(rchrome,4,4);

%Interpolation
interpolation(bchrome,2,2);
interpolation(bchrome,4,4);
interpolation(rchrome,2,2);
interpolation(rchrome,4,4);

%Image Enhancement
im = imread('racecar.tif');
enhanceImg(im,.6);
enhanceImg(im,2.215);

%Histogram Computation
en1 = imread('enhanced1.tif');
en2 = imread('enhanced2.tif');
histImg(im);
histImg(en1);
histImg(en2);

%Spatial Filtering
spatialFilt(im);

%Frequency Domain Filtering
frDomFilt(im);

%Gradient Base Edge Detection
fig = imread('h2fig1.png');
gradEdgeDetect(fig);

%Sobel Edge Detection
cam = imread('cameraman.png');
sobelEdge(cam);

%Edge Detection with Laplacian of Gaussian (LoG)
LapGauss(cam);

%Template Matching
im_letter = imread('famous.jpg');
im_n      = imread('n_famous.jpg');
template_match(im_letter, im_n);

%Harris Corner Detection 
im_triangle = imread('noisytriangle.jpg');
im_triangle_rotate = imread('rotatetriangle.jpg');
harris_corner( im_triangle );

%Hough Transform
im_triangle = imread('noisytriangle.jpg');
hough_line(im_triangle); % hough line function

# Computer-Vision

Instructions to run driver (cv_driver):

1. Open all the .m files and images into your Matlab workspace
2. Open up cv_driver.m
3. Run the file
4. Outputs will be present

Includes many different computer visison techniques. 

Quantization Effect:
Part A: Create a function that quantizes any real number (x) with L levels. The function should input x, L, the minimum value, and the maximum value given below.
Part B: Apply the quantization function to the image pic1.tif and reconstruct an image with 6 bits per pixel, and 3 bits per pixel.

Color Transformation:
Reads an RGB image and:
• Displays each of the 3 RGB channels
• Transforms the RGB image into the YCrCb color space.
• Creates and Displays the brightness image
• Creates the chrominance images.

Sampling Effect:
Part A: Resamples an image with dimension NxM to (N/n)x(M/m), known as decimation of dimension by nxm, where each nxm pixels are mapped to 1 pixel, by picking the first sample of nxm blocks.
Part B: Resample an image with dimention NxM to (nN)x(mM), known as interpolation of dimensions by nxm, where each pixel is duplicated to nxm pixels.

Image Enhancement:
Enhances an image using the power-law transformation, where new pixel value is: 𝑠=𝐴𝑟𝛾. Where r is the old pixel value, γ is the image enhancement, and A is set to 1. Then create a single plot showing the mapping function between the old and new pixels.

Histogram Computation:
Computes the histogram of racecar.tif and the 2 enhanced images from Image Enhancement.

Spatial Filtering:
Convolution method to perform spatial filtering on an image. Apply an averaging filter with a kernel size of 9x9 to image racecar.tif.

Frequency Domain Filtering
Frequency domain method to smooth racecar.tif with an ideal filter.

Gradient Base Edge Detection:
Extract the gradient base edge magnitude and direction and smooth the image with a Gaussian Low Pass Filter. Computes the edge detection of the smooth image in the X-direction and Y-direction. Computes the magnitude, and the direction of the edge information and quantizes the direction information to 8 directions.

Sobel Edge Detection:
Find sobel edge detection.

Edge Detection with Laplacian of Gaussian:
Constructs two Laplacian of Gaussian filters

Template Matching:
Finds the location of the letter “n” in the image “famous.jpg”. Uses the image n_famous.jpg as a template and applies the template matching technique and the correlation operator as a measure. For Template matching my algorithm first gets sizes of the target image and template image. After taking the mean of each image a correlation is performed to get a correlation matrix. The algorithm then finds the row and column which corresponds to the correlation matrix max value. This process is repeated for the known number of “n”’s. Each loop the max value found is set to zero to prepare for a new max to be found in the next loop. After finding each letter “n” a box the size of the template image is drawn around the letter “n” found.

Harris Corner Detection:
Implements a Harris Corner Detection algorithm. Finds the corners in the image “noisytriangle.jpg”. Use 𝑘𝑘 = 0.05 for the corner operation det(𝑀) − 𝑘 (𝑀)^2. The algorithm starts with applying a Gaussian filter using a Prewitt gradient operator. An edge detection is then performed. After the edge detection the corner operation det(M) − k (M)2 is performed where 𝑀= [𝑥_𝑒𝑑𝑔𝑒() 𝑚𝑎𝑔(); 𝑚𝑎𝑔() 𝑦_𝑒𝑑𝑔𝑒()]; . The positions of the corners are found by finding which values in the corner operation matrix are above a certain threshold. The threshold was found manually to be 0.1∗𝑐𝑜𝑟𝑛𝑒𝑟_𝑚𝑎𝑡𝑟𝑖𝑥 . After getting all the positions of the corners I removed the corners that were detected on the outside edge of the image. The corners were then placed onto the original image. To calculate the coordinates of the 3 new corners of the inner triangle when the image is rotated by 10 degrees I put the non-rotated inner-corners into a rotation operation.

Hough Transform:
Finds the 6 lines in the image “noisytriangle.jpg” using the Hough transform. The algorithm starts by converting the image as a black and white canny edge image. A Hough Transform is the performed with rho steps set as 1. Using the size of the image rho was found to range from -704 : 704. I set theta as -90 and 90 degrees. This was the default values I found in Matlab’s Hough() function. A Standard Hough Transform was performed on the black & white image with rho and theta. After getting the image in Hough space the algorithm finds the peaks. To find the peaks I needed to set the number of peaks, the threshold (minimum value to be considered a peak) and the neighborhood size (2-element vector of positive odd integers). I had to set the peaks to 8 because I was having a problem with lines being drawn twice in the next step. Next I displayed the lines on the image. This was done by obtaining the theta and rho from the corresponding peak. Once the theta and rho where found I transformed the lines in x-y space. The lines were then drawn on the image. To finish the algorithm finds the position of the corners by finding where the lines intercept at the corner points.





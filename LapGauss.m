function LapGauss(im)
    %Display original image
    figure();
    imshow(im);
    
    %% 3.1 Gaussian Low Pass Filter
    %Make image grayscale
    grayImage = im;
    
    %Assign size of Gaussian masks (7x7) & (7x7) and signma values
    N1 = 7; 
    sigma1 = 1.25; 
    N2 = 9; 
    sigma2 = 3; 
    
    % Gaussian mask
    mask1 = -floor(N1/2) : floor(N1/2);
    [x1,y1] = meshgrid(mask1, mask1);
    kernel1 = exp(-(x1.^2 + y1.^2) / (2*sigma1*sigma1));
    kernel1 = kernel1 / sum(kernel1(:));  
    mask2 = -floor(N2/2) : floor(N2/2);
    [x2,y2] = meshgrid(mask2, mask2);
    kernel2 = exp(-(x2.^2 + y2.^2) / (2*sigma2*sigma2));
    kernel2 = kernel2 / sum(kernel2(:));
    
    %Convert image and pad it
    img = double(grayImage)./255;
    pad1 = padarray(img,[floor(N1/2),floor(N1/2)]);
    pad2 = padarray(img,[floor(N2/2),floor(N2/2)]);
    
    %Alocate space for new image
    new_img1 = zeros(size(img,1),size(img,2));
    new_img2 = zeros(size(img,1),size(img,2));
    
    %Convolute
    for ii=1:size(pad1,1)-6
        for jj=1:size(pad1,2)-6     
            val = pad1(ii:ii+6,jj:jj+6).*kernel1;
            new_img1(ii,jj) = sum(val(:));
        end
    end
    for ii=1:size(pad2,1)-8
        for jj=1:size(pad2,2)-8     
            val = pad2(ii:ii+8,jj:jj+8).*kernel2;
            new_img2(ii,jj) = sum(val(:));
        end
    end
    
    %Display
    figure();
    imshow(new_img1,[]);
    figure();
    imshow(new_img2,[]);
    
    %% 3.2 Convolve
    % Gaussian mask [1 -1]
    mx = [1 0 -1
        1 0 -1
        1 0 -1];
    
    my = [1 1 1
        0 0 0
        -1 -1 -1];   
    
    %Take the difference between the filters
    %G(x,y,sigma1) - G(x,y,sigma2)
    diff_img = zeros(size(new_img1,1),size(new_img1,2));
    for ii=1:size(new_img1,1)
        for jj=1:size(new_img1,2)     
            val = new_img1(ii,jj)-new_img2(ii,jj);
            diff_img(ii,jj) = val;
        end
    end
    
    %Alocate space for new edge images
    edgex_img = zeros(size(diff_img,1),size(diff_img,2));
    edgey_img = zeros(size(diff_img,1),size(diff_img,2));
    pad = padarray(diff_img,[1,1]);
    
    %Convolute 
    for ii=1:size(pad,1)-2
        for jj=1:size(pad,2)-2     
            val = pad(ii:ii+2,jj:jj+2).*mx;
            edgex_img(ii,jj) = sum(val(:));
        end
    end
    for ii=1:size(pad,1)-2
        for jj=1:size(pad,2)-2     
            val = pad(ii:ii+2,jj:jj+2).*my;
            edgey_img(ii,jj) = sum(val(:));
        end
    end
    
    %Display
    figure();
    imshow(edgex_img,[]);
    figure();
    imshow(edgey_img,[]);
end
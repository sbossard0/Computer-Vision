function spatialFilt(im)
    %Convolution spatial filtering
    
    %Set averaging 9x9 kernel
    kernel = ones(9)/81;    
    
    %Convert image and pad it
    img = double(im)./255;
    pad = padarray(img,[10,10]);
    
    %Alocate space for new image
    new_img = zeros(size(img,1),size(img,2));
    
    %Convolute
    for ii=1:size(pad,1)-8
        for jj=1:size(pad,2)-8     
            val = pad(ii:ii+8,jj:jj+8).*kernel;
            new_img(ii,jj) = sum(val(:));
        end
    end
    
    %Display
    figure();
    imshow(new_img);
end
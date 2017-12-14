function colorTransform(img)
    %Display Red, Green, Blue Channels
    mat = zeros(size(img, 1), size(img, 2));
    
    r = img(:,:,1);
    red = cat(3,r,mat,mat);
    
    g = img(:,:,2);
    green = cat(3,mat,g,mat);
    
    b = img(:,:,3);
    blue = cat(3,mat,mat,b);
    
    figure()
    imshow(img,[])
    title('Original Image')
    
    figure()
    imshow(red,[])
    title('Red Channel')
    
    figure()
    imshow(green,[])
    title('Green Channel')
    
    figure()
    imshow(blue,[])
    title('Blue Channel')
    
    %Convert RGB to YCrCb
    rgb = double(img);
    r = rgb(:,:,1);
    g = rgb(:,:,2);    
    b = rgb(:,:,3);
    
    y = (.299*r) + (.587*g) + (.114*b);
    cb = 128 - (.168736*r) - (.331264*g) + (.5*b);
    cr = 128 + (.5*r) - (.418668*g) - (.081312*b);
    
    %Display YCbCr Image
    ycbcr = cat(3,y,cb,cr)./255;
    figure()
    imshow(ycbcr,[])
    title('YCbCr Image')
    
    %Display brightness image
    lum = ycbcr(:,:,1);
    figure()
    imshow(lum,[])
    title('Brightness Image')
    
    %Display Blue Chrominance image
    bChrome = ycbcr(:,:,2);
    figure()
    imshow(bChrome,[])
    title('Blue Chrominance Image')
    
    %Display Red Chrominance image
    rChrome = ycbcr(:,:,3);
    figure()
    imshow(rChrome,[])
    title('Red Chrominance Image') 
end
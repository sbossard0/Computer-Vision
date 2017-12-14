function decimation(img,n,m)
    new_img = zeros(round(size(img, 1)/n), round(size(img, 2)/m));
       
    for i=1:size(new_img,1)
        for j=1:size(new_img,2)        
            pix=img(i,j);
            new_img(i,j)=pix;
        end
    end
    figure()
    imshow(new_img,[])
    title('Decimated Image')
end
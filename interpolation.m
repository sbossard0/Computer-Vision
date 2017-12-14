function interpolation(img,n,m)
    new_img = uint8(zeros((size(img,1)*m),(size(img,2)*n)));
    
    for i=0:(size(img,1)*m) - 1
        for j=0:(size(img,2)*n) - 1       
            x = floor(j/n);
            y = floor(i/m);
            for k = 1:3
                new_img(i+1,j+1,k) = img(y+1,x+1,k);
            end
        end
    end
    
    figure()
    imshow(new_img,[])
    title('Interpolated Image')
end
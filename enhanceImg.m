function enhanceImg(im,en)
    %Create images using power law transformation
    img = im2double(im);
    new_img = zeros(size(img,1),size(img,2));
    
    for ii=1:size(img,1)
        for jj=1:size(img,2)       
            pix=img(ii,jj);
            new_pix = pix^en;
            new_img(ii,jj)= new_pix;
        end
    end
    new_img = im2uint8(new_img);
    figure();
    imshow(new_img);
    
    %Create plot of power law transformation
    r = 0:255;
    g1 = r.^.04;
    g2 = r.^.1;
    g3 = r.^.2;
    g4 = r.^.4;
    g5 = r.^.67;
    g6 = r.^1;
    g7 = r.^1.5;
    g8 = r.^2.5;
    g9 = r.^5.0;
    g10 = r.^10.0;
    g11 = r.^25.0;
    
    gamma = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g11;];
    figure();
    plot(r,gamma);
    ylim([0 255])
    xlim([0 255])
    xlabel('Input gray level, r');
    ylabel('Output gray level, s');
    title('Power-Law Transformation Plot');
end
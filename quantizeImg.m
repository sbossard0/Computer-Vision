function quantizeImg(img,bits)
    L = 2^bits;
    stepUnrounded = 255/L;
    step = round(stepUnrounded);
    
    steps = [0];
    for l = 1 : L
        steps(end+1) = steps(end) + step;
    end    
    
    for i=1:size(img,1)
        for j=1:size(img,2)
        
        pix=img(i,j);
          if pix <= steps(1)
              pixl = steps(1);
          elseif pix > steps(L)
              pixl = steps(L);
          else
              for k = 1 : L
                if pix >= steps(k) && pix < steps(k+1)
                    pixl = steps(k);
                end
              end
          end
          
          new_img(i,j)=pixl;
         end
     end

    figure()
    subplot(1,2,1)
    imshow(img,[])
    title('Original Image')
    subplot(1,2,2)
    imshow(new_img,[])
    title('Quantized Image')
end
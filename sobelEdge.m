function sobelEdge(im)
    %Display original image
    figure();
    imshow(im);
    %% 2.1 Gaussian Low Pass Filter
    %Make image grayscale
    grayImage = im;
    
    %Assign size of Gaussian mask (5x5) and signma value
    N = 5; 
    sigma = .35; 

    % Gaussian mask
    mask = -floor(N/2) : floor(N/2);
    [x,y] = meshgrid(mask, mask);
    kernel = exp(-(x.^2 + y.^2) / (2*sigma*sigma));
    kernel = kernel / sum(kernel(:));  
    
    %Convert image and pad it
    img = double(grayImage)./255;
    pad = padarray(img,[floor(N/2),floor(N/2)]);
    
    %Alocate space for new image
    new_img = zeros(size(img,1),size(img,2));
    
    %Convolute
    for ii=1:size(pad,1)-4
        for jj=1:size(pad,2)-4     
            val = pad(ii:ii+4,jj:jj+4).*kernel;
            new_img(ii,jj) = sum(val(:));
        end
    end
    
    %Display
    figure();
    imshow(new_img,[]);
    
    %% 2.2 Compute Sobel Edge Detection 
    % Gaussian mask [1 -1]
    mx = [1 0 -1
        2 0 -2
        1 0 -1];
    
    my = [1 2 1
        0 0 0
        -1 -2 -1];   
    
    %Alocate space for new edge images
    pad = padarray(new_img,[1,1]);
    edgex_img = zeros(size(new_img,1),size(new_img,2));
    edgey_img = zeros(size(new_img,1),size(new_img,2));
    
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
    
    %% 2.3 Compute Magnitude 
    %Compute Mag
    mag_img = zeros(size(edgex_img,1),size(edgex_img,2));
    for ii=1:size(mag_img,1)
        for jj=1:size(mag_img,2)     
            mag = sqrt((edgex_img(ii,jj)*edgex_img(ii,jj))+(edgey_img(ii,jj)*edgey_img(ii,jj)));            
            mag_img(ii,jj) = mag;
        end
    end
    figure();
    imshow(mag_img,[]);
    %% 2.4 Compute Threshold
    %Convert to int to compute threshold
    mag_img = im2uint8(mag_img);
    thr_img = zeros(size(mag_img,1),size(mag_img,2));
    t_low = 200; %low threshold
    t_high = 250; %high threshold
    
    %If magn(x,y) <= t_low then not edge (display as black i.e. 0)
    %If magn(x,y) >= t_high then it is a edge
    %If t_low < magn(x,y) < t_high then it is a edge
    for ii=1:size(mag_img,1)
        for jj=1:size(mag_img,2)     
            if(mag_img(ii,jj) <= t_low)
                thr_img(ii,jj) = 0;
            elseif (mag_img(ii,jj) >= t_high)  
                thr_img(ii,jj) = 255; 
            elseif ((mag_img(ii,jj) > t_low) && (mag_img(ii,jj) < t_high))                
                thr_img(ii,jj) = 255;
            end
        end
    end
    
    figure();
    imshow(thr_img,[]);
    
    %% 2.5 Compute Direction
    %Compute direction
    dir_img = zeros(size(edgex_img,1),size(edgex_img,2));
    for ii=1:size(dir_img,1)
        for jj=1:size(dir_img,2)     
            dir = atand((abs(edgey_img(ii,jj)))/abs((edgex_img(ii,jj))));            
            dir_img(ii,jj) = dir;
        end
    end
    
    %Define the bin values
    steps = [0 45 90 135];
    
    dirQ = zeros(size(dir_img,1),size(dir_img,2));
    
    %Quantize
    for ii=1:size(dir_img,1)
        for jj=1:size(dir_img,2) 
          if dir_img(ii,jj) <= steps(1)
              dirQ(ii,jj) = steps(1);
          elseif dir_img(ii,jj) > steps(end)
              dirQ(ii,jj) = steps(end);
          else
              for kk = 1 : size(steps,2)
                if dir_img(ii,jj) > (steps(kk)-45) && dir_img(ii,jj) < (steps(kk)+45)
                    dirQ(ii,jj) = steps(kk);
                end
              end
          end          
         end
    end
    
    %Display only horizontal and vertical edges of threshold image
    edge_dir = uint8(zeros(size(dir_img,1),size(dir_img,2)));
    for ii=1:size(edge_dir,1)
        for jj=1:size(edge_dir,2) 
          if dirQ(ii,jj) == 45 || dirQ(ii,jj) == 135
              edge_dir(ii,jj) = thr_img(ii,jj);
          else 
              edge_dir(ii,jj) = 0;
          end
        end
    end
    
    figure();
    imshow(edge_dir,[]);
end
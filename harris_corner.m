function harris_corner(im)
    %harris_corner -- This function determines corners in an image
 
    % Gaussian mask [1 -1] with prewit operator
    mx = [-1 0 1
        -1 0 1
        -1 0 1];
    my = [1 1 1
        0 0 0
        -1 -1 -1];

    edgex_im = filter2(mx,im); %Correlate
    edgey_im = filter2(my,im); %Correlate
    mag_im = edgex_im.*edgey_im;
    
    %Display edge detection images
    figure();
    imshow(edgex_im,[]);
    title('Edge Detection: X-Direction');
    figure();
    imshow(edgey_im,[]);
    title('Edge Detection: Y-Direction');
    
    %Gaussian Filter
    G = fspecial('gaussian',[5 5],2); 
    edgex_im = filter2(G,edgex_im.^2);
    edgey_im = filter2(G,edgey_im.^2);
    mag_im = filter2(G,mag_im);
    figure();
    imshow(mag_im,[]);       
    title('Edge Magnitude');
    
    %Alocate space
    result = zeros(size(im,1),size(im,2)); 
    R = zeros(size(im,1),size(im,2));
    
    %Apply corner operation
    for ii = 1:size(im,1)
        for jj = 1:size(im,2)
            M = [edgex_im(ii,jj) mag_im(ii,jj);mag_im(ii,jj) edgey_im(ii,jj)]; 
            co(ii,jj) = det(M)-0.05*(trace(M))^2;
        end
    end
    figure();
    imshow(co);
    title('Corner Output');
    
    co_max = max(max(co));
    Thresh = 0.1*co_max; %Compute threshold Note: found manually
    
    %Put positions of corners
    for ii = 2:size(im,1)-1
        for jj = 2:size(im,2)-1
            if co(ii,jj) > Thresh
                %Only grab 1 of the pixels detected
                if co(ii,jj) > co(ii-1,jj-1) && co(ii,jj) > co(ii-1,jj) && co(ii,jj) > co(ii-1,jj+1) && co(ii,jj) > co(ii,jj-1) && co(ii,jj) > co(ii,jj+1) && co(ii,jj) > co(ii+1,jj-1) && co(ii,jj) > co(ii+1,jj) && co(ii,jj) > co(ii+1,jj+1)                    
                    result(ii,jj) = 1;
                end
            end
        end
    end
    
    [c,r] = find(result == 1);
    
    %Ignore the beginning and end rows
    c(10) = [];
    c(9) = [];
    c(2) = [];
    c(1) = [];
    
    r(10) = [];
    r(9) = [];
    r(2) = [];
    r(1) = [];    
    
    figure();
    imshow(im);
    hold on;
    plot(r,c,'r.');
    title('Corners Detected');
    
    disp(r);
    disp(c);
    
    %Remove outside corners
    r(6) = [];
    r(3) = [];
    r(1) = [];
    c(6) = [];
    c(3) = [];
    c(1) = [];
    
    for ii = 1:3
        rr(ii,1) = round(r(ii)*cosd(10) + c(ii)*sind(10)) - 40;
        cc(ii,2) = round(c(ii)*cosd(10) - r(ii)*sind(10)) + 50;
    end
    
    im_triangle_rotate = imread('rotatetriangle.jpg');
    figure();
    imshow(im_triangle_rotate);
    hold on;
    plot(rr,cc,'r.');
    title('Corners Detected (Rotation)');
end
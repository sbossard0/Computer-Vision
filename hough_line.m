function hough_line(im)
    %hough_line -- This function determines num_lines in an image   
    
    %Set im to black white image with canny edge
    bw = edge(im,'canny');

    figure();
    imshow(bw);
    
    %Perform Hough Transform
    %Hough(im,theta,rho)
    %rho steps = 1
    
    %Set up rho
    h_max = sqrt((size(bw,1)-1)^2 + (size(bw,2)-1)^2); %703.5
    numRho = 2 * ceil(h_max) + 1; %1409
    rho_d = ceil(h_max); % Round h_max 704
    rho = -rho_d : rho_d; %-704 : 704
    %Set up theta
    theta = linspace(-90, 90, 180);
    numTheta = length(theta);
       
    H = zeros(numRho, numTheta); %Alocate Space for Hough
    
    %Hough tranformation
    for ii = 1:size(bw,1)
        for jj = 1:size(bw,2)
            if (bw(ii,jj))
                for kk = 1 : numTheta
                    temp = jj*cosd(theta(kk)) + ii*sind(theta(kk));
                    rowI = round(temp + rho_d)+1;
                    H(rowI, kk) = H(rowI, kk)+1;                   
                end
            end            
        end
    end 
        
    %Display Hough space
    figure();
    imshow(H,[],'XData',theta,'YData',rho,...
          'InitialMagnification','fit');
    title('Hough Transform');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal;
    
    %Prepare to find the peaks
    numPeaks = 8;
    thresh = 0.5 * max(max(H)); %Minimum value to be considered a peak found in houghpeaks documentaion
    nHoodSize = floor(size(H)/100.0)*2 + 1; %Size of suppression neighborhood which is a two-element vector of positive odd integers

    %Allocate space
    peaks = zeros(numPeaks, 2);
    num = 0;
    
    %Find the peaks
    while(num < numPeaks)
        h_max = max(max(H));
        if (h_max >= thresh)
            num = num + 1; %Counter
            [r,c] = find(H == h_max);
            peaks(num,:) = [r(1),c(1)]; %peak found
            rStart = max(1, r-(nHoodSize(1)-1)/2); %start of row
            rEnd = min(size(H,1), r+(nHoodSize(1)-1)/2); %end of row
            cStart = max(1, c-(nHoodSize(2)-1)/2); %start of column
            cEnd = min(size(H,2), c+(nHoodSize(2)-1)/2);%end of column
            
            %Set region to 0 to find new max next loop
            for ii = rStart : rEnd
                for jj = cStart : cEnd
                        H(ii,jj) = 0;
                end
            end          
        end
    end
    
    %Display the lines on the image
    figure();
    imshow(im);
    hold on;
    for ii = 1 : size(peaks,1)
       rhoI = rho(peaks(ii,1));
       thetaI = theta(peaks(ii,2));
       x1 = 1;
       x2 = size(im, 2);
       y1 = (rhoI - x1 * cosd(thetaI)) / sind(thetaI);
       y2 = (rhoI - x2 * cosd(thetaI)) / sind(thetaI);
       slope(ii,1) = cosd(thetaI) / sind(thetaI);
       inter(ii,1) = rhoI / sind(thetaI);
       plot([x1,x2],[y1,y2],'r','LineWidth',1);
    end    
    title('Lines Detected');
    slope(3) = [];
    inter(3) = [];
    slope(1) = [];
    inter(1) = [];
    slope_int = [slope,inter];
    disp(slope_int);
    
    %Find the corners
    %Inner Left
    xpix1 = (slope_int(1,2)-slope_int(4,2))/slope_int(4,1);
    ypix1 = (slope_int(4,1)*xpix1)+ slope_int(4,2);
    pix(1,:) = [xpix1,ypix1];
    %Inner Right
    xpix2 = (slope_int(1,2)-slope_int(6,2))/slope_int(6,1);
    ypix2 = (slope_int(6,1)*xpix2)+ slope_int(6,2);
    pix(2,:) = [xpix2,ypix2];
    %Inner Top
    xpix3 = (slope_int(6,2)-slope_int(4,2))/(slope_int(4,1)-slope_int(6,1));
    ypix3 = (slope_int(6,1)*xpix3)+ slope_int(6,2);
    pix(3,:) = [xpix3,ypix3];
    %Outer Left
    xpix4 = (slope_int(2,2)-slope_int(5,2))/slope_int(5,1);
    ypix4 = (slope_int(5,1)*xpix4)+ slope_int(5,2);
    pix(4,:) = [xpix4,ypix4];
    %Outer Right
    xpix5 = (slope_int(2,2)-slope_int(3,2))/slope_int(3,1);
    ypix5 = (slope_int(3,1)*xpix5)+ slope_int(3,2);
    pix(5,:) = [xpix5,ypix5];
    %Inner Top
    xpix6 = (slope_int(3,2)-slope_int(5,2))/(slope_int(5,1)-slope_int(3,1));
    ypix6 = (slope_int(3,1)*xpix6)+ slope_int(3,2);
    pix(6,:) = [xpix6,ypix6];
    
    disp(pix);
end


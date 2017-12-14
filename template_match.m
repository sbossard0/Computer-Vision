function template_match( im, im_template )
%template_match -- This function matches a template to a base image

%Set initial images
Target = im; %Target Image
Template = im_template; %Template Image
FinalIm = im; %To draw boxes on

%Set rows and columns
[r1,c1]=size(Target);
[r2,c2]=size(Template);

%Mean of the template
tempMean=Template-mean(mean(Template));

%Correlation
corrMat=[];
for ii=1:(r1-r2+1)
    for jj=1:(c1-c2+1)
        mask=Target(ii:ii+r2-1,jj:jj+c2-1);
        mask=mask-mean(mean(mask));  %Mean of image 
        corr=sum(sum(mask.*tempMean));
        corrMat(ii,jj)=corr;
    end 
end

%Find the location (x,y) of each letter 'n'
letter_location = zeros(8,2);

for kk=1:8
    [r,c]=max(corrMat);
    [rr,cc]=max(max(corrMat));
    
    xx = c(cc); %x location of max value
    yy = cc; %y location of max value
    
    letter_location(kk,1) = xx; %Set to row of max value found in correlation
    letter_location(kk,2) = yy;  %Set to column of max value found in correlation
    
    %Set current max value to 0 to prepare to find next max value
    corrMat(xx,yy)=0;
end

%Draw boxes around each letter 'n'
result=FinalIm;

for mm = 1:8 % # of letter 'n' in the image = 7
    
    %The 7th max value was the comma after 'great' in the image
    %Brute force method to not box around the comma
    if (mm ~= 7) 
        %Draw boxes
        for x=letter_location(mm,1):letter_location(mm,1)+r2-1
           for y=letter_location(mm,2)
               result(x,y)=0;
           end
        end
        for x=letter_location(mm,1):letter_location(mm,1)+r2-1
           for y=letter_location(mm,2)+c2-1
               result(x,y)=0;
           end
        end
        for x=letter_location(mm,1)
           for y=letter_location(mm,2):letter_location(mm,2)+c2-1
               result(x,y)=0;
           end
        end
        for x=letter_location(mm,1)+r2-1
           for y=letter_location(mm,2):letter_location(mm,2)+c2-1
               result(x,y)=0;
           end
        end
    end
end

%Display images and the letter locations
figure();
imshow(im);
title('Original Image');
figure();
imshow(im_template);
title('Template Image');
figure();
imshow(result);
title('Template Locations');
disp(letter_location);
end


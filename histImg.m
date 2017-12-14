function histImg(im)
   %Initial variables  
   data=zeros(1,256);    
   c=0; %counter
   
   %Count how many of each pixel value exist
   for kk=1:256
       for ii=1:size(im,1)
           for jj=1:size(im,2)       
               if im(ii,jj)== kk-1
                   c = c+1;
               end
           end
       end
       data(kk)= c;
       c=0;
   end   
          
   %Used stem() instead of hist()
   x = 0:255;
   figure();
   stem(x,data);
end
function frDomFilt(im)
   %Display Image MxN = (256x256)
   figure();
   imshow(im);
   
   %Display padded image PxQ, where P = 2M and Q = 2N
   img=double(im);
   pim=uint8(zeros(((2*size(img,1))),((2*size(img,2)))));
   
   for ii=1:size(img,1)
       for jj=1:size(img,2)
         pim(ii,jj)=img(ii,jj);
       end
   end
   figure();
   imshow(pim);
   
   %Take padded image and multiply by (-1)^x+y
   padd = pim;
   p = uint8(zeros(size(padd,1),size(padd,2)));
   for ii=1:size(p,1)
        for jj=1:size(p,2)       
            p(ii,jj)=padd(ii,jj)*(-1)^(ii+jj);
        end
   end
   figure();
   imshow(p);

   %Find spectrum of image
   spec = double(p);
   fim=fft2(spec);
   figure();
   imshow(abs(fim),[]);
   
   %Low pass filtering
   d0=40; %80/2
   d=zeros(size(fim,1),size(fim,2));
   h=zeros(size(fim,1),size(fim,2));

   for ii=1:size(fim,1)
       for jj=1:size(fim,2)
          d(ii,jj)= sqrt((ii-(size(fim,1)/2))^2 + (jj-(size(fim,2)/2))^2);
       end
   end

   for ii=1:size(fim,1)
       for jj=1:size(fim,2)
          h(ii,jj)= exp(-((d(ii,jj)^2)/(2*(d0^2))));
       end
   end
   him = h;
   figure();
   imshow(abs(him),[])
   
   %Spectrum of product
   for ii=1:size(fim,1)
       for jj=1:size(fim,2)
          sp(ii,jj)=(h(ii,jj))*fim(ii,jj);
       end
   end
   gim = sp;
   figure();
   imshow(abs(gim),[])
   
   
   %Back to spatial domain
   spat=ifft2(gim);
 
   for ii=1:(2*size(img,1))
       for jj=1:(2*size(img,2))
         spat(ii,jj)=spat(ii,jj)*((-1)^(ii+jj));
       end
   end
   figure();
   imshow(spat,[])

   % removing the padding
   for ii=1:size(img,1)
       for jj=1:size(img,2)
         npad(ii,jj)=spat(ii,jj);
       end
   end
   
   npad=uint8(real(npad));
   figure(); 
   imshow(npad);
end
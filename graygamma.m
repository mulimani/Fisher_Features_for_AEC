function H=graygamma(x,fs)

x = (sum(x,2)/2);
 

 S=gammatonegram(x,fs,0.025,0.010,64,0,fs/2,0);
 %S=abs(B);
%S=log(S);
H=Normalization(S);
%H=mat2gray(S);
%imshow(H);
%figure(2);showimage(H);
%set(gca,'YDir', 'normal');
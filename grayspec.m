function H=grayspec(x,fs)
%[x,fs]=wavread('/media/manjunath/BCE0E709E0E6C8AA/Evaluation-data/meeting-folds/cl/12-2.wav');
 x = (sum(x,2)/2);
 
% xx=downsample(x.',4).';
 [B,f,t]=specgram(x,256,fs,256,128);
 S=abs(B);
%S=log(S);
H=mat2gray(S,[0 1]);
%figure(2);imshow(H);
%set(gca,'YDir', 'normal');
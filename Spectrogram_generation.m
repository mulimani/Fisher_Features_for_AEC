clear all
data_dir='/media/manjunath/BCE0E709E0E6C8AA/Evaluation-data/meeting10-noise/'; 
directory=dir(data_dir);
nclass=length(directory)-2;
failedfiles={};


t = cputime;
for class=1:nclass

    sub_d=dir([data_dir,directory(class+2).name]);
    nfile=length(sub_d)-2;
    
    temp=exist(['/media/manjunath/BCE0E709E0E6C8AA/Evaluation-data/meet_gamma_img/10dB/img/folds/',directory(class+2).name]);
   
    if temp==0
        mkdir(['/media/manjunath/BCE0E709E0E6C8AA/Evaluation-data/meet_gamma_img/10dB/img/folds/',directory(class+2).name])
    end
    
    for file=1:nfile
      % try
        [x,fs]=audioread([data_dir,directory(class+2).name,'/',sub_d(file+2).name]);
      
      
        Z1=graygamma(x,fs);
        %Z1=Z1';
        
      % catch exception
          failedfiles=[failedfiles;{file}];
       % continue
      %end
%       temp=exist(['/home/manjunath/gfeatures-test/',directory(class+2).name,'/','test']);
%    
%     if temp==0
%         mkdir(['/home/manjunath/gfeatures-test/',directory(class+2).name,'/','test'])
%     end
      [pathstr,name2,ext] = fileparts(sub_d(file+2).name);
        save(['/media/manjunath/BCE0E709E0E6C8AA/Evaluation-data/meet_gamma_img/10dB/img/folds/',directory(class+2).name,'/',name2], 'Z1')
        fprintf('Done %d extraction\n',file)
    end
    
end
%load(['/home/manjunath/graph-features/water_tap/',num2str(1)])
fprintf('Done reading %d class training files\n',cputime-t);

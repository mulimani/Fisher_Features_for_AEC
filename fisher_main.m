clear;
close all;

% DATASET
dataset_dir='folds';

% PATHS
basepath = 'E:/gammameet-hot2/20dB';
wdir = pwd;

% image file extension
file_ext='mat';
fold_num=1;

%% Create a dataset with train and test split
%%
data = create_dataset_split_img(fullfile(basepath, 'img', dataset_dir),fold_num,file_ext);
classes = {data.classname}; % create cell array of class name strings

%% Train data
%%
lasti=1;
for i = 1:length(data)
     images_descs = get_spectrogram_files(data,i,'train');
     for j = 1:length(images_descs) 
        fname = fullfile(basepath,'img',dataset_dir,data(i).classname,images_descs{j});
        fprintf('Loading %s \n',fname);
        tmp = load(fname,'-mat');
        tmp.class=i;
        tmp.specfname=regexprep(fname,['.' file_ext],'.mat');
        spec_train(lasti)=tmp;
        lasti=lasti+1;
     end
end

%% Test Data
%%
lasti=1;
for i = 1:length(data)
     images_descs = get_spectrogram_files(data,i,'test');
     for j = 1:length(images_descs) 
        fname = fullfile(basepath,'img',dataset_dir,data(i).classname,images_descs{j});
        fprintf('Loading %s \n',fname);
        tmp = load(fname,'-mat');
        tmp.class=i;
        tmp.specfname=regexprep(fname,['.' file_ext],'.mat');
        spec_test(lasti)=tmp;
        lasti=lasti+1;
     end
end

features_fisher(spec_train, spec_test, data)
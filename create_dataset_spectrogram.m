                           
function data = create_dataset_spectrogram(main_dir,foldnum,file_ext)
    category_dirs = dir(main_dir);
 
    %remove '..' and '.' 
    category_dirs(~cellfun(@isempty, regexp({category_dirs.name}, '\.*')))=[];
    category_dirs(strcmp({category_dirs.name},'split.mat'))=[]; 
    
    for z=1:length(category_dirs)
        temp={strsplit(category_dirs(z).name,' ')};
        temp2=cellfun(@str2num,temp{1,1},'un',0);
        category_dirs(z).class=temp2{1};
    end
     for c = 1:length(category_dirs)
         if isdir(fullfile(main_dir,category_dirs(c).name)) && ~strcmp(category_dirs(c).name,'.') ...
                 && ~strcmp(category_dirs(c).name,'..')
             specdir = dir(fullfile(main_dir,category_dirs(c).name, ['*.' file_ext]));
             for km=1:length(specdir)
                 temp3={strsplit(specdir(km).name,'-')};
                 temp4=temp3{1,1};
                 temp5=cell2mat(temp4(2));
                 [~,fold_tmp,ext_tmp]=fileparts(temp5);
                 %temp4=cellfun(@str2num,temp3{1,1},'un',0);
                 specdir(km).fold=str2num(fold_tmp);
             end
              ids = randperm(length(specdir));
              data(c).n_images = length(specdir);
              data(c).classname = category_dirs(c).name;
              data(c).files = {specdir(:).name};
              data(c).class = category_dirs(c).class;
              data(c).fold = {specdir(:).fold};
              data(c).train_id = (cell2mat(data(c).fold)~=foldnum);
              data(c).test_id = (cell2mat(data(c).fold)==foldnum);



         end
     end
%end

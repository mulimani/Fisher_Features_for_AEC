function [spec_train,spec_test]=features_fisher(spec_train, spec_test, data)


build_vocabulary = 1;
GMM_quantization = 1;
nfeat_vocabulary = 60000; % number of features used by GMM



%% Visual vocabulary using GMM 
%%

if build_vocabulary
    fprintf('\nBuild visual vocabulary:\n');

    % concatenation of spectrograms to build feature matrices
    VOC = [];
    labels_train = cat(1,spec_train.class);
    for i=1:length(data)
        spec_class = spec_train(labels_train==i);
        randspecs = randperm(length(data));
        randspecs=randspecs(1:5);
        VOC = vertcat(VOC,spec_class(randspecs).Z1);
    end

    r = randperm(size(VOC,1));
    r = r(1:min(length(r),nfeat_vocabulary));

    VOC = VOC(r,:);
    
    [means, covariances, priors] = vl_gmm(double(VOC)',64);
   
end


%% GMM soft quantization 
%% Train data
%%

if GMM_quantization
    fprintf('\n Soft Feature quantization \n');
    for i=1:length(spec_train)  
      ffv = spec_train(i).Z1(:,:);
      encoding = vl_fisher(ffv', means, covariances, priors);
      encoding=encoding';
      % power "normalization"
        vencode = sign(encoding) .* sqrt(abs(encoding)); 

% L2 normalization (may introduce NaN)
        vnorm=vencode/norm(vencode);
        vnorm(find(isnan(vnorm))) = 123; 
      % save features
        spec_train(i).fisher=vnorm;
    end
%% Test Data
%%
    for i=1:length(spec_test)    
      ffv = spec_test(i).Z1(:,:); 
      
      encoding = vl_fisher(ffv', means, covariances, priors);
      encoding=encoding';
      vencode = sign(encoding) .* sqrt(abs(encoding)); 
      vnorm=vencode/norm(vencode);
      vnorm(find(isnan(vnorm))) = 123; 
          
      spec_test(i).fisher=vnorm;
    end
end

%% Training and Testing

bof_train=cat(1,spec_train.fisher);
bof_test=cat(1,spec_test.fisher);
[bof_train, bof_test]=bof_pca(bof_train, bof_test);%Apply PCA to reduce dimenstions

% Train and Test labels
labels_train=cat(1,spec_train.class);
labels_test=cat(1,spec_test.class);

%%
%% SVM classification (using libsvm) 
%%
linar_classification=1;
if linar_classification
    % cross-validation
    C_vals=log2space(7,10,5);
    for i=1:length(C_vals);
        opt_string=['-t 0  -v 5 -c ' num2str(C_vals(i))];
        xval_acc(i)=svmtrain(labels_train,bof_train,opt_string);
    end
    %choose the best C 
    [v,ind]=max(xval_acc);

    % train and test of model
    model=svmtrain(labels_train,bof_train,['-t 0 -c ' num2str(C_vals(ind))]);
    svm_lab=svmpredict(labels_test,bof_test,model);
    
    
end

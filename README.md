# Fisher_Features_for_AEC

A UPC-TALP isolated meeting room acoustic events dataset used in this study (http://metashare.ilsp.gr:8080/repository/browse/upc-talp-database-of-isolated-meeting-room-acoustic-events/55f7c886de7311e2b1e400259011f6ea2efcc6f0291c4870a5a58ff99807cfe2/) 


Generate grayscale spectrogram/gammatonegram from Spectrogram_generation.m. (Gammatonegrams are computed using method given in https://www.ee.columbia.edu/~dpwe/resources/matlab/gammatonegram/) and saved as file_name-fold_no.mat

Change basepath of a dataset and fold numbers in fisher_main.m for fisher feature extraction.

GMM is computed using method given in https://www.vlfeat.org/overview/gmm.html

SVM is used from https://www.csie.ntu.edu.tw/~cjlin/libsvm/

A detailed description about the methodology is given in https://www.sciencedirect.com/science/article/abs/pii/S0003682X18308764



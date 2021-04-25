function spectrogram_images=get_spectrogram_files(data,class_id,train_or_test)
    if strcmp(train_or_test,'train')
        spectrogram_images = data(class_id).files(data(class_id).train_id);
    else
        spectrogram_images = data(class_id).files(data(class_id).test_id);
    end
   
end
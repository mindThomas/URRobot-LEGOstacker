%% saveImages2

if exist('ForegroundImage')
    str = strcat('imagesForReport/ForegroundImages/',TimeStamp,'.bmp');
    imwrite(ForegroundImage,str,'bmp')
end


h = figure(100);
%set(h, 'Visible', 'off');
hold on
plotCenterAndRotation
filename = strcat('imagesForReport/blobFeatureImages/',TimeStamp,'.bmp');
saveas(h,filename);
hold off;
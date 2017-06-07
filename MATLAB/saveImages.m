function [] = saveImages(config,binaryImage,binaryImageNoiseFree,brickInfo)

str = strcat('imagesForReport/binaryImages/',config.name,'-',TimeStamp,'.bmp');
imwrite(binaryImage,str,'bmp')

str = strcat('imagesForReport/binaryImageNoiseFree/',config.name,'_C',...
              num2str(config.R_closing),'_O',num2str(config.R_opening),...
              '-',TimeStamp,'-','.bmp');          
imwrite(binaryImageNoiseFree,str,'bmp')

h = figure(99);
%set(h, 'Visible', 'off');
imshow(binaryImageNoiseFree);
hold on;

for i = 1:length(brickInfo)
    text(brickInfo{i}.Center_of_gravity(1),...
         brickInfo{i}.Center_of_gravity(2),...
         num2str(brickInfo{i}.identifier),'FontSize',14,'color','r');
end

filename = strcat('imagesForReport/blobImages/',config.name,'-',TimeStamp,'.bmp');
saveas(h,filename);    
hold off;
end


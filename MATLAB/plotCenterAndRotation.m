imshow(rgbImage)

for i = 1:length(RB)
    hold on
    
    brick = RB{i};
    scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
    plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
         [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
         'LineWidth',3,'color',[1,0,0])
end

for i = 1:length(GB)
    hold on
    
    brick = GB{i};
    scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
    plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
         [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
         'LineWidth',3,'color',[0,1,0])
end

for i = 1:length(BB)
    hold on
    
    brick = BB{i};
    scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
    plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
         [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
         'LineWidth',3,'color',[0,0,1])
end

for i = 1:length(YB)
    hold on
    
    brick = YB{i};
    scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
    plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
         [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
         'LineWidth',3,'color',[1,1,0])
end

% for i = 1:length(WB)
%     hold on
%     
%     brick = WB{i};
%     scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
%     plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
%          [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
%          'LineWidth',3,'color',[1,1,1])
% end

for i = 1:length(OB)
    hold on
    
    brick = OB{i};
    scatter(brick.boudingBoxCenter(1),brick.boudingBoxCenter(2),'k','+','LineWidth',3)
    plot([brick.boudingBoxCenter(1) brick.boudingBoxCenter(1)+sqrt(brick.mass)*sind(brick.rotation)],...
         [brick.boudingBoxCenter(2) brick.boudingBoxCenter(2)+sqrt(brick.mass)*cosd(brick.rotation)],...
         'LineWidth',3,'color',[1,0.5,0])
end
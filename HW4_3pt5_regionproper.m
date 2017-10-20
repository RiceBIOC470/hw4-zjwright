% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 
function [cell_number, mean_area, mean_intensity] = HW4_3pt5_regionproper(image, mask)
info=regionprops(mask, image, 'Centroid', 'Area', 'MeanIntensity');
cell_number=length(info);
area=[info.Area];
mean_area=mean(area);
mean_intensity=info.MeanIntensity;
end

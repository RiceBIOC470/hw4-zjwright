function mean_intensity=mean_intensity_calc(image, mask)
cell_info= regionprops(mask, image,'MeanIntensity','MaxIntensity','PixelValues','Area','Centroid');
mean_intensity=[cell_info.MeanIntensity];
end
function masky=HW4_3pt3_auto_thresholder(image)
%i guess do mean of top 90% percentile, maybe 80 or 85 is better?
threshold = mean(prctile(image, 90));
masky = image > threshold;
end
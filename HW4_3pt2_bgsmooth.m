function bgfixed_smoothed= HW4_3pt2_bgsmooth(image, rad, sigma, bg_disk_r)
smoothed=imfilter(image, fspecial('gaussian', rad, sigma));
background=imopen(smoothed,strel('disk', bg_disk_r));
bgfixed_smoothed=imsubtract(smoothed, background);
end
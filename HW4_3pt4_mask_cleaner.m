function something=HW4_3pt4_mask_cleaner(mask, dilation_radius, erosion_radius)
closed=imdilate(mask, strel('disk', dilation_radius));
eroded=imerode(closed, strel('disk', erosion_radius));
something=eroded;
end
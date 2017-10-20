%HW4
%% 
% Problem 1. 
clc; clear all;
% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 
random_image=random_image_maker;
figure(1)
imshow(random_image, [])
% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations
mask=circle_image_maker(5); 
figure(2)
imshow(mask)
% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).
circle_intensities=mean_intensity_calc(random_image, mask);

% 4. Plot the mean and standard deviation of the values in your output
% vector as a function of circle size. Explain your results. 
cell_info=regionprops(mask, random_image,'MeanIntensity','MaxIntensity','PixelValues','Area','Centroid');
circle_areas=[cell_info.Area];
ratios=circle_intensities./circle_areas;
figure(4)
plot(ratios)
%%

%Problem 2. Here is some data showing an NFKB reporter in ovarian cancer
%cells. 
%https://www.dropbox.com/sh/2dnyzq8800npke8/AABoG3TI6v7yTcL_bOnKTzyja?dl=0
%There are two files, each of which have multiple timepoints, z
%slices and channels. One channel marks the cell nuclei and the other
%contains the reporter which moves into the nucleus when the pathway is
%active. 
%
%Part 1. Use Fiji to import both data files, take maximum intensity
%projections in the z direction, concatentate the files, display both
%channels together with appropriate look up tables, and save the result as
%a movie in .avi format. Put comments in this file explaining the commands
%you used and save your .avi file in your repository (low quality ok for
%space). 
%open files by dragging files into bioformats shortcut window
%to stack: image>stack>z-project (max intensity)
%adjust channel brightness: image>adjust>brightness\contrast>reset in B&C
%window, thenmove min and max sliders until image is ok (same settings for
%both 1 and 2)
%concatenate:image>stack>tools>concatenate
%make movie: file>save as>avi>10fps

%Part 2. Perform the same operations as in part 1 but use MATLAB code. You don't
%need to save the result in your repository, just the code that produces
%it. 
%for nfkb movie 1
nfkb_stack1_reader=bfGetReader('nfkb_movie1.tif'); 
z1=nfkb_stack1_reader.getSizeZ;
t1=nfkb_stack1_reader.getSizeT;
for tt=1:t1
    ind1_1=nfkb_stack1_reader.getIndex(0,0,tt-1)+1;
    img_max1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
    ind1_2=nfkb_stack1_reader.getIndex(0,1,tt-1)+1;
    img_max1_2=bfGetPlane(nfkb_stack1_reader, ind1_2);
    
    for zz=1:z1
    %for first channel
        ind1_1=nfkb_stack1_reader.getIndex(zz-1,0,tt-1)+1;
        img_now1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
        img_max1_1=max(img_max1_1, img_now1_1);
    %for second channel
        ind1_2=nfkb_stack1_reader.getIndex(zz-1,1,tt-1)+1;
        img_now1_2=bfGetPlane(nfkb_stack1_reader, ind1_2);
        img_max1_2=max(img_max1_2, img_now1_2);
    end
    merger1=cat(3, imadjust(img_max1_1), imadjust(img_max1_2), zeros(size(img_now1_1)));
    imwrite(merger1, 'HW4_2pt2_mov.tif', 'WriteMode', 'append');
end

%for nfkb movie 2
nfkb_stack2_reader=bfGetReader('nfkb_movie2.tif'); 
z2=nfkb_stack2_reader.getSizeZ;
t2=nfkb_stack2_reader.getSizeT;
for tt=1:t2
    ind1_1=nfkb_stack1_reader.getIndex(0,0,tt-1)+1;
    img_max1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
    ind1_2=nfkb_stack1_reader.getIndex(0,1,tt-1)+1;
    img_max1_2=bfGetPlane(nfkb_stack1_reader, ind1_2);
    
    for zz=1:z2
    %for first channel
        ind1_1=nfkb_stack2_reader.getIndex(zz-1,0,tt-1)+1;
        img_now1_1=bfGetPlane(nfkb_stack2_reader, ind1_1);
        img_max1_1=max(img_max1_1, img_now1_1);
    %for second channel
        ind1_2=nfkb_stack2_reader.getIndex(zz-1,1,tt-1)+1;
        img_now1_2=bfGetPlane(nfkb_stack2_reader, ind1_2);
        img_max1_2=max(img_max1_2, img_now1_2);
    end
    merger1=cat(3, imadjust(img_max1_1), imadjust(img_max1_2), zeros(size(img_now1_1)));
    imwrite(merger1, 'HW4_2pt2_mov.tif', 'WriteMode', 'append');
end

%nfkb_movie_reader=bfGetReader('HW4_2pt2_mov');
%actual_nfkb_movie=VideoWriter(?)
%%
% Problem 3. 
% Continue with the data from part 2
% 
% 1. Use your MATLAB code from Problem 2, Part 2  to generate a maximum
% intensity projection image of the first channel of the first time point
% of movie 1. 
nfkb_stack1_reader=bfGetReader('nfkb_movie1.tif'); 
img_max1 = bfGetPlane(nfkb_stack1_reader,ind1_1);
    for zz=1:z2
        ind1_1=nfkb_stack1_reader.getIndex(zz-1,0,0)+1;
        img_now1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
        img_max1_1=max(img_max1_1, img_now1_1);
    end
    figure(5)
    imshow(img_max1, []);
% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when callin3g the function.

%function is HW4_3pt2_bgsmooth
figure(6)
img1_bgsmooth=HW4_3pt2_bgsmooth(img_max1, 4, 2, 30); 
imshow(img1_bgsmooth, []);
% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 
%function is HW4_3pt3_auto_thresholder
figure(7)
img1_mask=HW4_3pt3_auto_thresholder(img1_bgsmooth);
imshow(img1_mask)
% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image. 
%function is HW4_3pt4_mask_cleaner
pretty_mask=HW4_3pt4_mask_cleaner(img1_mask, 8, 8); %not great at separating touching nuclei
figure(8)
imshow(cat(3, img1_mask, pretty_mask, zeros(size(img1_mask))))

% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 
%function is HW4_3pt5_regionproper
[cell_number, mean_area, mean_intensity] = HW4_3pt5_regionproper(img1_bgsmooth, pretty_mask)

% 6. Apply your function from (2) to make a smoothed, background subtracted
% image from channel 2 that corresponds to the image we have been using
% from channel 1 (that is the max intensity projection from the same time point). Apply your
% function from 5 to get the mean intensity of the cells in this channel. 
nfkb_stack2_reader=bfGetReader('nfkb_movie1.tif'); 
ind2=nfkb_stack1_reader.getIndex(0,1,0)+1;
img_max2=bfGetPlane(nfkb_stack2_reader, ind2);
    for zz=1:z2
        ind2=nfkb_stack2_reader.getIndex(zz-1,1,0)+1;
        img_now2=bfGetPlane(nfkb_stack2_reader, ind2);
        img_max2=max(img_max2, img_now2);
    end
    figure(9)
    imshow(img_max2, []); %super dim for some reason
img2_bgsmooth=HW4_3pt2_bgsmooth(img_max2, 4, 2, 30); 
img2_mask=HW4_3pt3_auto_thresholder(img2_bgsmooth);
pretty2_mask=HW4_3pt4_mask_cleaner(img2_mask, 15, 8);
[cell_number, mean_area, mean_intensity] = HW4_3pt5_regionproper(img2_bgsmooth, pretty2_mask)
%the mask function did not translate well from the nuclei image to the
%cytosol image
%%
% Problem 4. 

% 1. Write a loop that calls your functions from Problem 3 to produce binary masks
% for every time point in the two movies. Save a movie of the binary masks.
% img1_mask=HW4_3pt3_auto_thresholder(img1_bgsmooth);
reader_mov1 = bfGetReader('nfkb_movie1.tif');
reader_mov2 = bfGetReader('nfkb_movie2.tif');
video=VideoWrite('problem4_mask_vid');
open(video);
for tt=1:reader_mov1.getSizeT
    ind1_1=reader_mov1.getIndex(0,0,tt-1)+1;
    img_max1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
    ind1_2=nfkb_stack1_reader.getIndex(0,1,tt-1)+1;
    img_max1_2=bfGetPlane(nfkb_stack1_reader, ind1_2);
    for zz=1:z1
    %for first channel
        ind1_1=nfkb_stack1_reader.getIndex(zz-1,0,tt-1)+1;
        img_now1_1=bfGetPlane(nfkb_stack1_reader, ind1_1);
        img_max1_1=max(img_max1_1, img_now1_1);
    %for second channel
        ind1_2=nfkb_stack1_reader.getIndex(zz-1,1,tt-1)+1;
        img_now1_2=bfGetPlane(nfkb_stack1_reader, ind1_2);
        img_max1_2=max(img_max1_2, img_now1_2);
    end
    merger1=cat(3, imadjust(img_max1_1), imadjust(img_max1_2), zeros(size(img_now1_1)));
    imwrite(merger1, 'HW4_2pt2_mov.tif', 'WriteMode', 'append');
end

% 2. Use a loop to call your function from problem 3, part 5 on each one of
% these masks and the corresponding images and 
% get the number of cells and the mean intensities in both
% channels as a function of time. Make plots of these with time on the
% x-axis and either number of cells or intensity on the y-axis. 


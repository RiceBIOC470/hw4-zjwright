function rand_circles=circle_image_maker(r)
blank_image=false(1024);
for ii=1:20
    blank_image((randi(1024, 1)), (randi(1024, 1)))=true;
end
rand_circles=(imdilate(blank_image, strel('sphere', r)));
end
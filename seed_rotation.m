function orientation_seed = seed_rotation(deg_step,start,finish)


step = (finish-start)/deg_step;

for i = 1:step+1
    for j = 1:step+1
        orientation_seed(j+(step+1)*(i-1),1) = (i-1)*deg_step+start;
        orientation_seed(j+(step+1)*(i-1),2) = (j-1)*deg_step+start;
        orientation_seed(j+(step+1)*(i-1),3) = 0;
    end
end

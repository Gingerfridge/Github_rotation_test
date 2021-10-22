function orientation_seed = seed_rotation()
deg_step = 5;
step = 180/deg_step;

for i = 1:step+1
    for j = 1:step+1
        orientation_seed(j+(step+1)*(i-1),1) = (i-1)*deg_step;
        orientation_seed(j+(step+1)*(i-1),2) = (j-1)*deg_step;
        orientation_seed(j+(step+1)*(i-1),3) = 0;
    end
end
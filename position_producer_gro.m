function pos = position_producer_gro(height_protein)
surface_height = 16;
 height = round(height_protein*10+surface_height)+1;
 %this should be changed to the middle of the box
pos(1:height+1,1) = 15.23030/2;
pos(1:height+1,2) = 15.31728/2;

for k = 0:height
    pos(k+1,3) = k/10;
end

save('pos.dat','pos','-ascii','-double','-tabs');

end
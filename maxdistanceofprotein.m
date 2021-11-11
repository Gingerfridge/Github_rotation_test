function [output] = maxdistanceofprotein(Thick_protein_slice)
%fixed this function to work on the number of frames not contrasts
number_of_frames = size(Thick_protein_slice);
for i = 1:number_of_frames(1,1)
    output(i,1) = (Thick_protein_slice{i,1}(end,1));
end
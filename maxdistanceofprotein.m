function [output] = maxdistanceofprotein(Thick_protein_slice)

for i = 1:length(Thick_protein_slice)
    output(i,1) = (Thick_protein_slice{i,1}(end,1));
end
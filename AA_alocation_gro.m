function [SLD_of_average_z_res, Vol_of_average_z_res] = AA_alocation_gro(average_z_res,Residues,D2O_frac)
%run after gro_slicer %2
[SL] = amino_acid_SL_gro(D2O_frac,0,0.9);
AA_Names = upper(SL(:,10));
% produce a logic matrix for the AA 20by number of residues
number_of_residues = size(average_z_res);
for i = 1:number_of_residues(1,1)
    Res_Name(1:20,1) = convertCharsToStrings(Residues{i,2});
        Logic_matrix = strcmp(AA_Names,Res_Name);
        Grand_Logic_Matrix(i,1:20) = Logic_matrix;
end

SLD_values = str2double(SL(:,5));
Vol_values = str2double(SL(:,6));
Vol_values = str2double(SL(:,6));

SLD_of_average_z_res = Grand_Logic_Matrix*SLD_values;
Vol_of_average_z_res = Grand_Logic_Matrix*Vol_values;



%this will work it out for just the amino acids

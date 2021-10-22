function [M,Thick_protein_slice,SLD_protein_slice,SLD_layer,Vol_hydrate,slice_Vol, Vol_protein_slice] = Histogram_gro(average_z_res_T,Residues,SLD_of_average_z_res,Vol_of_average_z_res,protein_box_x,protein_box_y,protein_box_z,D2O_frac)
% all gro files
%3
SLD_solvent = D2O_frac*(6.35e-6+0.56e-6)-0.56e-6;

boxarea = protein_box_y*protein_box_x*10*10;  % units (nm*10*nm*10) = [A^2]% this can be defined by the actual grofile later

M = average_z_res_T;
M(:,3) = SLD_of_average_z_res;
M(:,4) = Vol_of_average_z_res;
length = size(M);

%length of slice and how it is sliced needs to be considered
start = -120;
slice_thickness = 0.1;%nm units
finish = max(M(:,1))+0.2;
edges = start:slice_thickness:finish;



Binned_thickness = discretize(M(:,1),edges);
Binned_thickness_calibrated = (Binned_thickness-1)*slice_thickness+start;

M(:,5) = Binned_thickness_calibrated;
%carry out the uniqueness process again to orgainse them

[~,~,X] = unique((M(:,5)));
Binned_Slices = accumarray(X,1:size(M,1),[],@(r){M(r,:)});

s = size(Binned_Slices);

for k = 1:s(1,1)
    SLD_protein_slice(k,1) = mean(Binned_Slices{k,1}(:,3));
    Thick_protein_slice(k,1) = mean(Binned_Slices{k,1}(:,1)-Binned_Slices{1,1}(1,1))*10+1; %*10 to convert nm to [A] % make the thick = 0 with a subtraction of the first number 
    Vol_protein_slice(k,1) = sum(Binned_Slices{k,1}(:,4));
    slice_Vol(k,1) =  boxarea*slice_thickness*10; %units A*A*(nm*10)=[A^3]
end

Vol_hydrate = slice_Vol-Vol_protein_slice
% 

% % % % % 

SLD_layer = (Vol_hydrate*SLD_solvent+Vol_protein_slice.*SLD_protein_slice)/slice_Vol(1,1);

% THIS IS WHERE TO OUTPUT EXTRA INFORMATION TO BE USED (SURFACE COVERAGE
% ETC

%%%%%%%%%%%%%%%%%%%%%%%%%%%THIS IS HOW TO MAKE SLD_protein_slice into the
%%%%%%%%%%%%%%%%%%%%%%%%%%%layer need to use this to be able to "solvate
%%%%%%%%%%%%%%%%%%%%%%%%%%%with air 
%need to wait the SLD by the volume of the protein actually

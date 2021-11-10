function [coverage,x] = calculations_from_SLD()

parentDirectory = pwd;
load(strcat(parentDirectory,'\State_Number.mat'));


parentDirectory = fileparts(cd);
load(strcat(parentDirectory,'\List_of_files.mat'));
load(strcat(parentDirectory,'\SLD_layer.mat'));
load(strcat(parentDirectory,'\Thick_protein.mat'));
load(strcat(parentDirectory,'\List_of_files_rot.mat'));
load(strcat(parentDirectory,'\D2O_frac.mat'));
load(strcat(parentDirectory,'\SLD_protein_slice.mat'));
load(strcat(parentDirectory,'\SLD_slice_Vol.mat'));
load(strcat(parentDirectory,'\Vol_protein_slice.mat'));
load(strcat(parentDirectory,'\Vol_hydrate.mat'));
load(strcat(parentDirectory,'\Max_protein_length.mat'));
load(strcat(parentDirectory,'\area_of_protein_box.mat'));

clear model data options;
problem = getappdata(0,'problem');
oldCalcSLD = problem.calcSLD;
problem.calcSLD = 0;
problem = packparams(problem);
params = createparamarray(problem);

for i = 1:length(params)
    a = params{i,1}(1,1);
    b = 'Hydration_of_Sim';
    holder(i) = ismember(a,b);
    if holder(i) == 1
        hyd_sim = params{i,1}(1,2);
    end
end

if all(holder == 0) == 0
    coverage = (((hyd_sim{1,1}+1)*(area_of_protein_box(State_Number)))*100) %%%%% *100 makes the units A^2
    x = "no error";
else
    x = "change the name of the hydration of the protein box to 'Hydration_of_Sim'"
    coverage = 0;
end



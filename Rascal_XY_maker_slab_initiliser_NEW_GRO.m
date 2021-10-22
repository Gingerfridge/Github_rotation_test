function [xx,yy] = Rascal_XY_maker_slab_initiliser_NEW_GRO(params,bulk_in,bulk_out,contrast,starting_params_number)
%load("data.mat")
% % This is now working nicely just need to add the logic for the loaded
% surfaces (now to change orientation as well as this will be in the Params
% section) %GOING TO WORK ON PRODUCING THE FILES NEEDED FOR THIS!!!!
% LOADIN THE THINGS NEEDED FOR FITTING
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




surface_switch = params(1);
hydration = params(starting_params_number);
Z_offset = params(starting_params_number+1); %removes surface etc.
X_rot = params(starting_params_number+2);
Y_rot = params(starting_params_number+3);
Penetration = params(starting_params_number+4);



%%%%%%% This section finds the files that best matches the input x_rot and
%%%%%%% y_rot (if it is in the middle of two it will choose the first on)
for i = 1:length(List_of_files_rot)
    test_x(1,i) = List_of_files_rot{1,i}(1,1);
end

for i = 1:length(List_of_files_rot)
    test_y(1,i) = List_of_files_rot{1,i}(1,2);
end

dist_x    = abs(test_x - X_rot);
minDist_x = min(dist_x);
minIdx_x  = (dist_x == minDist_x);
minVal_x  = test_x(minIdx_x);

dist_y    = abs(test_y - Y_rot);
minDist_y = min(dist_y);
minIdx_y  = (dist_y == minDist_y);
minVal_y  = test_y(minIdx_y);

Best_index = minIdx_y & minIdx_x;
State_Number = find(Best_index,1,'first');

number_of_states = length(List_of_files_rot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% params(starting_params_number+1) = z_offset;
% params(starting_params_number+2) = x_rot;
% params(starting_params_number+3) = y_rot;7

%this determines the correct orientation to load into rascal
% for i = 1:number_of_states
%     if X_rot == List_of_files_rot{1,i}(1,1)
%         if Y_rot == List_of_files_rot{1,i}(1,2)
%         
%             State_Number = i;
%         
%         else
%         end
%     else
%     end
% end


%%% logic find the D2O_frac that matches the bulk out best 
D2O_frac_exp=bulk_out(contrast)*(1/6.91e-6)+0.56/6.91;
dist    = abs(D2O_frac - D2O_frac_exp);
minDist = min(dist);
minIdx  = (dist == minDist);
minVal  = D2O_frac(minIdx);
contrast_best = find(minIdx);

% % Extract angles from the file name
% loop over all strings
% number_states = length(List_of_files);
%%%%%%%%%%%%%%%%%%%%
%%NEDD TO ADD A BETTER Z OFF SET METHOD THAT IS
%%CONSISTENT%%%%%%%%%%%%%%%%%%%
%this needs to be done based on the layers (done in
%SLD_sim_and_slab_NEW_GRO)
xx = Thick_protein{State_Number,1}(Z_offset:end)-Thick_protein{State_Number,1}(Z_offset);
x = Thick_protein{State_Number,1}(Z_offset:end)-Thick_protein{State_Number,1}(Z_offset);

z_interface = Penetration;

dist_inter    = abs(xx - z_interface);
minDist_inter = min(dist_inter);
minIdx_inter  = (dist_inter == minDist_inter);
minVal_inter  = xx(minIdx_inter);
interface_best = find(minIdx_inter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EDITING HERE
% % % y = (SLD_layer{State_Number,contrast_best}(Z_offset:end)+hydration*bulk_out(contrast))/(hydration+1);%bulk out might need to be bulk out (contrast)
%%% it will be the bulk out contrast 






Z_offset = round(Z_offset);

z_interface_idx_offset = interface_best+Z_offset;


SLD_layer_z_offset_before = (Vol_hydrate{State_Number,contrast_best}(Z_offset:z_interface_idx_offset)*params(starting_params_number-3)+Vol_protein_slice{State_Number,contrast_best}(Z_offset:z_interface_idx_offset).*SLD_protein_slice{State_Number,contrast_best}(Z_offset:z_interface_idx_offset))./(Vol_hydrate{State_Number,contrast_best}(Z_offset:z_interface_idx_offset)+Vol_protein_slice{State_Number,contrast_best}(Z_offset:z_interface_idx_offset));

SLD_layer_z_offset_after = (Vol_hydrate{State_Number,contrast_best}(z_interface_idx_offset+1:end)*bulk_out(contrast)+Vol_protein_slice{State_Number,contrast_best}(z_interface_idx_offset+1:end).*SLD_protein_slice{State_Number,contrast_best}(z_interface_idx_offset+1:end))./(Vol_hydrate{State_Number,contrast_best}(z_interface_idx_offset+1:end)+Vol_protein_slice{State_Number,contrast_best}(z_interface_idx_offset+1:end));

SLD_layer_full = [(SLD_layer_z_offset_before+hydration*params(starting_params_number-3))/(hydration+1);(SLD_layer_z_offset_after+hydration*bulk_out(contrast))/(hydration+1)];

% SLD_layer_z_offset = (Vol_hydrate{State_Number,contrast_best}(Z_offset:end)*bulk_out(contrast)+Vol_protein_slice{State_Number,contrast_best}.*SLD_protein_slice{State_Number,contrast_best})./(Vol_hydrate{State_Number,contrast_best}+Vol_protein_slice{State_Number,contrast_best})


%%%% INSERT CODE THAT 
% FINDS WHERE TO CHANGE FROM BULK OUT TO FIRST SURFACE 
% COULD WRITE IT TO BE UNIVERSAL 




y = (SLD_layer_full(:));%bulk out might need to be bulk out (contrast)
% % % y = (SLD_layer{State_Number,contrast_best}(Z_offset:end)+hydration*bulk_out(contrast))/(hydration+1);%bulk out might need to be bulk out (contrast)




% SLD_layer = (Vol_hydrate*SLD_solvent+Vol_protein_slice.*SLD_protein_slice)/slice_Vol(1,1);

% % yy = spline(x,y,xx);
yy = pchip(x,y,xx);

%%%% SLD_layer should be SLD_protein slice then modify it to the SLD_layer
%%%% here
% % % EDITING THE Z OFFSET HERE!!!!


%OLD WORKING CODE BELOW 08 10 2021
%%%%%% THIS PART IS USED TO MODIFY AND CHOOSE THE SIMULATED DATA

% % % % % % % % working_dir = pwd; %go into where the data is saved
% % % % % % % % cd ..
% % % % % % % % cd ..
% % % % % % % % 
% % % % % % % % 
% % % % % % % % % D2O_Frac = params(2*i+starting_params_number);
% % % % % % % % D2O_Frac = (bulk_out(1,contrast)+0.56e-6)/(6.35e-6+0.56e-6);
% % % % % % % % Hydration = 1; %difined as 1 as the hydration is being fit properly
% % % % % % % % Hydration_for_fitting = 1/params(starting_params_number);
% %%%%%%%%%%%%%ROTATIONAL PARAMS CAN BE DEFINED
% % % % % % % % %need to convert hydration to the same scale as 'Hydration variable'
% % % % % % % % %change the rounding for more pricise
% % % % % % % % D2O_Frac = round(D2O_Frac,2);
% % % % % % % % Hydration = round(Hydration,0);
% % % % % % % % st_val = bulk_in(contrast);
% % % % % % % % end_val = bulk_out(contrast);
% % % % % % % % 
% % % % % % % % 
% % % % % % % % [file_names,D2O_frac_list,Hydration_list] = get_Data(pwd); %import the data from the simulation
% % % % % % % % 
% % % % % % % % %insert logic to serch for the best fit here
% % % % % % % % size_Dataset = size(D2O_frac_list);
% % % % % % % % 
% % % % % % % % 
% % % % % % % % 
% % % % % % % % for k = 1:size_Dataset(1,1)
% % % % % % % %     if D2O_frac_list(k,1) == D2O_Frac
% % % % % % % %         D2O_logic(k,1) = 1;
% % % % % % % %     else
% % % % % % % %         D2O_logic(k,1) = 0;
% % % % % % % %     end
% % % % % % % % end
% % % % % % % % 
% % % % % % % % for k = 1:size_Dataset(1,1)
% % % % % % % %     if Hydration_list(k,1) == Hydration
% % % % % % % %         Hydration_logic(k,1) = 1;
% % % % % % % %     else
% % % % % % % %         Hydration_logic(k,1) = 0;
% % % % % % % %     end
% % % % % % % % end
% % % % % % % % 
% % % % % % % % Winner = Hydration_logic & D2O_logic;
% % % % % % % % 
% % % % % % % % WINNER = find(Winner, 1, 'first');
% % % % % % % % 
% % % % % % % % SLD_AA_Hydrated_Profile_struct = load(file_names{WINNER,1});
% % % % % % % % 
% % % % % % % % %just loading the the right d2o frac and hydration (not for fitting relic of the past as 1)
% % % % % % % % 
% % % % % % % % SLD_AA_Hydrated_Profile = SLD_AA_Hydrated_Profile_struct.SLD_AA_Hydrated_Profile;

% % % % % % % % xx = 0:SLD_AA_Hydrated_Profile(end,1);
% % % % % % % % x = SLD_AA_Hydrated_Profile(:,1);
% % % % % % % % y = (SLD_AA_Hydrated_Profile(:,2)+(Hydration_for_fitting-1)*bulk_out(contrast))/(Hydration_for_fitting);%bulk out might need to be bulk out (contrast)
% % % % % % % % %yy = spline(x,y,xx);
% % % % % % % % yy = pchip(x,y,xx);
% % % % % % % % 
% % % % % % % % cd(working_dir)

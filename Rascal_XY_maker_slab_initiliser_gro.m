function [xx,yy] = Rascal_XY_maker_slab_initiliser_gro(params,bulk_in,bulk_out,contrast,starting_params_number)

%this function take the protein SLD profile and prepares it based on the
%factors at play, i.e. distance from surface, hydration and contrasts  
load('C:\Users\mbcx4ph5\Dropbox (The University of Manchester)\PhD\RasCAL_2019\Folder_NumDens_00010_00010_Job_48_59\SLD_profiles\SLD_profiles_Rascal\Project\List_of_files.mat')
load('C:\Users\mbcx4ph5\Dropbox (The University of Manchester)\PhD\RasCAL_2019\Folder_NumDens_00010_00010_Job_48_59\SLD_profiles\SLD_profiles_Rascal\Project\SLD_layer.mat')
load('C:\Users\mbcx4ph5\Dropbox (The University of Manchester)\PhD\RasCAL_2019\Folder_NumDens_00010_00010_Job_48_59\SLD_profiles\SLD_profiles_Rascal\Project\Thick_protein.mat')

%need to define the rotation parameters from the naming convention
% Hydration
% Move proteininto surface
% rot_x
% rot_y


xx = Thick_protein{7,1};
x = Thick_protein{7,1};


y = SLD_layer{7,1};%bulk out might need to be bulk out (contrast)
%yy = spline(x,y,xx);
yy = pchip(x,y,xx);

% 
% 
% % D2O_Frac = params(2*i+starting_params_number);
% D2O_Frac = (bulk_out(1,contrast)+0.56e-6)/(6.35e-6+0.56e-6);
% Hydration = 1; %difined as 1 as the hydration is being fit properly
% Hydration_for_fitting = 1/params(starting_params_number);
% %need to convert hydration to the same scale as 'Hydration variable'
% %change the rounding for more pricise
% D2O_Frac = round(D2O_Frac,2);
% Hydration = round(Hydration,0);
% 
% st_val = bulk_in(contrast);
% end_val = bulk_out(contrast);
% 
% %create a data gathering function
% 
% [file_names,D2O_frac_list,Hydration_list] = get_Data(pwd);
% 
% %insert logic to serch for the best fit here
% size_Dataset = size(D2O_frac_list);
% 
% 
% 
% for k = 1:size_Dataset(1,1)
%     if D2O_frac_list(k,1) == D2O_Frac
%         D2O_logic(k,1) = 1;
%     else
%         D2O_logic(k,1) = 0;
%     end
% end
% 
% for k = 1:size_Dataset(1,1)
%     if Hydration_list(k,1) == Hydration
%         Hydration_logic(k,1) = 1;
%     else
%         Hydration_logic(k,1) = 0;
%     end
% end
% 
% Winner = Hydration_logic & D2O_logic;
% 
% WINNER = find(Winner, 1, 'first');
% 
% SLD_AA_Hydrated_Profile_struct = load(file_names{WINNER,1});
% 
% %just loading the the right d2o frac and hydration (not for fitting relic of the past as 1)
% 
% SLD_AA_Hydrated_Profile = SLD_AA_Hydrated_Profile_struct.SLD_AA_Hydrated_Profile;
% 
% xx = 0:SLD_AA_Hydrated_Profile(end,1);
% x = SLD_AA_Hydrated_Profile(:,1);
% y = (SLD_AA_Hydrated_Profile(:,2)+(Hydration_for_fitting-1)*bulk_out(contrast))/(Hydration_for_fitting);%bulk out might need to be bulk out (contrast)
% %yy = spline(x,y,xx);
% yy = pchip(x,y,xx);
% 
% cd(working_dir)

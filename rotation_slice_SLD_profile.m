function [Loading_roation,Loading_Slicer,Loading_SLD] = rotation_slice_SLD_profile(protein_nickname,protein_filename,Rotation_increment,Working_directory,D2O_frac)
% order of running
%05/11/21 Plan is to add simulation capability (rename z offset to make it
%so it is a frame reader (check vmd for the format it outputs files)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      MOVE TO THE DIRECTORY WITH YOUR SURFACE AND PROTEIN      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this program will take a surface (perp in the Z dir) and rotate a protein
% around on the surface (almost/touching)

% once you have the gro files you want to analyse
% % % % % %  no output list height_protein = rotation_of_protein_gro(step_rot_x,step_rot_y,protein_filename,protein_nickname,surface_filename,surface_nickname) %% all gro files
start = 0;
finish = 180;
orientation_seed = seed_rotation(Rotation_increment,start,finish); % angle between gro files in x rotation and y
Working_directory;
data.protein_filename = protein_filename;


data.protein_nickname = protein_nickname; %%%NO NUMBERS IN THIS NAME


data.surface_filename = "SO_2_5point5_align.gro";
data.surface_nickname = "SO"; %%%NO NUMBERS IN THIS NAME
data.step_rot_x = 180;
data.step_rot_y = 180;
data.D2O_frac = D2O_frac; %%%% ADD which contrasts you have here (this will make it run much longer


% no surface required
% if rotation run this 
[height_protein, List_of_files, List_of_files_rot, Loading_roation, Output0] = rotation_of_protein_gro(data.step_rot_x,data.step_rot_y,data.protein_filename,data.protein_nickname,data.surface_filename,data.surface_nickname,orientation_seed)
% if simulation run this 
% dont forget that the fitting will be different (naming based on the z
% value 


save('height_protein.mat','height_protein')
save('List_of_files.mat','List_of_files')
save('List_of_files_rot.mat','List_of_files_rot')
% % % % % % THIS WORKS WELL 10:29 08 10 21

%  run
%  "SO_2_5point5_nip_180_180_0.gro"
%%%%% add a loop here that runs this function then saves the results in
%%%%% seperate files
%loop using the List of files saved variables
number_of_states = size(List_of_files);
data.number_of_states = number_of_states(1,2);
Loading_Slicer = ["Loading Slicer (2/3)..." + "0" + "%"];
h = waitbar(0,'Loading Slicer (2/3)...');
for i = 1:number_of_states(1,2)
    [average_z_res_T, Residues,protein_box_x,protein_box_y,protein_box_z] = gro_slicer_gro(List_of_files(1,i)); % all gro files
    %create a data structure to store the information
    data.average_z_res_T{i,1} = average_z_res_T;
    data.Residues{i,1} = Residues;
    data.protein_box_x{i,1} = protein_box_x;
    data.protein_box_y{i,1} = protein_box_y;
    data.protein_box_z{i,1} = protein_box_z;
    data.state_name{i,1} = List_of_files(1,i);
    Loading_Slicer = ["Slicing protein (2/3)..." + 100*i/number_of_states(1,2) + "%"];
    waitbar(i/number_of_states(1,2),h,'Slicing protein (2/3)...');
end
close(h)
%  followed by creates a data structure with all the information needed
protein_box_x = data.protein_box_x;
save('protein_box_x','protein_box_x')
protein_box_y = data.protein_box_y;
save('protein_box_y','protein_box_y')
protein_box_z = data.protein_box_z;
save('protein_box_z','protein_box_z')

data.number_contrasts = size(data.D2O_frac);
data.number_contrasts(2) = [];

%Loop over all ""states"" and all contrasts
Loading_SLD = ["Loading SLD profile producer (3/3)..." + "0" + "%"];
h = waitbar(0,'Loading SLD profile producer (3/3)...');
for i = 1:data.number_of_states
    for j =1:data.number_contrasts
        [data.SLD_of_average_z_res{i,j}, data.Vol_of_average_z_res{i,j}] = AA_alocation_gro(data.average_z_res_T{i,1},data.Residues{i,1},data.D2O_frac(j,1)); % all gro files
        [data.M{i,j},data.Thick_protein_slice{i,j},data.SLD_protein_slice{i,j},data.SLD_layer{i,j},data.Vol_hydrate{i,j},data.slice_Vol{i,j}, data.Vol_protein_slice{i,j}] = Histogram_gro(data.average_z_res_T{i,1},data.Residues{i,1},data.SLD_of_average_z_res{i,1},data.Vol_of_average_z_res{i,1},data.protein_box_x{i,1},data.protein_box_y{i,1},data.protein_box_z{i,1},data.D2O_frac(j,1));

    end
    Loading_SLD = ['Producing SLD profiles (3/3)...' + 100*i/data.number_of_states + "%"];
    h = waitbar(i/data.number_of_states,h,'Producing SLD profiles (3/3)...');
end


% %  next step is to histogram it
%
% % % % % % % % % % % % % % % % % % 
% save('data.mat','data','-v7.3') % This will save a massive data set no
% need 
% % % % % % % % % % % % % % % % % % 

% % % SAVE only the parts needed for fitting 
Thick_protein = data.Thick_protein_slice;
SLD_layer = data.SLD_layer;
D2O_frac = data.D2O_frac;
Vol_hydrate = data.Vol_hydrate;
SLD_protein_slice = data.SLD_protein_slice;
SLD_slice_Vol = data.slice_Vol;
Vol_protein_slice = data.Vol_protein_slice;

Thick_protein_slice = data.Thick_protein_slice;
save('Thick_protein_slice.mat','Thick_protein_slice');

save('SLD_protein_slice.mat','SLD_protein_slice');
save('Thick_protein.mat','Thick_protein');
save('SLD_layer.mat','SLD_layer');
save('D2O_frac.mat','D2O_frac');

save('SLD_slice_Vol.mat','SLD_slice_Vol');
save('Vol_protein_slice.mat','Vol_protein_slice');
save('Vol_hydrate.mat','Vol_hydrate');
close(h)

%create the limit in the z axis
[Max_protein_length] = maxdistanceofprotein(Thick_protein_slice);
Max_protein_length = Max_protein_length-2;
save('Max_protein_length.mat','Max_protein_length');

% save the are of the protein box for the calculation of the moles per unit
% area 

for i = 1:length(protein_box_x)
    area_of_protein_box(i,1) = protein_box_x{i,1}(1,1)*protein_box_x{i,1}(1,1);
end
save('area_of_protein_box.mat','area_of_protein_box');


h = waitbar(0.02,'Saving data please wait');

save('data.mat','data','-v7.3')

h = waitbar(1,h,'COMPLETE')
% YOU NOW HAVE A DATA STRUCT WITH THE sld PROFILE OF THE AMINO ACIDS FROM
% YOUR GRO FILE 


% this gives an SLD profile but with no hydration parmeters now need to
% consider the Volume of each slice and how this effects things! 
% first Define the box hydration then go one to define the extra hydration
% (added later)
% % % % % 
% 
% 
%  WORKS! need to work out a more effient way of loading the data as it
%  seems that matlab is crashing 



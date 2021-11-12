function [average_z_res_T, Residues,protein_box_x,protein_box_y,protein_box_z] = gro_slicer_gro(file_name)

% 08 10 2021  all gro files replaced

%1
%make a slicer for just a gro file 
% Taking a gro file and slicing it using the volume predefined in
% amino_acid_SL.m. will work based on volume of amino acid with a
% additional volume for the hydration surface coverage can easily be worked
% out from there
%



% Load the gro file 
% Have a loop load all orientations
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
% % % file_name = "SO_2_5point5_nip_0_0_0.gro"
gro_file = full_gro_inport_gro(file_name, 3, inf);
gro_file(end,:) = []; %Delete last row to remove box size!

% % this reads and organises the .gro file

% find the box size of the protein


% % % reside information has res number followed by the tricode for the amino
% % % % acid
length = size(gro_file);
for i = 1:length(1,1)
    residue_number_andsome=regexp(convertStringsToChars(gro_file{i,1}),'\d+(\.)?(\d+)?','match');
    residue_information{i,1} = residue_number_andsome(1,1);
    residue_information{i,2} = extractAfter(gro_file{i,1},residue_information{i,1});
    residue_information{i,3} = gro_file{i,6}; %z
    residue_information{i,4} = gro_file{i,5}; %y
    residue_information{i,5} = gro_file{i,4}; %y
    protein_box_x(i,1) = gro_file{i,4}(1,1);
    protein_box_y(i,1) = gro_file{i,5}(1,1);
    protein_box_z(i,1) = gro_file{i,6}(1,1);
end

protein_box_x = max(protein_box_x)-min(protein_box_x);
protein_box_y = max(protein_box_y)-min(protein_box_y);
protein_box_z = max(protein_box_z)-min(protein_box_z);
% average the z location of the residues



% Creates a cell structure that holds the information of each residue


%%%% FIXED!!!!! creates a residue for all the amino acid atoms
Residues = residue_maker(residue_information);
size_Residues = size(Residues);

for i = 1:size_Residues(1,1)
    size_Residue = size(Residues{i,1});
    for j = 1:size_Residue(1,1)
        z_values(j) = str2double(Residues{i,1}(j,3));
        y_values(j) = str2double(Residues{i,1}(j,4));
        x_values(j) = str2double(Residues{i,1}(j,5));
        res_number_reordered_char = str2double((Residues{i,1}{1,1}));
        res_number_reordered(i) = str2double(res_number_reordered_char);
    end
    
% %     average z position will add x and y for the ploting 
    average_z_res_T(i,1) = sum((z_values(1:size_Residue)))/size_Residue(1,1);
    average_y_res_T(i,1) = sum((y_values(1:size_Residue)))/size_Residue(1,1);
    average_x_res_T(i,1) = sum((x_values(1:size_Residue)))/size_Residue(1,1);
%     average_z_res_T(i,2) = (res_number_reordered(i)); 
    Residues{i,2} = Residues{i,1}{1,2};
end

average_z_res = transpose(average_z_res_T);
%make the residues contain the x, y and sld of the protein
[temp, order] = sort(average_z_res(:,1));
answer = average_z_res(order,:);



%LOGIC STRUCTURE TO DEFINE AMINO ACID





% need to test for amino acid average z l


% determine the z position and the amino acid residue 
% gonna use this after setting up the z coordinates or it will take too long
% [SL] = amino_acid_SL(D2O_frac,0,0.9) %function to define d2o status and sld/ volume of amino acid etc

 
 % create SLD profile 

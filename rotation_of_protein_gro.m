function [height_protein, List_of_files, List_of_files_rot,Loading_roation,Output0] = rotation_of_protein_gro(step_rot_x,step_rot_y,protein_filename_pre,protein_nickname,surface_filename,surface_nickname,orientation_seed)
%need to make this so it accepts a name rather than 
% 08 10 2021 all gro files added (not checked)

% this function takes a protein, aligns it via its principle axis then
% saves rotated versions varying by 1 deg
%gmx editconf -f nip.gro -o nip_0_0_0_c.gro -princ  -center 0 0 0 

% % % % EXAMPLE % % % % % % % % % % % % % % % % % % % % % % % 
% % % % protein_filename = "nip_0_0_0_c.gro"
% % % % protein_nickname = "NIP"
% % % % surface_filename = "SO_2_5point5_align.gro"
% % % % surface_nickname = "SO_2"
% Produce the different orientations. Then add the surface under the protein
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


%Change this so it accepts a list of rotations and "frames" of a simulation

x_rot = 0;
y_rot = 0;
z_rot = 0;

% % % step_rot_x = 120;
% % % step_rot_y = 120;
%MAKE SURE THE BOX OF THE GRO FILE IS SMALLEST
protein_filename = [protein_filename_pre + "_min.gro"]
[c,Output0] = system("wsl gmx editconf -f " + protein_filename_pre + " -o " + protein_filename + " -bt cubic -d 0 -center 0 0 0",'-echo')

% 1135 141021 remove princ axis
% [c,Output0] = system("wsl gmx editconf -f " + protein_filename_pre + " -o " + protein_filename + " -bt cubic -d 0 -center 0 0 0 -princ",'-echo')


%%%% need to write code that reads the box around the protein 
%%%% for the length of a the string file 

rotation_check = 1;
if rotation_check == 1
    Loading_roation = ["Loading " + "0" + "%"]
    for k = 1:length(orientation_seed)
%     for i = 0:180/step_rot_y
%         y_rot = i*step_rot_y;
%         for j = 0:180/step_rot_x % length of the list of values 
%             x_rot = j*step_rot_x;
            %%%%need the gro file to have the z dimention in the 6th collumn 
            
            %%%%% What to make a box that is the size of the protein but 
            x_rot = orientation_seed(k,1);
            y_rot = orientation_seed(k,2);
            [d,Output1] = system("wsl gmx editconf -f " + protein_filename + " -o " + protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro -rotate " + x_rot + " " + y_rot + " " + z_rot );
            z = importfile1_for_rot_gro(protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro", 3, inf); %%%% GRO FUNCTION
              height_protein(k,1) = max(z)-min(z);
            pos = position_producer_gro(height_protein(k,1)); %%%% GRO FUNCTION
            [e,Output2] = system("wsl gmx insert-molecules -f " + surface_filename +  " -ci " + protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro -o " + surface_nickname +  "_" + protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro -ip pos.dat -nmol 1 -rot none");       
            List_of_files(k) = [surface_nickname + "_" + protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro"] % this one to include the surface
    % % % % % %         List_of_files((j+1)+(180/step_rot_y)*i) = [protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro"];
            List_of_files_rot{k} = [x_rot, y_rot, z_rot];
%         end
        Loading_roation = ["Loading " + 100*k/length(orientation_seed) + "%"]
    end
else
%%%%%%% add code for the simulation fitting     
end


%         [e,Output2] = system("wsl gmx pdb2gmx -f nip_0_0_0_c.gro -o nip_0_0_0_c_top.gro");
%         [e,Output2] = system("wsl gmx editconf -f SO_2_5point5.gro -o SO_2_5point5_align.gro -translate 0 0 -7.5");
%         [q,w] = system(['wsl tail -n ',num2str(1),' ',nip_30_135_0_c.gro]);

%           Get values from the end of a file  [q,w] = system(['wsl tail -n ',num2str(1),' ','nip_' + x_rot + "_" + y_rot + "_" + z_rot + '_c.gro'])
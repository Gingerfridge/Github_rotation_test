function [Residues] = SLD_producer_for_plotting(file_name)

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
    residue_information{i,3} = gro_file{i,6};
    protein_box_x(i,1) = gro_file{i,4}(1,1);
    protein_box_y(i,1) = gro_file{i,5}(1,1);
    protein_box_z(i,1) = gro_file{i,6}(1,1);
end

protein_box_x = max(protein_box_x)-min(protein_box_x);
protein_box_y = max(protein_box_y)-min(protein_box_y);
protein_box_z = max(protein_box_z)-min(protein_box_z);
% average the z location of the residues



% Creates a cell structure that holds the information of each residue
[~,~,X] = unique(cell2table(residue_information(:,1)));
Residues = accumarray(X,1:size(residue_information,1),[],@(r){residue_information(r,:)});

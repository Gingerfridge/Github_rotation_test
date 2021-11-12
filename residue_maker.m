function Residues = residue_maker(residue_information)

inside_residue_count = 1;
residue_count = str2double(residue_information{1,1}(1,1));
loop_length = size(residue_information);
for i = 1:loop_length(1,1)
    if str2double(residue_information{i,1}(1,1)) == 1
        Residues{residue_count,1}(inside_residue_count,2) = (residue_information{i,2}(1,1));
        Residues{residue_count,1}(inside_residue_count,1) = (residue_information{i,1}(1,1));
        Residues{residue_count,1}(inside_residue_count,3) = (residue_information{i,3}(1,1));
        Residues{residue_count,1}(inside_residue_count,4) = (residue_information{i,4}(1,1));
        Residues{residue_count,1}(inside_residue_count,5) = (residue_information{i,5}(1,1));
        inside_residue_count = inside_residue_count+1;
    elseif str2double(residue_information{i,1}(1,1)) == str2double(residue_information{i-1,1}(1,1))
        Residues{residue_count,1}(inside_residue_count,2) = (residue_information{i,2}(1,1));
        Residues{residue_count,1}(inside_residue_count,1) = (residue_information{i,1}(1,1));
        Residues{residue_count,1}(inside_residue_count,3) = (residue_information{i,3}(1,1));
        Residues{residue_count,1}(inside_residue_count,4) = (residue_information{i,4}(1,1));
        Residues{residue_count,1}(inside_residue_count,5) = (residue_information{i,5}(1,1));
        inside_residue_count = inside_residue_count+1;
    else
        residue_count = residue_count+1;
        inside_residue_count = 1;
    end
end

    
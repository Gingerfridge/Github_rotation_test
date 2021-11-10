function [List_of_files,List_of_files_rot] = simulation_frame_producer(start_time,end_time,time_step,xtc_name,tpr_name,protein_nickname)
% this function will create the files needed to be sliced etc
% [d,Output1] = system("wsl gmx editconf -f " + protein_filename + " -o " + protein_nickname + "_" + x_rot + "_" + y_rot + "_" + z_rot + ".gro -rotate " + x_rot + " " + y_rot + " " + z_rot );
% all that is needed is a list of file names that correspond to gro files
times = start_time:time_step:end_time;
%time in the simulation is in pico seconds

fid=fopen('Protein_only.txt','w');
fprintf(fid, '%f %f \r\n', [1]');
fclose(fid);

h = waitbar(0,'Extracting frames (1/3)');
for i = 1:length(times)
    [d,Output1] = system("wsl gmx trjconv -f " + xtc_name + " -s " + tpr_name + " -o " + protein_nickname + "_0_0_" + times(i) + ".gro -dump " + times(i) + " <  Protein_only.txt");
    [c,Output0] = system("wsl gmx editconf -f " + protein_nickname + "_0_0_" + times(i) + ".gro -o " + protein_nickname + "_0_0_" + times(i) + ".gro" + " -bt cubic -d 0 -center 0 0 0",'-echo')

    List_of_files(i) = [protein_nickname + "_0_0_" + times(i) + ".gro"]; % this one to include the surface
    List_of_files_rot{i} = [0, 0, times(i)];
    waitbar(i/length(times),h,'Extracting frames (1/3)')
end
close(h)
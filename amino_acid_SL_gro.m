% This function outputs a table with: (1) The code for amino acids, (2)
% Name of the amino acids, (3) the SL from the solution and protein
% conditions, (4) SL from the protein in H2O, (5) the SLD from in
% A^-2(3),(6) is the molecular weight of the the amino acid.
function [SL] = amino_acid_SL_gro(D2O_frac,Deuteration_frac,exchange_fraction)

load('amino_acid_data_atomic_data_numbers_gro.mat');
load('amino_acid_data_atomic_data_gro.mat');
Tri_code = load('Data_forAmino_acids_gro.mat');

for k = 1:20
    [SL(k,1)] = amino_acid_atomic_data(k+1,1);
    [SL(k,2)] = amino_acid_atomic_data(k+1,2);
    [SL(k,3),SL(k,4)] = amino_acid_SL_calc_gro(amino_acid_atomic_data_numbers(k,1),amino_acid_atomic_data_numbers(k,2),amino_acid_atomic_data_numbers(k,3),amino_acid_atomic_data_numbers(k,4),amino_acid_atomic_data_numbers(k,5),amino_acid_atomic_data_numbers(k,6),D2O_frac,Deuteration_frac,exchange_fraction); %in cm
     SL(k,5) = str2double(SL(k,3))/amino_acid_atomic_data_numbers(k,8)*10^8;
     [~,~,SL(k,6)] = amino_acid_SL_calc_gro(amino_acid_atomic_data_numbers(k,1),amino_acid_atomic_data_numbers(k,2),amino_acid_atomic_data_numbers(k,3),amino_acid_atomic_data_numbers(k,4),amino_acid_atomic_data_numbers(k,5),amino_acid_atomic_data_numbers(k,6),D2O_frac,Deuteration_frac,exchange_fraction);
     [SL(k,9)] = sum(amino_acid_atomic_data_numbers(k,2:6)); 

end

SL(:,10) = Tri_code.SL(:,12);
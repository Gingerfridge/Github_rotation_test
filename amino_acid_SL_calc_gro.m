function [amino_acid_scattering_length,scattering_length_of_atoms,MW_amino_acid_with_D2O] = amino_acid_SL_calc_gro(exchangeable_hydrogen,C,H,N,O,S,fraction_D2O_in_solution,deuteration_fraction,fraction_that_exchange)
% data from https://www.isis.stfc.ac.uk/Pages/sears---neutron-cross-section-table10655.pdf
% http://psldc.isis.rl.ac.uk/Psldc/manual.htm
b_H1 = -0.374e-12; %in cm
b_H2 = 0.667e-12;
b_C12 = 0.665e-12;
b_N14 = 0.940e-12;
b_O16 = 0.580e-12;
b_S32 = 0.280e-12;
b_H2O = -0.168e-12; % in cm
b_D2O = 1.915e-12;  % in cm

m_H1  = 1.00782505; % in g/mol
m_H2  = 2.014102;
m_C12 = 12.0107;
m_N14 = 14.0067;
m_O16 = 15.9994;
m_S32 = 32.065;
m_H2O = 2*m_H1+m_O16; % in cm
m_D2O = 2*m_H2+m_O16;  % in cm


scattering_length_of_atoms = (b_H1*H)+(b_C12*C)+(b_N14*N)+(b_O16*O)+(b_S32*S);
amino_acid_scattering_length = scattering_length_of_atoms + (H-exchangeable_hydrogen)*deuteration_fraction*(b_H2-b_H1)+exchangeable_hydrogen*fraction_that_exchange*fraction_D2O_in_solution*(b_H2-b_H1);

MW_amino_acid = (m_H1*H)+(m_C12*C)+(m_N14*N)+(m_O16*O)+(m_S32*S);
MW_amino_acid_with_D2O = (m_H1*H)+(m_C12*C)+(m_N14*N)+(m_O16*O)+(m_S32*S)+ (H-exchangeable_hydrogen)*deuteration_fraction*(m_H2-m_H1)+exchangeable_hydrogen*fraction_that_exchange*fraction_D2O_in_solution*(m_H2-m_H1);
end
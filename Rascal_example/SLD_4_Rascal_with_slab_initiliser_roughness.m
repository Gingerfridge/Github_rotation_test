function [output] = SLD_4_Rascal_with_slab_initiliser_roughness(params,bulk_in,bulk_out,contrast)

%include logic if you want to include additional SLD profile?

%change params 1 to be this switch
%for now add silcon substrate
surface_switch = params(1);

if surface_switch == 1
    [xx,yy] = SLD_sim_and_slab(params,bulk_in,bulk_out,contrast,surface_switch)    
elseif surface_switch == 2
    [xx,yy] = SLD_sim_and_slab(params,bulk_in,bulk_out,contrast,surface_switch)    

%only simulation SLD
else
        layNumber = params(2); %initilising the number of layers wanted in the fit
    for j = 1:layNumber
        layThickness(j) = params(4*j-1);
        laySLD(j) = params(4*j);
        layRough(j) = params(4*j+1);
        layHydration(j) = params(4*j+2);
    end
    %define the number of parameter before the simulation data
    starting_params_number = 3+4*layNumber;
    [xx,yy] = Rascal_XY_maker_slab_initiliser(params,bulk_in,bulk_out,contrast,starting_params_number);


end
    for k = 1:contrast
    switch contrast
   
        case {k}
        output = [xx(:) yy(:)] ;
    end
%    case {3,4}
%        output = [ xx(:) yy(:) ]  ;
    end
end
function [xx,yy,hydration,State_Number] = SLD_sim_and_slab_NEW_GRO(params,bulk_in,bulk_out,contrast,surface_switch)
SLD_Step = 0.1;
%input here the parameters needed to make a slab model

    layNumber = params(2);     %initilising the number of layers wanted in the fit
    starting_params_number = 3+4*layNumber;
     j = 1;
        layers(j,1) = params(4*j-1);
        SLD_no_water(j,1) = params(4*j);
        layHydration(j,1) = params(4*j+2);
        layers(j,2) = (layHydration(j,1)*bulk_in(contrast))+((1-layHydration(j,1))*SLD_no_water(j,1));


        layers(j,3) = params(4*j+1);


   

    for j = 2:layNumber
        layers(j,1) = params(4*j-1);
        SLD_no_water(j,1) = params(4*j);
        layHydration(j,1) = params(4*j+2);
        layers(j,2) = (layHydration(j,1)*bulk_out(contrast))+((1-layHydration(j,1))*SLD_no_water(j,1));


        layers(j,3) = params(4*j+1);
    end

     if surface_switch == 1
         j = layNumber;
         if params(starting_params_number+4) <  params(starting_params_number-4)-2
            z_interface = params(starting_params_number+4)-2;
        else
            z_interface =  params(starting_params_number-4)-2;
        end
        layers(j,1) = params(4*j-1)-z_interface;
        SLD_no_water(j,1) = params(4*j);
        layHydration(j,1) = params(4*j+2);
        layers(j,2) = (layHydration(j,1)*bulk_out(contrast))+((1-layHydration(j,1))*SLD_no_water(j,1));
        layers(j,3) = params(4*j+1);
     end
    %define the number of parameter before the simulation data
% % % % % % % % % % % % % % % % % % 
% Layer 4 needs to be limited to the size of the protein AS DOES THE
% PENETRATION
% % % % % % % % % % % % % % % % 
    distance = sum(layers(:,1))-2*layers(layNumber,1);


    %layers is[ thickness SLD roughness]
    %change bulk out to be the last layer for just the surface add a fully
    %hydrated layer for bulk out
    [out,totalRange] = makeSLDProfileXY_for_peter_3(bulk_in(contrast),bulk_out(contrast),layers(1,3),layers,layNumber,distance);
    
%     can add an if statement that mixes the states!!!
%     might be hard work 
    
    xout = out(:,1);
    yout = out(:,2);

    if surface_switch == 1

    % this adds the simultion to the slab model
    
    % want to add a blending based on the "hydration" paramter 
    
    % average the sld of the slab layer with the protein layer
%     hydration*bulk_out(contrast))/(hydration+1)
% y = (SLD_layer{State_Number,contrast_best}(Z_offset:end)+hydration*bulk_out(contrast))/(hydration+1);%bulk out might need to be bulk out (contrast)
    
%%% this tracker isn't working well
%five ang between data make this zero?

    [xx,yy,hydration,State_Number] = Rascal_XY_maker_slab_initiliser_NEW_GRO(params,bulk_in,bulk_out,contrast,starting_params_number);
    tracker = totalRange;
    xx=xx(:)+tracker+2;
    yy=yy(:);
    xx = [xout(:)+4; xx(:)];
    yy = [yout(:); yy(:)];
    
    

    %this adds the water layer (bulk out to the slab model)
    elseif surface_switch == 2
        xx = xout(:);
        yy = yout(:);
    end



end

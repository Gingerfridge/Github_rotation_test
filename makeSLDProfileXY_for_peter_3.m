function [out,totalRange] = makeSLDProfileXY_for_peter_3(nbair,nbsub,ssub,layers,numberOfLayers,distance);


if numberOfLayers>0
    %work out total range....
    layerThicks = sum(layers(:,1));
    totalRange = layerThicks + distance;   %50 � either side for air and sub..
    x = 0:totalRange;

    %1. Make air box...
    boxCen = 0;
    boxWidth = totalRange;

    boxRough = layers(1,3);
    airBox = asymconvstep(x,boxWidth,boxCen,boxRough,boxRough,nbair);
    lastBoxEdge = boxCen + (boxWidth/2);

    for i = 1:numberOfLayers-1;
        thisLayThick = layers(i,1);
        thisLaySLD = layers(i,2);
        thisLayRough = layers(i,3);
        nextLayRough = layers(i+1,3);
        thisBoxCentre = lastBoxEdge + (thisLayThick/2);
        Lays(:,i) = asymconvstep(x,thisLayThick,thisBoxCentre,thisLayRough,nextLayRough,thisLaySLD);
        lastBoxEdge = thisBoxCentre + (thisLayThick/2);
    end

    thisLayThick = layers(numberOfLayers,1);
    thisLaySLD = layers(numberOfLayers,2);
    thisLayRough = layers(numberOfLayers,3);
    nextLayRough = 0.5;
    thisBoxCentre = lastBoxEdge + (thisLayThick/2);
    Lays(:,numberOfLayers) = asymconvstep(x,thisLayThick,thisBoxCentre,thisLayRough,nextLayRough,thisLaySLD);
    lastBoxEdge = thisBoxCentre + (thisLayThick/2);


%
    %substrate
%    thisLayThick = (x(end)-lastBoxEdge)*2;
%    thisLaySLD = nbsub;
%    thisLayRough = ssub;
%    nextLayRough = ssub;
%    thisBoxCentre = x(end);
%    Lays(:,numberOfLayers+1) = asymconvstep(x,thisLayThick,thisBoxCentre,thisLayRough,nextLayRough,thisLaySLD);
    Lays(:,numberOfLayers+2) = airBox;

    SLD = sum(Lays,2);

else
    x = 0:100;
    subsBoxCen = max(x);
    airBoxCen = 0;
    widths = max(x);
    airBox = asymconvstep(x,widths,airBoxCen,ssub,ssub,nbair);
    subBox = asymconvstep(x,widths,subsBoxCen,ssub,ssub,nbsub);
    SLD = airBox + subBox;
end
x = x(:);
x(end-2:end) = [];
SLD = SLD(:);
SLD(end-2:end) = [];

out = [x(:),SLD(:)];

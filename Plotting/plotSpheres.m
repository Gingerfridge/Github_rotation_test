function S = plotSpheres(x, y, z, r, color)
% Get current axes held state.
held = ishold;
% Hold the axes of the current plot so we append to it.
hold on
% Get how many points we are using and check the dimensions match.
Npts = numel(x);
assert(Npts == numel(y));
assert(Npts == numel(z));
% Divide the radius number. This helps keep it in the integer range.
r = r/100;
% Get the current axes scales. (Unforunately the spheres will stretch if
% the axes are resized later.)
ax = gca;
xscale = ax.XLim(2) - ax.XLim(1);
yscale = ax.YLim(2) - ax.YLim(1);
zscale = ax.ZLim(2) - ax.ZLim(1);
% Preallocate the graphics object array.
S = gobjects(Npts, 1);
% Loop through all the give points.
for i = 1:Npts
    
    % Make a unit sphere.
    [X, Y, Z] = sphere;
    
    % Scale and shift the sphere.
    X = X*r*xscale + x(i);
    Y = Y*r*yscale + y(i);
    Z = Z*r*zscale + z(i);
    
    % Plot the sphere.
    S(i) = surf(X, Y, Z);
    
    % Visualization settings.
    set(S(i), 'FaceColor', color); % Set color.
    set(S(i), 'EdgeColor', 'none'); % Hide edges (wireframe).
    set(S(i), 'FaceLighting', 'gouraud'); % Set fancy lighting.
end
% Return to the hold status that it initially had.
if held; hold on; else; hold off; end
end
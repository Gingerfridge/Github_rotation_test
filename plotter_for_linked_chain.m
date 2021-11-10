function plotter_for_linked_chain(chain_linked,sschain_linked)

clf


x = chain_linked(:,3)
y = chain_linked(:,4)
z = chain_linked(:,1)
max_hydration = max(sschain_linked);
normalised = sschain_linked/max_hydration;

% for i = 1:length(chain_linked)
    
%     hold on
    plot3(x,y,z,'x', 'Color', [0 0 0]);

% end
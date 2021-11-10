function [chain_linked,sschain_linked] = chain_linker(sschain,chain)
sschain_linked = sschain{1,1}(:,1);
count = size((chain{1,1}));
count = count(2); %the number of parameters
for i = 1:count
    chain_linked(:,i) = chain{1,1}(:,i);
end
for i = 1:length(sschain)-1 %one less than the number of chains
    
    for i = 1:count
        chain_linked_2_add(:,i) = chain{1,1+i}(:,i);
    end
    
    chain_linked = [chain_linked ; chain_linked_2_add];
    
    sschain_linked = [sschain_linked ; sschain{1,i}(:,1)];
end
plotter_for_linked_chain(chain_linked,sschain_linked)

% uncomment to plot
plotter_for_linked_chain(chain_linked,sschain_linked)

end
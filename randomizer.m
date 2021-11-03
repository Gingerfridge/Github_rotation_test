function [params_rand] = randomizer(params)

%%%%this function randomizes the initial values input to mix things up in
%%%%the chain 

%%%% run over the length of the params
%%%% keep it with in the boundaries 

for i = 1:length(params)
    min_value_cell(1,i) = params{i,1}(1,3)
    max_value_cell(1,i) = params{i,1}(1,4)
end
max_value = cell2mat(max_value_cell)
min_value = cell2mat(min_value_cell)

for i = 1:length(params)
    params_rand{i,1}(1,1) = params{i,1}(1,1);
    params_rand{i,1}(1,3) = params{i,1}(1,3);
    params_rand{i,1}(1,4) = params{i,1}(1,4);
    params_rand{i,1}(1,5) = params{i,1}(1,5);
    params_rand{i,1}(1,6) = params{i,1}(1,6);
    
    Rand(i) = min_value(i)+(max_value(i)-min_value(i))*rand;
    params_rand{i,1}{1,2}(1,1) = Rand(i);
end
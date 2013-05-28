function minutes = getMinutes(input)
% Convert an input from xx:yy to minutes
    temp = textscan(input, '%s', 'Delimiter', ':');
    minutes = 60*str2double(temp{1}{1,1}) + str2double(temp{1}{2,1});
    
end
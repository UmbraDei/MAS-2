function minutes = getMinutes(input)
    temp = textscan(input, '%s', 'Delimiter', ':');
    minutes = 60*str2double(temp{1}{1,1}) + str2double(temp{1}{2,1});
    
    %[input, ' ', num2str(minutes)]
end
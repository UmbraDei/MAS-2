function output = loadFile()
    fID = fopen('standplan.txt');
    allCells = textscan(fID, '%s', 'Delimiter', '\n', 'HeaderLines', 17);
    fclose(fID);

    allCells = allCells{1};

    [totalSize, ~] = size(allCells);
    output = zeros(totalSize, 3);
    for i = 1:totalSize
           temp = textscan(allCells{i,1}, '%s', 'Delimiter', ';');
           output(i, 1) = i;
           output(i, 2) = getMinutes(temp{1}{3,1});
           output(i, 3) = getMinutes(temp{1}{4,1});
    end
end



function minutes = getMinutes(input)
    temp = textscan(input, '%s', 'Delimiter', ':');
    minutes = 60*str2double(temp{1}{1,1}) + str2double(temp{1}{2,1});
    
    %[input, ' ', num2str(minutes)]
end
function output = loadFile()
    % Load the file from the airplanes and convert to a matrix
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
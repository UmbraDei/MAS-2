function output = loadMatrix(size)
    % Load an stn matrix with a given size and return it after running
    % fastfloyd
    name = strcat('stn', num2str(size), '.tab');
    matrix = load(name);
    output = FastFloyd(matrix);
end

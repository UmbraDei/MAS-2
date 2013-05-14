function output = ex1(size)
    name = strcat('stn', num2str(size), '.tab');
    matrix = load(name);
    output = FastFloyd(matrix);

function stn = opstellenSTN6b()
    stn = 10000*ones(13,13) - 10000*diag(ones(13,1));
    
    %% Interval
    % TP C ST: 8:00 -> 8:30
    stn(2,1) = -getMinutes('8:00');
    stn(1,2) = getMinutes('8:30');
    
    % TP C ET 9:30 -> 10:00
    stn(3,1) = -getMinutes('9:30');
    stn(1,3) = getMinutes('10:00');
    
    % L C ST 10:00 -> 10:00
    stn(4,1) = -getMinutes('10:00');
    stn(1,4) = getMinutes('10:00');
    
    % L C ET 12:00 -> 12:00
    stn(5,1) = -getMinutes('12:00');
    stn(1,5) = getMinutes('12:00');
    
    % R A ST 8:45 -> 8:45
    stn(6,1) = -getMinutes('8:45');
    stn(1,6) = getMinutes('8:45');
    
    % R A ET 9:45 -> 9:45
    stn(7,1) = -getMinutes('9:45');
    stn(1,7) = getMinutes('9:45');
    
    % TR A ST 10:00 -> 10:30
    stn(8,1) = -getMinutes('10:00');
    stn(1,8) = getMinutes('10:30');
    
    % TR A ET 10:30 -> 12:00
    stn(9,1) = -getMinutes('10:30');
    stn(1,9) = getMinutes('12:00');
    
    % R B ST 8:45 -> 8:45
    stn(10,1) = -getMinutes('8:45');
    stn(1,10) = getMinutes('8:45');
    
    % R B ET 9:45 -> 9:45
    stn(11,1) = -getMinutes('9:45');
    stn(1,11) = getMinutes('9:45');
    
    % W B ST 9:45 -> 11:00
    stn(12,1) = -getMinutes('9:45');
    stn(1,12) = getMinutes('11:00');
    
    % W B ET 10:45 -> 12:00
    stn(13,1) = -getMinutes('10:45');
    stn(1,13) = getMinutes('12:00');
    
    %% Chris
    % TP C ST -> TP C ET: [90;120]
    i = 2;
    stn(i+1,i) = -90;
    stn(i,i+1) = 120;
    
    % TP C ET -> L C ST [0;30]
    i = 3;
    stn(i+1,i) = 0;
    stn(i,i+1) = 30;
    
    % L C ST -> L C ET: [120;120]
    i = 4;
    stn(i+1,i) = -120;
    stn(i,i+1) = 120;
    
    %% Ann
    % R A ST -> R A ET: [60;60]
    i = 6;
    stn(i+1,i) = -60;
    stn(i,i+1) = 60;
    
    % R A ET -> TR A ST [0;45]
    i = 7;
    stn(i+1,i) = 0;
    stn(i,i+1) = 45;
    
    % TR A ST -> TR A ET: [90;120]
    i = 8;
    stn(i+1,i) = -90;
    stn(i,i+1) = 120;
    
     %% Bill
    % R B ST -> R B ET: [60;60]
    i = 10;
    stn(i+1,i) = -60;
    stn(i,i+1) = 60;
    
    % R B ET -> W B ST [0;75]
    i = 11;
    stn(i+1,i) = 0;
    stn(i,i+1) = 75;
    
    % W B ST -> W B ET: [60;135]
    i = 12;
    stn(i+1,i) = -60;
    stn(i,i+1) = 135;
    
end

function minutes = getMinutes(input)
    temp = textscan(input, '%s', 'Delimiter', ':');
    minutes = 60*str2double(temp{1}{1,1}) + str2double(temp{1}{2,1});
    
    %[input, ' ', num2str(minutes)]
end
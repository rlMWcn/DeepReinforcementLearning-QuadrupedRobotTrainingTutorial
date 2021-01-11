% Helper function to reset walking robot simulation with different initial conditions
%
% Copyright 2019 The MathWorks, Inc.

function in = quadrupedResetFcn(in)
% Randomization Parameters

%     l1 = evalin('base','l1');
%     l2 = evalin('base','l2');

    max_foot_disp_x = 0.05;
    max_foot_disp_y = 0.05;
    min_body_height = 0.52;
    max_body_height = 0.3;
%     max_speed_x = 0.05;
%     max_speed_y = 0.025;
    
 
    
    
%     y_body = 0;
%     vx = 0;
%     vy = 0;
%     th_FL = zeros(1,2);
%     th_FR = zeros(1,2);
%     th_RL = zeros(1,2);
%     th_RR = zeros(1,2);
    
    % Chance of randomizing initial conditions
    if rand < -0.5
        % Randomize height
        b = min_body_height + (max_body_height - min_body_height) * rand;
        
        % Randomize x-displacement of foot from hip joint        
        a = -max_foot_disp_x + 2 * max_foot_disp_x * rand(1,4);
        
        c = -max_foot_disp_y + 2 * max_foot_disp_y * rand(1,4);
        
        % 需要添加计算initialPos函数的函数
        
        
        initialHeight = b;
        
    % Chance of starting from default initial conditions
    else        
        initialHeight = 0.58;
        initialPos=[-0.180304649622485;0.707778746139701;-0.910179587563713;-0.180304649622485;-0.707778746139701;0.910179587563713;0.180304649622485;0.707778746139702;-0.910179587563714;0.180304649622485;-0.707778746139702;0.910179587563713];

    end
    
    in = setVariable(in,'initialHeight',initialHeight);
    in = setVariable(in,'initialPos',initialPos);

    
end
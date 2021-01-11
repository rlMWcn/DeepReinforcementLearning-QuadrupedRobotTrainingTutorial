% % Body and leg geometry
% L = 1;        % Distance b/w front and rear hip joints
L_back = 1.5;
l1 = 0.5517;  % Link #1
l2 = 0.5517;  % Link #2
% 
% % Robot mass
M = 2;      % Torso
m1 = 0.2;   % Leg link #1
m2 = 0.2;   % Leg link #2

% Gravity
g = -9.81;

% Sample Time
Ts = 0.025;  % change to 0.025

% Simulation Time
Tf = 10;
% 
% % Desired height
%期望身高，测试在0。46-0，48之间波动
h_final = 0.47;
% 
% % Initial body height and foot displacement
% init_foot_disp_x = 0;
% init_body_height = h_final;
% 
% % Initial joint angles and velocities
d2r = pi/180;
% init_ang_FL = d2r * quadrupedInverseKinematics(init_foot_disp_x,-init_body_height,l1,l2);
% init_ang_FR = init_ang_FL;
% init_ang_RL = init_ang_FL;
% init_ang_RR = init_ang_FL;
% init_whip_FL = 0;
% init_whip_FR = 0;
% init_whip_RL = 0;
% init_whip_RR = 0;
% 
% % initial height
% foot_height = 0.05*l2*(1-sin(2*pi-(3*pi/2+init_ang_FL(1)+init_ang_FL(2))));
% y_init = init_body_height + foot_height;

% % Initial body speeds in x,y
% vx_init = 0;
% vy_init = 0;
% 
% % Contact friction properties
mu_kinetic = 0.88;
mu_static = 0.9;
% v_thres = 0.001;
% 
% % Ground properties
% ground.stiffness = 1e3;
% ground.damping = 1e2;
% ground.length = 100;
% ground.width = 1;
% ground.depth = 0.05;
% 
% % Hip and Knee Joint properties
% joint.stiffness = 0;
% joint.damping = 8;
% joint.limitStiffness = 500;
% joint.limitDamping = 50;
% joint.transitionWidth = 2 * d2r;
% hip_eq_angle = 0;
% knee_eq_angle = 0;

% Define limits on variables
u_max = 25;                        % max joint torque = +/- u_max
y_min = 0.35;                        % min height of body from ground
y_max = 0.5;                        % max translation in z
vx_max = 2.5;                         % max horizontal speed of body
vy_max = 2.5;                         % max vertical speed of body
vz_max = 2.5;                         % max lateral speed of body
roll_max = 10 * d2r;                    % max roll angle of body
pitch_max = 10 * d2r;                   % max pitch angle of body
yaw_max = 20 * d2r;                     % max yaw angle of body
omega_x_max = pi/2;                 % max angular speed about x
omega_y_max = pi/2;                 % max angular speed about x
omega_z_max = pi/2;                 % max angular speed about x
q_hip_min = -120 * d2r;              % hip and knee joint angle limit
q_hip_max = -30 * d2r;
%另一个轴目前复用的hip轴的，需要修改
q_knee_min = 60 * d2r;
q_knee_max = 140 * d2r;
w_max = 2*pi*60/60;                 % hip and knee joint angular speed limit
z_max = 0.58;%l1*cos(q_hip_max) + l2*cos(q_hip_max+q_knee_min);  % max height of body from ground
%最大摩擦力，需求根据实际情况修改
normal_force_max = ((M+4*m1+4*m2)*abs(g))/4;
friction_force_max = mu_static * normal_force_max;




clear
clc

myanymal=importrobot('anymal.urdf');
show(myanymal)

showdetails(myanymal)


currentRobotJConfig= homeConfiguration(myanymal);

LF_FOOT = 'LF_FOOT';
LH_FOOT = 'LH_FOOT';
RF_FOOT = 'RF_FOOT';
RH_FOOT = 'RH_FOOT';
% ik = inverseKinematics('RigidBodyTree', myanymal);
% weights=[0,0,0,1,1,1];
% qSol = ik(LF_FOOT,trvec2tform([-0.4,0.25,-0.4]),weights,currentRobotJConfig);
% show(myanymal,qSol)

%get robot transform
% transform = getTransform(robot,configuration,sourcebody,targetbody)
tLFform = getTransform(myanymal,currentRobotJConfig,LF_FOOT,'base');
tLHform = getTransform(myanymal,currentRobotJConfig,LH_FOOT,'base');
tRFform = getTransform(myanymal,currentRobotJConfig,RF_FOOT,'base');
tRHform = getTransform(myanymal,currentRobotJConfig,RH_FOOT,'base');




%conver qici to Position
LF_FOOT_pos = tform2trvec(tLFform);
LH_FOOT_pos = tform2trvec(tLHform);
RF_FOOT_pos = tform2trvec(tRFform);
RH_FOOT_pos = tform2trvec(tRHform);


tLFSHANKform = getTransform(myanymal,currentRobotJConfig,'LF_SHANK','base');
tLHSHANKform = getTransform(myanymal,currentRobotJConfig,'LH_SHANK','base');
tRFSHANKform = getTransform(myanymal,currentRobotJConfig,'RF_SHANK','base');
tRHSHANKform = getTransform(myanymal,currentRobotJConfig,'RH_SHANK','base');
LFSHANK_pos = tform2trvec(tLFSHANKform);
LHSHANK_pos = tform2trvec(tLHSHANKform);
RFSHANK_pos = tform2trvec(tRFSHANKform);
RHSHANK_pos = tform2trvec(tRHSHANKform);

tLFTHIGHform = getTransform(myanymal,currentRobotJConfig,'LF_THIGH','base');
tLHTHIGHform = getTransform(myanymal,currentRobotJConfig,'LH_THIGH','base');
tRFTHIGHform = getTransform(myanymal,currentRobotJConfig,'RF_THIGH','base');
tRHTHIGHform = getTransform(myanymal,currentRobotJConfig,'RH_THIGH','base');
LFTHIGH_pos = tform2trvec(tLFTHIGHform);
LHTHIGH_pos = tform2trvec(tLHTHIGHform);
RFTHIGH_pos = tform2trvec(tRFTHIGHform);
RHTHIGH_pos = tform2trvec(tRHTHIGHform);

FOOT_Hight=-0.5;

homePosLF=[LFSHANK_pos(1),LFTHIGH_pos(2),FOOT_Hight];
homePosLH=[LHSHANK_pos(1),LHTHIGH_pos(2),FOOT_Hight];
homePosRF=[RFSHANK_pos(1),RFTHIGH_pos(2),FOOT_Hight];
homePosRH=[RHSHANK_pos(1),RHTHIGH_pos(2),FOOT_Hight];
% homePos=

ik = inverseKinematics('RigidBodyTree', myanymal);
weights=[0,0,0,1,1,1];
qSolLF = ik(LF_FOOT,trvec2tform(homePosLF),weights,currentRobotJConfig);
qSolLH = ik(LH_FOOT,trvec2tform(homePosLH),weights,currentRobotJConfig);
qSolRF = ik(RF_FOOT,trvec2tform(homePosRF),weights,currentRobotJConfig);
qSolRH = ik(RH_FOOT,trvec2tform(homePosRH),weights,currentRobotJConfig);
% qSol.JointPosition=[qSolLF(1:3).JointPosition,qSolLH(4:6).JointPosition,qSolRF(7:9).JointPosition,qSolRH(10:12).JointPosition]';
qSol=currentRobotJConfig;
qSol(1).JointPosition=qSolLF(1).JointPosition;
qSol(2).JointPosition=qSolLF(2).JointPosition;
qSol(3).JointPosition=qSolLF(3).JointPosition;
qSol(4).JointPosition=qSolLH(4).JointPosition;
qSol(5).JointPosition=qSolLH(5).JointPosition;
qSol(6).JointPosition=qSolLH(6).JointPosition;
qSol(7).JointPosition=qSolRF(7).JointPosition;
qSol(8).JointPosition=qSolRF(8).JointPosition;
qSol(9).JointPosition=qSolRF(9).JointPosition;
qSol(10).JointPosition=qSolRH(10).JointPosition;
qSol(11).JointPosition=qSolRH(11).JointPosition;
qSol(12).JointPosition=qSolRH(12).JointPosition;

currentRobotJConfig =qSol;
show(myanymal,qSol)
hold on





initialPos=[[-0.180304649622485;0.707778746139701;-0.910179587563713;-0.180304649622485;-0.707778746139701;0.910179587563713;0.180304649622485;0.707778746139702;-0.910179587563714;0.180304649622485;-0.707778746139702;0.910179587563713]];

%     axis equal
% %convert Position to qici
% trvec = [0.5 6 100];
% tform = trvec2tform(trvec)
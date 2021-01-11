function agent = createTD3Agent(numObs, obsInfo, numAct, actInfo, Ts)
% Walking Robot -- TD3 Agent Setup Script
% Copyright 2020 The MathWorks, Inc.

%% Create the actor and critic networks using the createNetworks helper function
[criticNetwork1,criticNetwork2,actorNetwork] = createNetworks(numObs,numAct); % Use of 2 Critic networks
% figure
% plot(criticNetwork1)
% figure
% plot(criticNetwork2)
% 
% deepNetworkDesigner(actorNetwork)

%% Specify options for the critic and actor representations using rlRepresentationOptions
criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4,'UseDevice','cpu');
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5,'UseDevice','cpu');

%% Create critic and actor representations using specified networks and
% options
critic1 = rlQValueRepresentation(criticNetwork1,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOptions);
critic2 = rlQValueRepresentation(criticNetwork2,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOptions);
actor  = rlDeterministicActorRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'ActorTanh1'},actorOptions);

%% Specify TD3 agent options
agentOptions = rlTD3AgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 256;
agentOptions.ExperienceBufferLength = 1e6;
agentOptions.TargetSmoothFactor = 5e-3;
agentOptions.TargetPolicySmoothModel.Variance = 0.2; % target policy noise
agentOptions.TargetPolicySmoothModel.LowerLimit = -0.5;
agentOptions.TargetPolicySmoothModel.UpperLimit = 0.5;
agentOptions.ExplorationModel = rl.option.OrnsteinUhlenbeckActionNoise; % set up OU noise as exploration noise (default is Gaussian for rlTD3AgentOptions)
agentOptions.ExplorationModel.MeanAttractionConstant = 1;
agentOptions.ExplorationModel.Variance = 0.1;

agentOptions.SaveExperienceBufferWithAgent = true;
agentOptions.ResetExperienceBufferBeforeTraining = false;
%% Create agent using specified actor representation, critic representations and agent options
agent = rlTD3Agent(actor, [critic1,critic2], agentOptions);
function agent = createDDPGAgent(numObs, obsInfo, numAct, actInfo, Ts)
% Walking Robot -- DDPG Agent Setup Script
% Copyright 2020 The MathWorks, Inc.

%% Create the actor and critic networks using the createNetworks helper function
[criticNetwork,~,actorNetwork] = createNetworks(numObs,numAct);

%% Specify options for the critic and actor representations using rlRepresentationOptions
criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4,'UseDevice','cpu');
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5,'UseDevice','cpu');

%% Create critic and actor representations using specified networks and
% options
critic = rlQValueRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOptions);
actor  = rlDeterministicActorRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'ActorTanh1'},actorOptions);

%% Specify DDPG agent options
agentOptions = rlDDPGAgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 256;
agentOptions.ExperienceBufferLength = 1e6;
agentOptions.TargetSmoothFactor = 5e-3;
agentOptions.NoiseOptions.MeanAttractionConstant = 1;
agentOptions.NoiseOptions.Variance = 0.1;

agentOptions.SaveExperienceBufferWithAgent = true;
agentOptions.ResetExperienceBufferBeforeTraining = false;
%% Create agent using specified actor representation, critic representation and agent options
agent = rlDDPGAgent(actor,critic,agentOptions);

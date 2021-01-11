# Deep Reinforcement Learning - Quadruped Robot Training Tutorial

To run this project, you should first clone the repository: https://github.com/ANYbotics/anymal_b_simple_description. </br>
Put the files in the root path of this repository, start MATLAB, and open 'Anymal_B_example.prj' to check if you can load the project successfully.

To train a DDPG or TD3 agent, you can use 'testDDPGAgent.mlx' and 'testTD3Agent.mlx' in MATLAB.
These scripts utilizes the files 'utility\createDDPGAgent.m' and 'utility\createTD3Agent.m' to create the DDPG and TD3 agent respectively, and share the same file 'utility\createNetworks' to create actor/critic networks.

To change the device for training and inference, you can alter the 'UseDevice' value, in criticOptions and actorOptions within 'utility\createDDPGAgent.m' and 'utility\createTD3Agent.m', 

Check the 'rlQuadruped_TD3.avi' to see how the TD3 agent performs, for more information, such as the trained TD3 agent and reinforcement learning workflow in MATLAB & Simulink, please contact MathWorks directly. 

function [output] = performance_functionA(MX)

% Benckmark problem 
% Noise function

%% 1. Parameters

x1 = MX(:,1);
x2 = MX(:,2);

g1=2.677-x1-x2;
% g2=2.500-x2-x3;
% g3=2.323-x3-x4;
% g4=2.225-x4-x5;
% output = max([g1 g2 g3 g4],[],2);
output=g1;

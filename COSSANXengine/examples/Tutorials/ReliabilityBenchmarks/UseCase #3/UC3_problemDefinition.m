% USE CASE # 3 - non linear system
disp('');
disp('--------------------------------------------------------------------------------------------------');
disp('USE CASE #3: NON LINEAR SYSTEM');

%% Test with COSSAN-X
RV1=RandomVariable('Sdistribution','normal', 'mean',0,'std',1); 
RV2=RV1;
Xrvs=RandomVariableSet('Cmembers',{'RV1','RV2'}); 

%% Define Xinput
inp1 = Input('XRandomVariableSet',Xrvs);

Xm1=Mio(        'Sdescription', 'Performance function', ...
                'Spath','performacefunctions', ...
                'Sfile','perfun1nl', ...
                'Cinputnames',{'RV1','RV2'}, ...
                'Coutputnames',{'out'}, ...
                'Lfunction',true, ...
                'Liostructure',true);
			
Xm3=Mio(        'Sdescription', 'Performance function', ...
                'Spath','performacefunctions', ....
                'Sfile','perfun3nl', ...
                'Cinputnames',{'RV1','RV2'}, ...
                'Coutputnames',{'out'}, ...
                'Lfunction',true, ...
                'Liostructure',true);	
		
% This performance function is defined only for the validation of the results

Xm13=Mio(       'Sdescription', 'Performance function', ...
                'Spath','performacefunctions', ...
                'Sfile','perfun13nl', ...
                'Cinputnames',{'RV1','RV2'}, ...
                'Coutputnames',{'out'}, ...
                'Lfunction',true, ...
                'Liostructure',true);	
			
Xm1or3=Mio(     'Sdescription', 'Performance function', ...
                'Spath','performacefunctions', ...
                'Sfile','perfun1or3nl', ...
                'Cinputnames',{'RV1','RV2'}, ...
                'Coutputnames',{'out'}, ...
                'Lfunction',true, ...
                'Liostructure',true);			
			
%% Show the limit state function!!! 
% DO NOT CORRESPOND TO THE VALUES DEFINED IN THE MIOs
x1=[-6:0.1:6];
y1=(2-x1)./(0.5+0.05*x1.^2);
y3=(5.5+0.05*x1.^2)/2;
y13=max(y1,y3);
y1or3=min(y1,y3);

createfigureU3(x1,[y1; y3; y13; y1or3])

%% Construct the evaluators
Xev= Evaluator;

%% Create Model
Xmdl=Model('Xinput',inp1,'Xevaluator',Xev);

%% Define the evaluators as Xperfun
Xpf1    = PerformanceFunction('Xmio',Xm1);
Xpf3    = PerformanceFunction('Xmio',Xm3);
Xpf13   = PerformanceFunction('Xmio',Xm13);
Xpf1or3 = PerformanceFunction('Xmio',Xm1or3);

%% Create the probmodel
Xpm1    = ProbabilisticModel('XModel',Xmdl,'XPerformanceFunction',Xpf1,'Sdescription','Probabilistic model1');
Xpm3    = ProbabilisticModel('XModel',Xmdl,'XPerformanceFunction',Xpf3,'Sdescription','Probabilistic model3');
Xpm13   = ProbabilisticModel('XModel',Xmdl,'XPerformanceFunction',Xpf13,'Sdescription','Probabilistic model13');
Xpm1or3 = ProbabilisticModel('XModel',Xmdl,'XPerformanceFunction',Xpf1or3,'Sdescription','Probabilistic model1or3');


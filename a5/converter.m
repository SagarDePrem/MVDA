clear
load('ncadata.mat')
E=measabs; %(mElabels*nExperimental_labels)
[m n]=size(E);
Elabels=[1:m]';
% for i=1:n
    Elabels=num2cell(Elabels);
% end
Experiment_labels=[1:n]';
Experiment_labels=num2cell(Experiment_labels);
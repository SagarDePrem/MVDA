clear all; close all; clc
load('Inorfull.mat')


for i=1:26
    for k=1:176
STD_e(k,i)=std(DATA([5*i-4:5*i],k));
    end
end

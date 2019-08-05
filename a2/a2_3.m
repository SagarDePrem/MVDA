clc; clear all; close all;
Sz=[7 21 34; 21 64 102; 34 102 186];
xbar=[9;68;129];
[V,D]=eig(Sz);
Zx=([10.1;73;135.5]-xbar);
[u,s,v]=svd(Zx)
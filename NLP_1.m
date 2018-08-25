%% NLP_word2sine
% created by : Piush Aggarwal
%% clean up
clear all;
close all;
clc;

%% Create sine_vector
t=0:0.01:10;
x1=sin(2*pi*t);
subplot(4,1,1);
plot(x1);
xlabel('time');
ylabel('amplitude');
title('first signal');
x2=sin(t);
subplot(4,1,2);
plot(x2);
xlabel('time');
ylabel('amplitude');
title('second signal');
x3=x1+x2;
subplot(4,1,3);
plot(x3);
xlabel('time');
ylabel('amplitude');
title('added signal');
x4=x1.*x2;
subplot(4,1,4);
plot(x4);
xlabel('time');
ylabel('amplitude');
title('multiplied signal');
display(x1);
display(x2);
display(x3);
display(x4);
a = rand(100);
b = rand(100);
c = a + b;
display(c)
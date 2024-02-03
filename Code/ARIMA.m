clear;
clc;
load pm25dataPre2.mat
out1 = adftest(pm25dataPre2)
out2=kpsstest(pm25dataPre2)
max_ar = 3;
max_ma = 3;
[AR_Order,MA_Order] = ARMA_Order_Select(pm25dataPre2,max_ar,max_ma,1); 
step = 10; 
Mdl = arima(AR_Order, 0, MA_Order); 
EstMdl = estimate(Mdl,pm25dataPre2);
[fordata,YMSE] = forecast(EstMdl,step,'Y0',pm25dataPre2);
lower = fordata - 1.96*sqrt(YMSE); 
upper = fordata + 1.96*sqrt(YMSE); 

figure()
plot(pm25dataPre2,'Color',[.7,.7,.7]);
hold on
h1 = plot(length(pm25dataPre2):length(pm25dataPre2)+step,[pm25dataPre2(end);lower],'r:','LineWidth',2);
plot(length(pm25dataPre2):length(pm25dataPre2)+step,[pm25dataPre2(end);upper],'r:','LineWidth',2)
h2 = plot(length(pm25dataPre2):length(pm25dataPre2)+step,[pm25dataPre2(end);fordata],'k','LineWidth',2);
legend([h1 h2],'95% 置信区间','预测值',...
	     'Location','NorthWest')
title('Forecast')
hold off
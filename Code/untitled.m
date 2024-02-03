clear;
clc;
close all;
%% 加载原始数据  

    load('pm25data2.mat')% 原始数据
    pm25data2 = pm25data2(:);
    subplot(211)
	t = datetime(2010,1,2,0,0,0) + hours(0:length(pm25data2)-1)';% 创建与数据对应的时间向量。
    plot(t,pm25data2)% 查看波形
    title('原始数据波形')
    xlabel('Time/h');
    ylabel('PM_{2.5} / (\mu g.m^{-3})');
%% 查找缺失值

    TF1=ismissing(pm25data2);% 查找缺失值,TF是逻辑矩阵，利用TF可以找到pm25data内的缺失值
    TF = TF1;
%% 填充缺失值 （pm25dataPre是插补后的数据）

    pm25dataPre2 = pm25data2;
    while max(TF) % 如果还存在缺失值就继续插补
        % pm25data2 = fillmissing(pm25data2,'movmean',30);% 使用窗口长度为 30 的移动均值填充缺失数据。
        pm25dataPre2 = fillmissing(pm25dataPre2,'movmedian',30); % 使用窗口长度为 30 的移动中位数替换数据中的 NaN 值 
        TF=ismissing(pm25dataPre2);% 查找数据中的缺失值,TF是逻辑矩阵，利用TF可以找到pm25data内的缺失值
    end
    % plot(TF) % TF中的1对应pm25data中的缺失值，当数据中的缺失值填充完时，可以看到TF的值全为0
    subplot(212)
    plot(t,pm25dataPre2,t(TF1),pm25dataPre2(TF1),'x')% 查看插补后的数据 pm25dataPre2
    title('插补后的数据波形')
    xlabel('Time/h');
    ylabel('PM_{2.5} / (\mu g.m^{-3})');
    legend('原始数据','插补值')
    % save('pm25dataPre2.mat','pm25dataPre2');% 保存插补后的数据
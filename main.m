% �����������˺����롢ѭ���롢�����ı���������
% ����ÿһ�ֱ��뷽ʽͨ�����ֲ�ͬ�ŵ�����װ�ɺ�����ʽ��������������ɵ���
% �������������ֱȶԷ�ʽ��ϸ�ȶ��˲�ͬ���뷽ʽ�벻ͬ�ŵ�֮������������Ȳ�ͬʱ�����ʵı仯
% �ٲ�ͬ�ŵ��£�ͬһ���뷽ʽ��������������ȵĹ�ϵ
%   ���㣺��Ծ���룬���ݱ������ṹ�Ĳ�ͬ�����������ֳ����ı������ṹ��ɱ��룬���ֱ�����˱ȶ�
% ��ͬһ�ŵ��£���ͬ���뷽ʽ��������������ȵĹ�ϵ
% ����RayleighΪ��,���ֲ�ͬ�ṹ�ľ�����������������ȹ�ϵ
%% ������
clear all��
clc;
n = 7;
k = 4;                            
d = 1e5;                          % ��������� 
% n,k���Կ���ѭ����ı��뷽ʽ��d���Կ���ѭ����������Ϣ���ĳ���
data = randi([0 1],d,k);      % �������������
theor_Rice = [0.0926,0.0812,0.0706,0.0607,0.0515,0.0433,0.0359,0.02946,0.0237,0.0189,0.0148,0.0115,0.0088];    % Ԥ�ȷ������δ����������˹�ŵ���������
EbN0dB = 0:0.5:6;

%% �����水�պ����롢ѭ���롢������˳�����θ���ͬһ���뷽ʽ��ͬ�ŵ���������
%% ������
[H_theor_AWGN,H_BER_AWGN] = Hamming_BPSK_AWGN(data);                     % Hamming_BPSK_AWGN
[H_theor_Rayleigh,H_BER_Rayleigh] = Hamming_BPSK_Rayleigh(data);         % Hamming_BPSK_Rayleigh
[H_BER_Rice] = Hamming_BPSK_Rice(data);                                  % Hamming_BPSK_Rice

figure(1);
semilogy(EbN0dB,H_theor_AWGN,'c-','Linewidth',2);                       % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,H_theor_Rayleigh,'k:s','Linewidth',2);                  % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,theor_Rice,'m','Linewidth',2);                          % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,H_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼHamming��AWGN
hold on;
semilogy(EbN0dB,H_BER_Rayleigh,'g-*','Linewidth',2);                    % ��ͼHamming��Rayleigh
hold on;
semilogy(EbN0dB,H_BER_Rice,'bp-','Linewidth',2);                        % ��ͼHamming��Rice
hold off;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','δ����Rayleigh','δ����Rice','AWGN','Rayleigh','Rice');
title('BPSK����,��������뷽ʽ�������ŵ���BER');
grid on;

%% ѭ����
[C_theor_AWGN,C_BER_AWGN]= Cyclic_BPSK_AWGN(data,n,k,d);                % Cyclic_BPSK_AWGN
[C_theor_Rayleigh,C_BER_Rayleigh]= Cyclic_BPSK_Rayleigh(data,n,k,d);    % Cyclic_BPSK_Rayleigh
[C_BER_Rice] = Cyclic_BPSK_Rice(data,n,k,d);                            % Cyclic_BPSK_Rice

figure(2);
semilogy(EbN0dB,C_theor_AWGN,'c-','Linewidth',2);                       % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,C_theor_Rayleigh,'k:s','Linewidth',2);                  % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,theor_Rice,'m','Linewidth',2);                          % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,C_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼCyclic��AWGN
hold on;
semilogy(EbN0dB,C_BER_Rayleigh,'g-*','Linewidth',2);                    % ��ͼCyclic��Rayleigh
hold on;
semilogy(EbN0dB,C_BER_Rice,'bp-','Linewidth',2);                        % ��ͼCyclic��Rice
hold off;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','δ����Rayleigh','δ����Rice','AWGN','Rayleigh','Rice');
title('BPSK����,ѭ������뷽ʽ�������ŵ���BER');
grid on;
%% �����
% �������԰��ձ������ṹ�����಻ͬ������֣�һЩ�����ı������ṹ��(3,1,2)��(2,1,2)��(2,1,4)��
% ���潫���ν������ֱ��������ɵľ����ͨ�����ֲ�ͬ�ŵ����з���
%% (3,1,2)�����
CtLength = [3];
CdGener = [7 4 6];
[Conv1_theor_AWGN,Conv1_BER_AWGN] = conv_awgn_BER(data, CtLength, CdGener);
[Conv1_theor_Rayleigh,Conv1_BER_Rayleigh] = conv_rayleigh_BER(data, CtLength, CdGener);
[Conv1_BER_Rice] = conv_rice_BER(data, CtLength, CdGener);

figure(3);
semilogy(EbN0dB,Conv1_theor_AWGN,'c-','Linewidth',2);                       % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,Conv1_theor_Rayleigh,'k:s','Linewidth',2);                  % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,theor_Rice,'m','Linewidth',2);                              % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,Conv1_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼConv1��AWGN
hold on;
semilogy(EbN0dB,Conv1_BER_Rayleigh,'g-*','Linewidth',2);                    % ��ͼConv1��Rayleigh
hold on;
semilogy(EbN0dB,Conv1_BER_Rice,'bp-','Linewidth',2);                        % ��ͼConv1��Rice
hold off;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','δ����Rayleigh','δ����Rice','AWGN','Rayleigh','Rice');
title('BPSK����,(3,1,2)�������뷽ʽ�������ŵ���BER');
grid on;

%% (2,1,2)�����
CtLength = [3];
CdGener = [7 5];
[Conv2_theor_AWGN,Conv2_BER_AWGN] = conv_awgn_BER(data, CtLength, CdGener);
[Conv2_theor_Rayleigh,Conv2_BER_Rayleigh] = conv_rayleigh_BER(data, CtLength, CdGener);
[Conv2_BER_Rice] = conv_rice_BER(data, CtLength, CdGener);

figure(4);
semilogy(EbN0dB,Conv2_theor_AWGN,'c-','Linewidth',2);                       % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,Conv2_theor_Rayleigh,'k:s','Linewidth',2);                  % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,theor_Rice,'m','Linewidth',2);                              % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,Conv2_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼConv2��AWGN
hold on;
semilogy(EbN0dB,Conv2_BER_Rayleigh,'g-*','Linewidth',2);                    % ��ͼConv2��Rayleigh
hold on;
semilogy(EbN0dB,Conv2_BER_Rice,'bp-','Linewidth',2);                        % ��ͼConv2��Rice
hold off;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','δ����Rayleigh','δ����Rice','AWGN','Rayleigh','Rice');
title('BPSK����,(2,1,2)�������뷽ʽ�������ŵ���BER');
grid on;

%% (2,1,4)�����
CtLength = [5];
CdGener = [23 25];
[Conv3_theor_AWGN,Conv3_BER_AWGN] = conv_awgn_BER(data, CtLength, CdGener);
[Conv3_theor_Rayleigh,Conv3_BER_Rayleigh] = conv_rayleigh_BER(data, CtLength, CdGener);
[Conv3_BER_Rice] = conv_rice_BER(data, CtLength, CdGener);

figure(5);
semilogy(EbN0dB,Conv3_theor_AWGN,'c-','Linewidth',2);                       % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,Conv3_theor_Rayleigh,'k:s','Linewidth',2);                  % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,theor_Rice,'m','Linewidth',2);                              % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,Conv3_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼConv3��AWGN
hold on;
semilogy(EbN0dB,Conv3_BER_Rayleigh,'g-*','Linewidth',2);                    % ��ͼConv3��Rayleigh
hold on;
semilogy(EbN0dB,Conv3_BER_Rice,'bp-','Linewidth',2);                        % ��ͼConv3��Rice
hold off;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','δ����Rayleigh','δ����Rice','AWGN','Rayleigh','Rice');
title('BPSK����,(2,1,4)�������뷽ʽ�������ŵ���BER');
grid on;

%% �����水��AWGN�ŵ���Rayleigh�ŵ���Rice�ŵ���˳�����θ���ͬһ�ŵ��²�ͬ���뷽ʽ��������
% �����ֳ����ľ������ѡ��(3,1,2)���������뺺�����ѭ����ıȶ�
%% AWGN�ŵ�
figure(6);
semilogy(EbN0dB,H_theor_AWGN,'c-','Linewidth',2);                           % ��ͼδ�����AWGN
hold on;
semilogy(EbN0dB,H_BER_AWGN,'k:s','Linewidth',2);                            % ��ͼHamming��AWGN
hold on;
semilogy(EbN0dB,C_BER_AWGN,'m','Linewidth',2);                              % ��ͼCyclic��AWGN
hold on;
semilogy(EbN0dB,Conv1_BER_AWGN,'r--d','Linewidth',2);                       % ��ͼConv1��AWGN
hold on;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����AWGN','Hamming��AWGN','Cyclic��AWGN','(3,1,2)������AWGN');
title('BPSK����,��ͬ���뷽ʽ��AWGN��BER');
grid on;

%% Rayleigh�ŵ�
figure(7);
semilogy(EbN0dB,H_theor_Rayleigh,'c-','Linewidth',2);                           % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,H_BER_Rayleigh,'k:s','Linewidth',2);                            % ��ͼHamming��Rayleigh
hold on;
semilogy(EbN0dB,C_BER_Rayleigh,'m','Linewidth',2);                              % ��ͼCyclic��Rayleigh
hold on;
semilogy(EbN0dB,Conv1_BER_Rayleigh,'r--d','Linewidth',2);                       % ��ͼConv1��Rayleigh
hold on;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����Rayleigh','Hamming��Rayleigh','Cyclic��Rayleigh','(3,1,2)������Rayleigh');
title('BPSK����,��ͬ���뷽ʽ��Rayleigh��BER');
grid on;

%% Rice�ŵ�
figure(8);
semilogy(EbN0dB,theor_Rice,'c-','Linewidth',2);                             % ��ͼδ�����Rice
hold on;
semilogy(EbN0dB,H_BER_Rice,'k:s','Linewidth',2);                            % ��ͼHamming��Rice
hold on;
semilogy(EbN0dB,C_BER_Rice,'m','Linewidth',2);                              % ��ͼCyclic��Rice
hold on;
semilogy(EbN0dB,Conv1_BER_Rice,'r--d','Linewidth',2);                       % ��ͼConv1��Rice
hold on;
axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����Rice','Hamming��Rice','Cyclic��Rice','(3,1,2)������Rice');
title('BPSK����,��ͬ���뷽ʽ��Rice��BER');
grid on;

%% �����Rayleigh�ŵ����ȽϾ��������ֲ�ͬ�������ṹ�������ʹ�ϵ
figure(9);
semilogy(EbN0dB,H_theor_Rayleigh,'c-','Linewidth',2);                           % ��ͼδ�����Rayleigh
hold on;
semilogy(EbN0dB,Conv1_BER_Rayleigh,'r--d','Linewidth',2);                       % ��ͼConv1��Rayleigh
hold on;
semilogy(EbN0dB,Conv2_BER_Rayleigh,'k:s','Linewidth',2);                        % ��ͼConv2��Rayleigh
hold on;
semilogy(EbN0dB,Conv3_BER_Rayleigh,'m','Linewidth',2);                          % ��ͼConv3��Rayleigh
hold on;

axis([0 6 10^-5 1]);
xlabel('EbN0(dB)');
ylabel('BER');
legend('δ����Rayleigh','(3,1,2)������Rayleigh','(2,1,2)������Rayleigh','(2,1,4)������Rayleigh');
title('BPSK����,���ֲ�ͬ�ṹ�ľ�����Rayleigh��BER');
grid on;

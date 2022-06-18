%���ú�����ı��뷽ʽ����BPSK���ƺ󾭹�AWGN�ŵ��Ĺ���
%�������ܣ��������ú�����ı��뷽ʽ����BPSK���ƺ󾭹�AWGN�ŵ�������������ȵĹ�ϵ
%��������˵����data ��Ϣ��
function [BER_theor_AWGN,H_BER_AWGN] =Hamming_BPSK_AWGN(data)
%% �������ŵ�����
n = 7;                
k = 4;                         
% data = randi([0 1],1e5,k);                            %���ú���ʱ�ɽ�����ע�͵���������������data��ɱ����������
len_data = length(data);                           
len_data_sum = k*length(data);                          % ����������������䳤��
H_encData = encode(data,n,k,'hamming/binary');          % ����encode�������Դ������������У�7,4���������ŵ�����
len_H_encData = n*length(data);                         % �������󳤶�
%% BPSK����
H_modData = 2*H_encData-1;                              % �Ա�����źŽ���BPSK����                        
%% AWGN�ŵ��ͽ���������
EbN0dB=0:0.5:6;                                         % EbN0�ֱ���ʽ����0.5dBΪ������ȡֵ��Χ0-6
EbN0=10.^(EbN0dB/10);                              
len_EbN0=length(EbN0);                                  % ���㲻ͬ����ȵ���������
for j=1:len_EbN0                                        % ���ݲ�ͬ����ȼ�������
    sigma(j)=sqrt(1/(2*EbN0(j)));
    Noise(j,:)=randn(1, len_H_encData)*sigma(j);
    Noise_0= reshape(Noise(j,:), len_data, n);
    H_reData =Noise_0 +H_modData;                       % ����ź�ͨ��AWGN�ŵ�����
    
    H_demod = zeros(len_data,n);                        % �Խ��ն˽��յ����ź����BPSK���  
    H_demod(H_reData>0)=1;

    H_decData=decode(H_demod,n,k,'hamming/binary');                 % ����decode����������������

    H_BER_AWGN(j)=sum(abs(H_decData-data),'all')/(len_data_sum);    % ��������������������ı������������͵ķ�ʽ��������ʵļ���

end
%% �����ͼ
BER_theor_AWGN= qfunc(sqrt(2*EbN0));                                % �����δ����ʱͨ��AWGN�ŵ���������
% semilogy(EbN0dB,BER_theor_AWGN,EbN0dB,H_BER_AWGN,'bp-','Linewidth',2);
% axis([0 6 10^-5 0.1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('δ�����AWGN','Hamming��AWGN');                             % ��ͼ
% title('BPSK���ƣ���AWGN�ŵ���BER');
    









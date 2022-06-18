%���ú�����ı��뷽ʽ����BPSK���ƺ󾭹�Rayleigh�ŵ��Ĺ���
%�������ܣ��������ú�����ı��뷽ʽ����BPSK���ƺ󾭹�Rayleigh�ŵ�������������ȵĹ�ϵ
%��������˵����data ��Ϣ��
function [BER_theor_Rayleigh,H_BER_Rayleigh] = Hamming_BPSK_Rayleigh(data)
%% �������ŵ�����
n = 7;                
k = 4;                         
% data = randi([0 1],1e5,k);                            % ���ú���ʱ�ɽ�����ע�͵���������������data��ɱ����������
len_data = length(data);
len_data_sum = k*length(data);                          % ����������������䳤��
H_encData = encode(data,n,k,'hamming/binary');          % ����encode�������Դ������������У�7,4���������ŵ�����
len_H_encData = n*length(data);                         % �������󳤶�
%% BPSK����
H_modData = 2*H_encData-1;                              % �Ա�����źŽ���BPSK����
%% Rayleigh�ŵ��ͽ���������
EbN0dB=0:0.5:6;                                         % EbN0�ֱ���ʽ����0.5dBΪ������ȡֵ��Χ0-6
EbN0=10.^(EbN0dB/10);
len_EbN0=length(EbN0);                                  % ���㲻ͬ����ȵ���������
for j=1:len_EbN0                                        % ���ݲ�ͬ����ȼ�������
    h_0=1/sqrt(2).*(randn(1,len_H_encData)+1i.*randn(1,len_H_encData));             % ����˥���ŵ���ģ
    h = reshape(h_0, len_data, n);
    sigma(j)=sqrt(1/(2*EbN0(j)));
    noise_0 = sigma(j)*(randn(1,len_H_encData)+1i*randn(1,len_H_encData));
    noise = reshape(noise_0, len_data, n);
    H_reData=h.*H_modData+noise;

    H_reData2=H_reData./h;                                                          % ���ն��ź����������һ��
    H_demod =real(H_reData2)>0;                                                     % ���BPSK�������

    H_decData=decode(H_demod,n,k,'hamming/binary');                                 % ����decode����������������

    H_BER_Rayleigh(j)=sum(abs(H_decData-data),'all')/(len_data_sum);                % ��������������������ı������������͵ķ�ʽ��������ʵļ���
end
%% ��ͼ
BER_theor_Rayleigh=0.5*(1-sqrt(EbN0./(1+EbN0)));                                    % �����δ����ʱͨ�������ŵ���������
% semilogy(EbN0dB,BER_theor_Rayleigh,EbN0dB,H_BER_Rayleigh,'bp-','Linewidth',2);
% axis([0 6 10^-5 1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('δ�����Rayleigh','Hamming��Rayleigh');                                                 % ��ͼ
% title('BPSK���ƣ���Rayleigh�ŵ���BER');
    









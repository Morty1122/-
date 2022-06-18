%����ѭ����ı��뷽ʽ����BPSK���ƺ󾭹�AWGN�ŵ��Ĺ���
%�������ܣ���������ѭ����ı��뷽ʽ����BPSK���ƺ󾭹�AWGN�ŵ�������������ȵĹ�ϵ
%��������˵����data ��Ϣ����n �볤, k ��Ϣλ���� , d ������
function [C_theor_AWGN,C_BER_AWGN] =Cyclic_BPSK_AWGN(data,n,k,d)
%% ѭ�����ŵ�����
C_encData = encode(data,n,k,'cyclic/binary');            % ����encode�������Դ������������У�n,k��ѭ�����ŵ�����
%% BPSK����
C_modData = 2*C_encData-1;                               % �����BPSK����
%% AWGN�ŵ��ͽ���������
EbN0dB_min=0;
EbN0dB_max=6;
EbN0dB=EbN0dB_min:0.5:EbN0dB_max;                        % EbN0�Էֱ���ʽ��ʾ�ķ�Χȡ0-6
EbN0=10.^(EbN0dB/10);
len_EbN0=length(EbN0);                                   % ���㲻ͬ����ȵ���������
for j=1:len_EbN0                                         % ���ݲ�ͬ����ȼ�������
    sigma(j)=sqrt(1/(2*EbN0(j)));
    Noise(j,:)=randn(1, n*d)*sigma(j);
    Noise_0= reshape(Noise(j,:), d, n);
    C_reData =Noise_0 +C_modData;                         % ���BPSK�������
    
    C_demod = zeros(d,n);
    C_demod(C_reData>0)=1;
    
    C_decData=decode(C_demod,n,k,'cyclic/binary');        % ���ѭ��������
    
    C_BER_AWGN(j)=sum(abs(C_decData-data),'all')/(d*k);   % ����������
    
end
%% ��ͼ
C_theor_AWGN= qfunc(sqrt(2*EbN0));
% semilogy(EbN0dB,C_theor_AWGN,EbN0dB,C_BER_AWGN,'bp-','Linewidth',2);
% axis([EbN0dB_min EbN0dB_max 10^-5 0.1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('����BER','(n,k)ѭ����BER');
% title('BPSK���ơ���ͬ���뷽ʽ�µ�BER');










%����ѭ����ı��뷽ʽ����BPSK���ƺ󾭹������ŵ��Ĺ���
%�������ܣ���������ѭ����ı��뷽ʽ����BPSK���ƺ󾭹������ŵ�������������ȵĹ�ϵ
%��������˵����data ��Ϣ����n �볤, k ��Ϣλ���� , d ������
function [C_theor_Rayleigh,C_BER_Rayleigh] = Cyclic_BPSK_Rayleigh(data,n,k,d)
%% ��n,k)ѭ�����ŵ�����                        
% data = randi([0 1],d,k);           
C_encData = encode(data,n,k,'cyclic/binary');             %����encode�������Դ������������У�n,k��ѭ�����ŵ�����
%% BPSK����
C_modData = 2*C_encData-1;                         
%% Rayleigh�ŵ��ͽ���������
EbN0dB_min=0;
EbN0dB_max=6;
EbN0dB=EbN0dB_min:0.5:EbN0dB_max;                         % EbN0�Էֱ���ʽ��ʾ�ķ�Χȡ0-6
EbN0=10.^(EbN0dB/10);
len_EbN0=length(EbN0);
for j=1:len_EbN0                                          % ���ݲ�ͬ����ȼ�������
    h_0=1/sqrt(2).*(randn(1,n*d)+1i.*randn(1,n*d));       % ����˥���ŵ���ģ
    h = reshape(h_0, d, n);
    sigma(j)=sqrt(1/(2*EbN0(j)));
    noise_0 = sigma(j)*(randn(1,n*1e5)+1i*randn(1,n*d));
    noise = reshape(noise_0, d, n);
    C_reData=h.*C_modData+noise;
   
    C_reData2=C_reData./h;                                % ���ն��ź����������һ��
    C_demod =real(C_reData2)>0;                           % ���BPSK�������

    C_decData=decode(C_demod,n,k,'cyclic/binary');        % ���ѭ��������

    C_BER_Rayleigh(j)=sum(abs(C_decData-data),'all')/(d*k); % ����������
end
%% ��ͼ
C_theor_Rayleigh=0.5*(1-sqrt(EbN0./(1+EbN0)));
% semilogy(EbN0dB,C_theor_Rayleigh,EbN0dB,C_BER_Rayleigh,'bp-','Linewidth',2);
% axis([EbN0dB_min EbN0dB_max 10^-5 1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('����BER','(7,4)ѭ����BER');
% title('BPSK���ơ���ͬ���뷽ʽ�µ�BER');
    









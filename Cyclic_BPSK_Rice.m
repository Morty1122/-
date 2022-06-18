%����ѭ����ı��뷽ʽ����BPSK���ƺ󾭹���˹�ŵ��Ĺ���
%�������ܣ���������ѭ����ı��뷽ʽ����BPSK���ƺ󾭹���˹�ŵ�������������ȵĹ�ϵ
%��������˵����data ��Ϣ����n �볤, k ��Ϣλ���� , d ������
function [C_BER_Rice] = Cyclic_BPSK_Rice(data,n,k,d)
%% ѭ�����ŵ�����            
C_encData = encode(data,n,k,'cyclic/binary');     % ����encode�������Դ������������У�n,k��ѭ�����ŵ�����
%% BPSK����
C_modData = 2*C_encData-1;                         
%% Rice�ŵ��ͽ���������
EbN0dB_min=0;
EbN0dB_max=6;
EbN0dB=EbN0dB_min:0.5:EbN0dB_max;                     % EbN0�Էֱ���ʽ��ʾ�ķ�Χȡ0-6
EbN0=10.^(EbN0dB/10);
len_EbN0=length(EbN0);                                % ���㲻ͬ����ȵ���������
for j=1:len_EbN0                                      % ���ݲ�ͬ����ȼ�������
    sigma(j)=sqrt(1/(2*EbN0(j)));                     % ��˹�ŵ���ģ
    noise_0 = sigma(j)*(randn(1,n*d)+1i*randn(1,n*d));
    noise = reshape(noise_0, d, n);
    q=10;
    h_0=sqrt(q/(q+1))+sqrt(1/(q+1)).*(1/sqrt(2).*(randn(1,n*d)+1i.*randn(1,n*d)));
    h=reshape(h_0,d,n);
    C_reData=h.*C_modData+noise;
    
    C_reData2=C_reData./h;                              % ���ն�������һ��
    C_demod =real(C_reData2)>0;                         % ���BPSK�������


    C_decData=decode(C_demod,n,k,'cyclic/binary');       % ��ɣ�n,k��ѭ��������

    C_BER_Rice(j)=sum(abs(C_decData-data),'all')/(d*k);  % ����������
end
%% ��ͼ
% semilogy(EbN0dB,C_BER_Rice,'bp-','Linewidth',2);
% axis([EbN0dB_min EbN0dB_max 10^-5 1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('����BER','(7,4)ѭ����BER');
% title('BPSK���ơ���ͬ���뷽ʽ�µ�BER');
     


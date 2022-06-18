function [BER_theor_AWGN,BER] = conv_awgn_BER(msg, CtLength, CdGener)
%% ��������
% [CtLength, CdGener]���Ƽ�ȡֵ��[[3], [7 4 6]](3,1,2), [[3], [7 5]](2,1,2),
% [[5], [23 35]](2,1,4)��
msg = reshape(msg, 1, []);
n = size(CdGener, 2);                               % nΪÿ������ֳ�
trellis = poly2trellis(CtLength, CdGener);          % �����������ṹ
code = convenc(msg, trellis);                       % ����

%% BPSK����
code_tsm = 2*code-1;                                % ����˷�����ź�

%% ��Ϣͨ��AWGN�ŵ�����������롢���������
EbN0dB_min = 0;
EbN0dB_max = 6;
EbN0dB = EbN0dB_min:0.5:EbN0dB_max;                 % EbN0�Էֱ���ʽ��ʾ�ķ�Χȡ0-6
EbN0 = 10.^(EbN0dB/10);
len_EbN0 = length(EbN0);
BER = zeros(1, len_EbN0);
tb = 25;                                            % ����������

for j = 1:len_EbN0                                  % ���ݲ�ͬ����ȼ�������
    sigma = sqrt(1/(2*EbN0(j)));
    noise = randn(1, n*length(msg)) * sigma;
    code_rec = code_tsm + noise;                    % ���ն˽��յ����ź�
    
    code_dem = zeros(1, n*length(msg));             %���
    code_dem(code_rec>0) = 1;
    
    decoded = vitdec(code_dem, trellis, tb, 'trunc', 'hard');   % ʹ��ά�ر��㷨���룬Ӳ�о�
    BER(j) = sum(abs(decoded - msg),'all')/(length(msg));       % ����������
end

%% ��ͼ
BER_theor_AWGN = qfunc(sqrt(2*EbN0));
% semilogy(EbN0dB, BER_theor_AWGN, EbN0dB,BER, 'bp-','Linewidth', 2);
% axis([EbN0dB_min EbN0dB_max 10^-5 0.1]);
% xlabel('EbN0(dB)');
% ylabel('BER');
% legend('����BER','(3, 1, 3)�����');
% title('BPSK���ơ���ͬ���뷽ʽ�µ�BER');
  

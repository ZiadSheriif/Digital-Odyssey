close all;
n = 50000; % Example size
samples_per_bit = 10;

signal = zeros(1, n); % Initialize array of zeros
signal(1:n/2) = 1; % Set first n/2 elements to ones
signal = signal(randperm(n)); % Shuffle the array randomly

disp(1:10:100);
gt = zeros(1,samples_per_bit*n); % initialize gt with zeros
rt = zeros(31,samples_per_bit*n); % initialize gt with zeros

ht_1 = ones(1,samples_per_bit);% Unit filter matched
ht_2 = zeros(1,samples_per_bit); ht_2(round(samples_per_bit/2)) = 1;% Pulse not exsistant
ht_3 = linspace(0, sqrt(3), samples_per_bit);% Triangler

% Convert binary data to pulse signal
for i = 1:n
    if signal(i) == 1
        gt(samples_per_bit*(i-1)+1:samples_per_bit*i) = 1; % set 10 corresponding elements in gt to value of arr element
    else
        gt(samples_per_bit*(i-1)+1:samples_per_bit*i) = -1; % set 10 corresponding elements in gt to value of arr element
    end
end

disp(size(gt));
% Receive the signal (Receiver filter)
channel_output = awgn(gt,20,'measured');
convolved_1 = conv(channel_output, ht_1); %Convolve the signal with unit filter
convolved_2 = conv(channel_output, ht_2); %Convolve the signal with pulse filter
convolved_3 = conv(channel_output, ht_3); %Convolve the signal with triangler filter

% Plot the received signals and the channel output
figure;myPlot(channel_output,"time","channel_output","channel output (SNR = 20db)");
figure;myPlot(convolved_1,"time","received signal","unit filter");
figure;myPlot(convolved_2,"time","received signal","not existent");
figure;myPlot(convolved_3,"time","received signal","triangle");


% Add AWGN to the pulse signal
for snr = -10:20
    rt(snr+11,:) = awgn(gt,snr,'measured'); 
end

decoded_1 = zeros(31,n);
decoded_2 = zeros(31,n);
decoded_3 = zeros(31,n);
simulated_BER_1 = zeros(1,31);
simulated_BER_2 = zeros(1,31);
simulated_BER_3 = zeros(1,31);
BER1_vec_thr = zeros(1,31);
BER2_vec_thr = zeros(1,31);
BER3_vec_thr = zeros(1,31);

for snr = 1:31
    convolved_1 = conv(rt(snr,:), ht_1);
    convolved_2 = conv(rt(snr,:), ht_2);
    convolved_3 = conv(rt(snr,:), ht_3);
    
    for value = 1:n
        if convolved_1(value*samples_per_bit) >= 0
            decoded_1(snr,value) = 1;
        else
            decoded_1(snr,value) = 0;
        end
        
        if decoded_1(snr,value) ~= signal(value)
            simulated_BER_1(snr)= simulated_BER_1(snr) + 1;
        end
    end
    for value = 1:n
        if convolved_2(value*samples_per_bit) >= 0
            decoded_2(snr,value) = 1;
        else
            decoded_2(snr,value) = 0;
        end
        if decoded_2(snr,value) ~= signal(value)
            simulated_BER_2(snr)= simulated_BER_2(snr) + 1;
        end
    end
    for value = 1:n
        if convolved_3(value*samples_per_bit) >= 0
            decoded_3(snr,value) = 1;
        else
            decoded_3(snr,value) = 0;
        end
        
        if decoded_3(snr,value) ~= signal(value)
            simulated_BER_3(snr)= simulated_BER_3(snr) + 1;
        end
    end
    normal_value = 10^((snr-11)/10); 
    BER1_vec_thr(snr)=0.5*erfc(sqrt(normal_value));% matched
    BER2_vec_thr(snr)=0.5*erfc(sqrt(normal_value));% not existent
    BER3_vec_thr(snr)=0.5*erfc((sqrt(3)/(2)*sqrt(normal_value))); % linear
end
snr = -10:20;

%disp(simulated_BER_1/n);
%disp(simulated_BER_2/n);
%disp(simulated_BER_3/n);
figure;
%Plot both arrays on the same graph with different colors
semilogy(snr, simulated_BER_1/n,'-r', 'LineWidth', 1); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(snr, BER1_vec_thr,'--r' ,'LineWidth', 1); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(snr, simulated_BER_2/n,'-g', 'LineWidth', 1); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(snr, BER2_vec_thr, '--g','LineWidth', 1); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(snr, simulated_BER_3/n','b','LineWidth', 1); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(snr, BER3_vec_thr,'--b','LineWidth', 1); % Use red color for y1
xlabel('SNR');
ylabel('BER');
title('Plot of BER');
legend('matched sim','matched theo','not existent sim','not existent theo','linear sim','linear theo');
ylim([1/n*100 1]);

% figure;
% hold on; % Keep the current plot and add new plots to it
% % Plot both arrays on the same graph with different colors
% semilogy(-10:20, BER1_vec_thr, 'r', 'LineWidth', 2); % Use red color for y1
% hold on; % Keep the current plot and add new plots to it
% semilogy(-10:20, BER2_vec_thr, 'm', 'LineWidth', 2); % Use red color for y1
% hold on; % Keep the current plot and add new plots to it
% semilogy(-10:20, BER3_vec_thr, 'g', 'LineWidth', 2); % Use red color for y1
% 
% xlabel('SNR');
% ylabel('BER');
% title('Plot of theoritical BER');
% legend('Unit','Pulse','Triangler');


% figure;
% %semilogy(-10:20, 1/2.*erfc(-10:20), 'b', 'LineWidth', 2); % Use blue color for y2
% semilogy(-10:20, 1/2.*erfc(sqrt(10.^((-10:20)/10))), 'b', 'LineWidth', 2); % Use blue color for y2
% % Add labels and a legend
% xlabel('SNR');
% ylabel('BER');
% title('Plot of BER');
% legend('theortical bit error rate');
% 
% 
% figure;
% %semilogy(-10:20, 1/2.*erfc(-10:20), 'b', 'LineWidth', 2); % Use blue color for y2
% semilogy(-10:20, qfunc(1/sqrt()), 'b', 'LineWidth', 2); % Use blue color for y2
% % Add labels and a legend
% xlabel('SNR');
% ylabel('BER');
% title('Plot of BER');
% legend('theortical bit error rate');

% disp([decoded_1]);
% disp([decoded_2]);
% disp([decoded_3]);
% disp([signal]);



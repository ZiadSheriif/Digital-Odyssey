close all;
n = 10000; % replace with desired size of arr
signal = randi([0, 1], 1, n); % generate array of random 0s and 1s
gt = zeros(1, 10 * n); % initialize gt with zeros
rt = zeros(31, 10 * n); % initialize gt with zeros

ht_1 = ones(1, 10); % Unit filter
ht_2 = zeros(1, 10); ht_2(5) = 1; % Pulse
ht_3 = linspace(0, sqrt(3), 10); % Triangler

% Convert binary data to pulse signal
for i = 1:n

    if signal(i) == 1
        gt(10 * (i - 1) + 1:10 * i) = 1; % set 10 corresponding elements in gt to value of arr element
    else
        gt(10 * (i - 1) + 1:10 * i) = -1; % set 10 corresponding elements in gt to value of arr element
    end

end

% Receive the signal (Receiver filter)
channel_output = awgn(gt, 20, 'measured');
convolved_1 = conv(channel_output, ht_1); %Convolve the signal with unit filter
convolved_2 = conv(channel_output, ht_2); %Convolve the signal with pulse filter
convolved_3 = conv(channel_output, ht_3); %Convolve the signal with triangler filter
% Plot the received signals and the channel output
figure; myPlot(channel_output, "time", "channel_output", "channel output (SNR = 20db)");
figure; myPlot(convolved_1, "time", "received signal", "unit filter");
figure; myPlot(convolved_2, "time", "received signal", "not existent");
figure; myPlot(convolved_3, "time", "received signal", "triangle");

% Add AWGN to the pulse signal
for snr = -10:20
    rt(snr + 11, :) = awgn(gt, snr);
end

decoded_1 = zeros(31, n);
decoded_2 = zeros(31, n);
decoded_3 = zeros(31, n);
simulated_BER_1 = zeros(1, 31);
simulated_BER_2 = zeros(1, 31);
simulated_BER_3 = zeros(1, 31);

for snr = 1:31
    convolved_1 = conv(rt(snr, :), ht_1);
    convolved_2 = conv(rt(snr, :), ht_2);
    convolved_3 = conv(rt(snr, :), ht_3);

    for value = 1:n

        if convolved_1(value * 10) >= 0
            decoded_1(snr, value) = 1;
        else
            decoded_1(snr, value) = 0;
        end

        if decoded_1(snr, value) ~= signal(value)
            simulated_BER_1(snr) = simulated_BER_1(snr) + 1;
        end

    end

    for value = 1:n

        if convolved_2(value * 10) >= 0
            decoded_2(snr, value) = 1;
        else
            decoded_2(snr, value) = 0;
        end

        if decoded_2(snr, value) ~= signal(value)
            simulated_BER_2(snr) = simulated_BER_2(snr) + 1;
        end

    end

    for value = 1:n

        if convolved_3(value * 10) >= 0
            decoded_3(snr, value) = 1;
        else
            decoded_3(snr, value) = 0;
        end

        if decoded_3(snr, value) ~= signal(value)
            simulated_BER_3(snr) = simulated_BER_3(snr) + 1;
        end

    end

end

disp(simulated_BER_1 / n);
disp(simulated_BER_2 / n);
disp(simulated_BER_3 / n);

% Plot both arrays on the same graph with different colors
semilogy(-10:20, simulated_BER_1 / n, 'r', 'LineWidth', 2); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(-10:20, simulated_BER_2 / n, 'm', 'LineWidth', 2); % Use red color for y1
hold on; % Keep the current plot and add new plots to it
semilogy(-10:20, simulated_BER_3 / n, 'g', 'LineWidth', 2); % Use red color for y1

xlabel('SNR');
ylabel('BER');
title('Plot of BER');
legend('Unit', 'Pulse', 'Triangler');

figure;
semilogy(-10:20, 1/2 .* erfc(-10:20), 'b', 'LineWidth', 2); % Use blue color for y2
hold off; % Release the current plot and reset the plot settings
% Add labels and a legend
xlabel('SNR');
ylabel('BER');
title('Plot of BER');
legend('theortical bit error rate');

% disp([decoded_1]);
% disp([decoded_2]);
% disp([decoded_3]);
% disp([signal]);

%! Theoritical bit error rate
%? BER1_theoritcal(i) = BERTheoritcal(N0);
%? BER2_theoritcal(i) = BERTheoritcal(N0);
%? BER3_theoritcal(i) = BERTheoritcal(4 * N0 / 3); % so that erfc be sqrt(3) / 2*sqrt(No)

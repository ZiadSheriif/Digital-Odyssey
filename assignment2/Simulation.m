n = 10; % replace with desired size of arr
signal = randi([0,1],1,n); % generate array of random 0s and 1s
gt = zeros(1,10*n); % initialize gt with zeros
rt = zeros(31,10*n); % initialize gt with zeros
ht_1 = ones(1,10);
ht_2 = zeros(1,10); ht_2(5) = 1;
ht_3 = linspace(0, sqrt(3), 10);

for i = 1:n
    if signal(i) == 1
        gt(10*(i-1)+1:10*i) = 1; % set 10 corresponding elements in gt to value of arr element
    else
        gt(10*(i-1)+1:10*i) = -1; % set 10 corresponding elements in gt to value of arr element
    end
end

channel_output = awgn(gt,20,'measured');
convolved_1 = conv(channel_output, ht_1);
convolved_2 = conv(channel_output, ht_2);
convolved_3 = conv(channel_output, ht_3);
figure;
myPlot(channel_output,"time","channel_output","channel output (SNR = 20db)");
figure;
myPlot(convolved_1,"time","received signal","unit filter");
figure;
myPlot(convolved_2,"time","received signal","not existent");
figure;
myPlot(convolved_3,"time","received signal","triangle");

for snr = -10:20
    rt(snr+11,:) = awgn(gt,snr,'measured'); 
end
% disp(rt);

decoded_1 = zeros(31,n);
decoded_2 = zeros(31,n);
decoded_3 = zeros(31,n);
sim_bit_error_1 = zeros(31,n);
sim_bit_error_2 = zeros(31,n);
sim_bit_error_3 = zeros(31,n);
for snr = 1:31
    convolved_1 = conv(rt(snr,:), ht_1);
    convolved_2 = conv(rt(snr,:), ht_2);
    convolved_3 = conv(rt(snr,:), ht_3);
    for value = 1:n
        if convolved_1(value*10) >= 0
            decoded_1(snr,value) = 1;
        else
            decoded_1(snr,value) = 0;
        end
        
        if decoded_1(snr,value) == signal(value)
            sim_bit_error_1(snr,value) = 1;
        end
    end
    
    for value = 1:n
        if convolved_2(value*10) >= 0
            decoded_2(snr,value) = 1;
        else
            decoded_2(snr,value) = 0;
        end
        if decoded_2(snr,value) == signal(value)
            sim_bit_error_2(snr,value) = 1;
        end
    end
    
    for value = 1:n
        if convolved_3(value*10) >= 0
            decoded_3(snr,value) = 1;
        else
            decoded_3(snr,value) = 0;
        end
        
        if decoded_3(snr,value) == signal(value)
            sim_bit_error_3(snr,value) = 1;
        end
    end
end
% figure;
% myPlot(sim_bit_error_1,"sim_bit_error_1","sim_bit_error_1","sim_bit_error_1");
% figure;
% myPlot(sim_bit_error_2,"sim_bit_error_1","sim_bit_error_1","sim_bit_error_1");
% figure;
% myPlot(sim_bit_error_3,"sim_bit_error_1","sim_bit_error_1","sim_bit_error_1");

disp([decoded_1]);
disp([decoded_2]);
disp([decoded_3]);
disp([signal]);



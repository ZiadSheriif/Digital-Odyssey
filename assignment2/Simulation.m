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


for snr = -10:20
    rt(snr+11,:) = awgn(gt,snr,'measured');
end
% disp(rt);

decoded_1 = zeros(31,n);
decoded_2 = zeros(31,n);
decoded_3 = zeros(31,n);
for snr = 1:31
    convolved_1 = conv(rt(snr,:), ht_1);
    convolved_2 = conv(rt(snr,:), ht_2);
    convolved_3 = conv(rt(snr,:), ht_3);
    
    for value = 1:n
        if convolved_1((value-1)*10+5) >= 0
            decoded_1(snr,value) = 1;
        else
            decoded_1(snr,value) = 0;
        end
    end
    
    for value = 1:n
        if convolved_2((value-1)*10+5) >= 0
            decoded_2(snr,value) = 1;
        else
            decoded_2(snr,value) = 0;
        end
    end
    
    for value = 1:n
        if convolved_3((value-1)*10+5) >= 0
            decoded_3(snr,value) = 1;
        else
            decoded_3(snr,value) = 0;
        end
    end
end

disp([decoded_1]);
disp([decoded_2]);
disp([decoded_3]);
disp([signal]);
% disp(["signal",signal]);
% % disp(["convolved_1",convolved_1]);
% disp(["decoded_1",decoded_1]);
% plot(ht_3); % plot the triangle signal
% xlabel('Index'); % label the x-axis
% ylabel('Value'); % label the y-axis
% title('Right Angled Triangle Signal'); % add a title to the plot



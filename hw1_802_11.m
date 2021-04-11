%times = [0,0,0,0,0,0,0,0];
times = 0;


througput = zeros(10,8);
for L =1:10
   for N = 1:8
        %N =8;
        user = zeros(1,N);%recond each user ready to listen
        T_OVER = 0; % record the time latest data over
        BE = ones(1,N)*3;
        CW = 1;
        Rx_data = 0;
        %L = 10;
        T = 100000;
        
        for t = 0:T
            tt = min(user); 
        if (t==tt)
                if(tt<T_OVER)
                    for i =1:N
                        if (user(i)==tt)
                            user(i)=T_OVER +  unidrnd(2^BE(i))-1 + CW;
                            if(BE(i)<7)
                                BE(i) = BE(i)+1;
                            end
                        end
                    end
                elseif (tt>=T_OVER)
                    %disp('someone start to transmit');             
                    USER_SAME_TIME = 0;
                    for i =1:N
                        if (user(i)==tt)
                            BE(i) = 3;
                            user(i) = user(i) + CW + L + unidrnd(2^BE(i))-1;
                            USER_SAME_TIME= USER_SAME_TIME+1;
                           % a = a+1;
                        end
                    end
                    %disp('next time to transmit');
                    T_OVER = tt + CW + L;
                    %disp(T_OVER);
                    if (USER_SAME_TIME==1)
                        if(T_OVER<=T)
                            Rx_data = Rx_data+L;
                            %b = b+1;
                        else
                            Rx_data = Rx_data+(T-tt-CW);
                        end
                    end
                end
            else
                % do nothing
            end
        end
        througput(L,N) = Rx_data/(T*N);
    end
end




x = 1:8;
plot(x,throughput(10,:),'*r-')
hold on
plot(x,throughput(9,:),'*b-')
plot(x,throughput(8,:),'*k-')
plot(x,throughput(7,:),'*c-')
plot(x,throughput(6,:),'*m-')
plot(x,throughput(5,:),'*r--')
plot(x,throughput(4,:),'*b--')
plot(x,throughput(3,:),'*k--')
plot(x,throughput(2,:),'*c--')
plot(x,throughput(1,:),'*m--')
hold off

ylabel('Average Throughput');
xlabel('Number of Users');
title('Simulation of IEEE 802.11');
legend(' L=10',' L=9',' L=8',' L=7',' L=6',' L=5',' L=4',' L=3',' L=2',' L=1');
grid on;






    


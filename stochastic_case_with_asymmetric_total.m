%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sevices=10;%num of serve nodes

price =[];
i =1;
PriceArray = [0.25;0.5;0.75;1];%price range
while i <= sevices
    price = [price;PriceArray(randi(4))];
    i=i+1;
end

T=100000;%num of time t

Lambda=0.9;
A=binornd(1,Lambda,T,1);%node service request distribution

u1=0.11;u2=0.11;u3=0.11;u4=0.11;u5=0.11;u6=0.09;u7=0.09;u8=0.09;u9=0.09;u10=0.09;%service node service distribution
ulist=[u1;u2;u3;u4;u5;u6;u7;u8;u9;u10];
U1=binornd(1,u1,T,1);
U2=binornd(1,u2,T,1);
U3=binornd(1,u3,T,1);
U4=binornd(1,u4,T,1);
U5=binornd(1,u5,T,1);
U6=binornd(1,u6,T,1);
U7=binornd(1,u7,T,1);
U8=binornd(1,u8,T,1);
U9=binornd(1,u9,T,1);
U10=binornd(1,u10,T,1);

b=0;
while b<=10 %γ
    x = [];
    y1= [];
    y2= [];
    y3= [];
    y4= [];
    y5= [];
    y6= [];

    a=0.005;

    while a<=10 %β
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.aoi =[];
        i =1;
        while i <= sevices
            opt.aoi = [opt.aoi;0];
            i=i+1;
        end

        aoi =[];
        i =1;
        while i <= sevices
            aoi = [aoi;0];
            i=i+1;
        end

        without_aoi =[];
        i =1;
        while i <= sevices
            without_aoi = [without_aoi;0];
            i=i+1;
        end

        greedy_aoi =[];
        i =1;
        while i <= sevices
            greedy_aoi = [greedy_aoi;0];
            i=i+1;
        end

        random_aoi =[];
        i =1;
        while i <= sevices
            random_aoi = [random_aoi;0];
            i=i+1;
        end

        lbfs_aoi =[];
        i =1;
        while i <= sevices
            lbfs_aoi = [lbfs_aoi;0];
            i=i+1;
        end

        fbfs_aoi =[];
        i =1;
        while i <= sevices
            fbfs_aoi = [fbfs_aoi;0];
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.Q =[];
        i =1;
        while i <= sevices
            opt.Q = [opt.Q;0];
            i=i+1;
        end

        Q =[];
        i =1;
        while i <= sevices
            Q = [Q;0];
            i=i+1;
        end

        without_Q =[];
        i =1;
        while i <= sevices
            without_Q = [without_Q;0];
            i=i+1;
        end

        greedy_Q =[];
        i =1;
        while i <= sevices
            greedy_Q = [greedy_Q;0];
            i=i+1;
        end

        random_Q =[];
        i =1;
        while i <= sevices
            random_Q = [random_Q;0];
            i=i+1;
        end

        lbfs_Q =[];
        i =1;
        while i <= sevices
            lbfs_Q = [lbfs_Q;0];
            i=i+1;
        end

        fbfs_Q =[];
        i =1;
        while i <= sevices
            fbfs_Q = [fbfs_Q;0];
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.total.Q.L=0;
        total.Q.L=0;
        without_total.Q.L=0;
        greedy_total.Q.L=0;
        random_total.Q.L=0;
        lbfs_total.Q.L=0;
        fbfs_total.Q.L=0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.maxaoi=0;
        maxaoi=0;
        without_maxaoi=0;
        greedy_maxaoi=0;
        random_maxaoi=0;
        lbfs_maxaoi=0;
        fbfs_maxaoi=0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.average.aoi=zeros(sevices,T);
        average.aoi=zeros(sevices,T);
        without_average.aoi=zeros(sevices,T);
        greedy_average.aoi=zeros(sevices,T);
        random_average.aoi=zeros(sevices,T);
        lbfs_average.aoi=zeros(sevices,T);
        fbfs_average.aoi=zeros(sevices,T);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        opt.account =[];
        i =1;
        while i <= sevices
            opt.account = [opt.account,0];
            i=i+1;
        end
        account =[];
        i =1;
        while i <= sevices
            account = [account,0];
            i=i+1;
        end
        without_account =[];
        i =1;
        while i <= sevices
            without_account = [without_account,0];
            i=i+1;
        end
        greedy_account =[];
        i =1;
        while i <= sevices
            greedy_account = [greedy_account,0];
            i=i+1;
        end
        random_account =[];
        i =1;
        while i <= sevices
            random_account = [random_account,0];
            i=i+1;
        end
        lbfs_account =[];
        i =1;
        while i <= sevices
            lbfs_account = [lbfs_account,0];
            i=i+1;
        end
        fbfs_account =[];
        i =1;
        while i <= sevices
            fbfs_account = [fbfs_account,0];
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        lbfs=1;
        direct=2;
        fbfs=1;
        t=1;
        while t<=T %num of time t

            if mod(t,100)==0
                randIndex = randperm(size(price,1));
                price=price(randIndex,:);%The price of each node is reset every 100 rounds
            end

            i =1;
            while i <= sevices
                opt.total.Q.L = opt.total.Q.L+opt.Q(i);%opt total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE
                [M,I] = min(opt.Q);
                B=[I;M];
                opt.Q(I)=opt.Q(I)+1;%The opt strategy is to join the shortest queue
                opt.account(I)=opt.account(I)+1;
            end

            i =1;
            while i <= sevices
                opt.average.aoi(i,t) = opt.aoi(i);%Count opt's aoi into a two-dimensional array
                i=i+1;
            end


            [M,I] = max(opt.aoi);
            B=[I;M];
            opt.maxaoi = opt.maxaoi+ulist(I)*B(2);
            %             opt.maxaoi = opt.maxaoi+B(2);

            i =1;
            while i <= sevices
                opt.aoi(i) = opt.aoi(i)+1;%Opt's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if opt.Q(1)~=0
                    opt.aoi(1)=0;
                    opt.Q(1)=opt.Q(1)-1;
                    if opt.Q(1) <0
                        opt.Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if opt.Q(2)~=0
                    opt.aoi(2)=0;
                    opt.Q(2)=opt.Q(2)-1;
                    if opt.Q(2) <0
                        opt.Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if opt.Q(3)~=0
                    opt.aoi(3)=0;
                    opt.Q(3)=opt.Q(3)-1;
                    if opt.Q(3) <0
                        opt.Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if opt.Q(4)~=0
                    opt.aoi(4)=0;
                    opt.Q(4)=opt.Q(4)-1;
                    if opt.Q(4) <0
                        opt.Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if opt.Q(5)~=0
                    opt.aoi(5)=0;
                    opt.Q(5)=opt.Q(5)-1;
                    if opt.Q(5) <0
                        opt.Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if opt.Q(6)~=0
                    opt.aoi(6)=0;
                    opt.Q(6)=opt.Q(6)-1;
                    if opt.Q(6) <0
                        opt.Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if opt.Q(7)~=0
                    opt.aoi(7)=0;
                    opt.Q(7)=opt.Q(7)-1;
                    if opt.Q(7) <0
                        opt.Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if opt.Q(8)~=0
                    opt.aoi(8)=0;
                    opt.Q(8)=opt.Q(8)-1;
                    if opt.Q(8) <0
                        opt.Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if opt.Q(9)~=0
                    opt.aoi(9)=0;
                    opt.Q(9)=opt.Q(9)-1;
                    if opt.Q(9) <0
                        opt.Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if opt.Q(10)~=0
                    opt.aoi(10)=0;
                    opt.Q(10)=opt.Q(10)-1;
                    if opt.Q(10) <0
                        opt.Q(10)=0;
                    end
                end
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                total.Q.L = total.Q.L+Q(i);%Incentive strategy total queue length
                i=i+1;
            end

            if A(t)==1%node service request is TRUE
                compare=[];
                f.compare=[];
                if U1(t)==1
                    compare=[compare;a*aoi(1)-b*(1/150)*Q(1)-0.3*price(1)];%profit value
                    f.compare=[f.compare;1];
                end
                if U2(t)==1
                    compare=[compare;a*aoi(2)-b*(1/150)*Q(2)-0.3*price(2)];
                    f.compare=[f.compare;2];
                end
                if U3(t)==1
                    compare=[compare;a*aoi(3)-b*(1/150)*Q(3)-0.3*price(3)];
                    f.compare=[f.compare;3];
                end
                if U4(t)==1
                    compare=[compare;a*aoi(4)-b*(1/150)*Q(4)-0.3*price(4)];
                    f.compare=[f.compare;4];
                end
                if U5(t)==1
                    compare=[compare;a*aoi(5)-b*(1/150)*Q(5)-0.3*price(5)];
                    f.compare=[f.compare;5];
                end
                if U6(t)==1
                    compare=[compare;a*aoi(6)-b*(1/150)*Q(6)-0.3*price(6)];
                    f.compare=[f.compare;6];
                end
                if U7(t)==1
                    compare=[compare;a*aoi(7)-b*(1/150)*Q(7)-0.3*price(7)];
                    f.compare=[f.compare;7];
                end
                if U8(t)==1
                    compare=[compare;a*aoi(8)-b*(1/150)*Q(8)-0.3*price(8)];
                    f.compare=[f.compare;8];
                end
                if U9(t)==1
                    compare=[compare;a*aoi(9)-b*(1/150)*Q(9)-0.3*price(9)];
                    f.compare=[f.compare;9];
                end
                if U10(t)==1
                    compare=[compare;a*aoi(10)-b*(1/150)*Q(10)-0.3*price(10)];
                    f.compare=[f.compare;10];
                end
                if isempty(compare)
                    v =1;
                    while v <= sevices
                        compare=[compare;a*aoi(v)-b*(1/150)*Q(v)-0.3*price(v)];
                        v=v+1;
                    end
                    [M,I] = max(compare);
                    B=[I;M];
                    Q(I)=Q(I)+1;%The incentive strategy is to join the most profitable queue
                    if a>=9.90 %draw data
                        account(I)=account(I)+1;%Service count cumulative
                    end
                else
                    [M,I] = max(compare);
                    B=[I;M];
                    f.f=f.compare(I);
                    Q(f.f)=Q(f.f)+1;%The incentive strategy is to join the most profitable queue
                    if a>=9.90 %draw data
                        account(f.f)=account(f.f)+1;%Service count cumulative
                    end
                end
            end

            i =1;
            while i <= sevices
                average.aoi(i,t) = aoi(i);%Count the Aoi of the incentive strategy into a two-dimensional array
                i=i+1;
            end

            [M,I] = max(aoi);
            B=[I;M];
            maxaoi = maxaoi+ulist(I)*B(2);
            %             maxaoi = maxaoi+B(2);

            i =1;
            while i <= sevices
                aoi(i) = aoi(i)+1;%The overall aoi of the incentive strategy +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if Q(1)~=0
                    aoi(1)=0;
                    Q(1)=Q(1)-1;
                    if Q(1)<0
                        Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if Q(2)~=0
                    aoi(2)=0;
                    Q(2)=Q(2)-1;
                    if Q(2)<0
                        Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if Q(3)~=0
                    aoi(3)=0;
                    Q(3)=Q(3)-1;
                    if Q(3)<0
                        Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if Q(4)~=0
                    aoi(4)=0;
                    Q(4)=Q(4)-1;
                    if Q(4)<0
                        Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if Q(5)~=0
                    aoi(5)=0;
                    Q(5)=Q(5)-1;
                    if Q(5)<0
                        Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if Q(6)~=0
                    aoi(6)=0;
                    Q(6)=Q(6)-1;
                    if Q(6)<0
                        Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if Q(7)~=0
                    aoi(7)=0;
                    Q(7)=Q(7)-1;
                    if Q(7)<0
                        Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if Q(8)~=0
                    aoi(8)=0;
                    Q(8)=Q(8)-1;
                    if Q(8)<0
                        Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if Q(9)~=0
                    aoi(9)=0;
                    Q(9)=Q(9)-1;
                    if Q(9)<0
                        Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if Q(10)~=0
                    aoi(10)=0;
                    Q(10)=Q(10)-1;
                    if Q(10)<0
                        Q(10)=0;
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                without_total.Q.L = without_total.Q.L+without_Q(i);%without total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE
                [M,I] = min(price);
                B=[I;M];
                without_Q(I)=without_Q(I)+1;%The strategy is to join the smallest price
                without_account(I)=without_account(I)+1;
            end

            i =1;
            while i <= sevices
                without_average.aoi(i,t) = without_aoi(i);%Count without's aoi into a two-dimensional array
                i=i+1;
            end


            [M,I] = max(without_aoi);
            B=[I;M];
            without_maxaoi = without_maxaoi+ulist(I)*B(2);
            %             without_maxaoi = without_maxaoi+B(2);

            i =1;
            while i <= sevices
                without_aoi(i) = without_aoi(i)+1;%without's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if without_Q(1)~=0
                    without_aoi(1)=0;
                    without_Q(1)=without_Q(1)-1;
                    if without_Q(1) <0
                        without_Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if without_Q(2)~=0
                    without_aoi(2)=0;
                    without_Q(2)=without_Q(2)-1;
                    if without_Q(2) <0
                        without_Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if without_Q(3)~=0
                    without_aoi(3)=0;
                    without_Q(3)=without_Q(3)-1;
                    if without_Q(3) <0
                        without_Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if without_Q(4)~=0
                    without_aoi(4)=0;
                    without_Q(4)=without_Q(4)-1;
                    if without_Q(4) <0
                        without_Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if without_Q(5)~=0
                    without_aoi(5)=0;
                    without_Q(5)=without_Q(5)-1;
                    if without_Q(5) <0
                        without_Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if without_Q(6)~=0
                    without_aoi(6)=0;
                    without_Q(6)=without_Q(6)-1;
                    if without_Q(6) <0
                        without_Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if without_Q(7)~=0
                    without_aoi(7)=0;

                    without_Q(7)=without_Q(7)-1;
                    if without_Q(7) <0
                        without_Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if without_Q(8)~=0
                    without_aoi(8)=0;
                    without_Q(8)=without_Q(8)-1;
                    if without_Q(8) <0
                        without_Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if without_Q(9)~=0
                    without_aoi(9)=0;
                    without_Q(9)=without_Q(9)-1;
                    if without_Q(9) <0
                        without_Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if without_Q(10)~=0
                    without_aoi(10)=0;
                    without_Q(10)=without_Q(10)-1;
                    if without_Q(10) <0
                        without_Q(10)=0;
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                greedy_total.Q.L = greedy_total.Q.L+greedy_Q(i);%greedy total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE
                [M,I] = max(greedy_aoi);
                B=[I;M];
                greedy_Q(I)=greedy_Q(I)+1;%The strategy is to join the max aoi
                greedy_account(I)=greedy_account(I)+1;
            end

            i =1;
            while i <= sevices
                greedy_average.aoi(i,t) = greedy_aoi(i);%Count greedy's aoi into a two-dimensional array
                i=i+1;
            end


            [M,I] = max(greedy_aoi);
            B=[I;M];
            greedy_maxaoi = greedy_maxaoi+ulist(I)*B(2);
            %             greedy_maxaoi = greedy_maxaoi+B(2);

            i =1;
            while i <= sevices
                greedy_aoi(i) = greedy_aoi(i)+1;%greedy's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if greedy_Q(1)~=0
                    greedy_aoi(1)=0;
                    greedy_Q(1)=greedy_Q(1)-1;
                    if greedy_Q(1) <0
                        greedy_Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if greedy_Q(2)~=0
                    greedy_aoi(2)=0;
                    greedy_Q(2)=greedy_Q(2)-1;
                    if greedy_Q(2) <0
                        greedy_Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if greedy_Q(3)~=0
                    greedy_aoi(3)=0;
                    greedy_Q(3)=greedy_Q(3)-1;
                    if greedy_Q(3) <0
                        greedy_Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if greedy_Q(4)~=0
                    greedy_aoi(4)=0;
                    greedy_Q(4)=greedy_Q(4)-1;
                    if greedy_Q(4) <0
                        greedy_Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if greedy_Q(5)~=0
                    greedy_aoi(5)=0;
                    greedy_Q(5)=greedy_Q(5)-1;
                    if greedy_Q(5) <0
                        greedy_Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if greedy_Q(6)~=0
                    greedy_aoi(6)=0;
                    greedy_Q(6)=greedy_Q(6)-1;
                    if greedy_Q(6) <0
                        greedy_Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if greedy_Q(7)~=0
                    greedy_aoi(7)=0;

                    greedy_Q(7)=greedy_Q(7)-1;
                    if greedy_Q(7) <0
                        greedy_Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if greedy_Q(8)~=0
                    greedy_aoi(8)=0;
                    greedy_Q(8)=greedy_Q(8)-1;
                    if greedy_Q(8) <0
                        greedy_Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if greedy_Q(9)~=0
                    greedy_aoi(9)=0;
                    greedy_Q(9)=greedy_Q(9)-1;
                    if greedy_Q(9) <0
                        greedy_Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if greedy_Q(10)~=0
                    greedy_aoi(10)=0;
                    greedy_Q(10)=greedy_Q(10)-1;
                    if greedy_Q(10) <0
                        greedy_Q(10)=0;
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                random_total.Q.L = random_total.Q.L+random_Q(i);%random total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE
                I = randi(sevices);
                random_Q(I)=random_Q(I)+1;%The strategy is to join the random one
                random_account(I)=random_account(I)+1;
            end

            i =1;
            while i <= sevices
                random_average.aoi(i,t) = random_aoi(i);%Count random's aoi into a two-dimensional array
                i=i+1;
            end

            [M,I] = max(random_aoi);
            B=[I;M];
            random_maxaoi = random_maxaoi+ulist(I)*B(2);
            %             random_maxaoi = random_maxaoi+B(2);

            i =1;
            while i <= sevices
                random_aoi(i) = random_aoi(i)+1;%random's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if random_Q(1)~=0
                    random_aoi(1)=0;
                    random_Q(1)=random_Q(1)-1;
                    if random_Q(1) <0
                        random_Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if random_Q(2)~=0
                    random_aoi(2)=0;
                    random_Q(2)=random_Q(2)-1;
                    if random_Q(2) <0
                        random_Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if random_Q(3)~=0
                    random_aoi(3)=0;
                    random_Q(3)=random_Q(3)-1;
                    if random_Q(3) <0
                        random_Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if random_Q(4)~=0
                    random_aoi(4)=0;
                    random_Q(4)=random_Q(4)-1;
                    if random_Q(4) <0
                        random_Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if random_Q(5)~=0
                    random_aoi(5)=0;
                    random_Q(5)=random_Q(5)-1;
                    if random_Q(5) <0
                        random_Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if random_Q(6)~=0
                    random_aoi(6)=0;
                    random_Q(6)=random_Q(6)-1;
                    if random_Q(6) <0
                        random_Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if random_Q(7)~=0
                    random_aoi(7)=0;

                    random_Q(7)=random_Q(7)-1;
                    if random_Q(7) <0
                        random_Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if random_Q(8)~=0
                    random_aoi(8)=0;
                    random_Q(8)=random_Q(8)-1;
                    if random_Q(8) <0
                        random_Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if random_Q(9)~=0
                    random_aoi(9)=0;
                    random_Q(9)=random_Q(9)-1;
                    if random_Q(9) <0
                        random_Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if random_Q(10)~=0
                    random_aoi(10)=0;
                    random_Q(10)=random_Q(10)-1;
                    if random_Q(10) <0
                        random_Q(10)=0;
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                lbfs_total.Q.L = lbfs_total.Q.L+lbfs_Q(i);%lbfs total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE

                if lbfs~= 1 && lbfs~= sevices
                    if direct ==0
                        lbfs=lbfs+1;
                        I=lbfs;
                        if lbfs ==sevices
                            direct=2;
                        end
                    else
                        lbfs=lbfs-1;
                        I=lbfs;
                        if lbfs ==1
                            direct=2;
                        end
                    end
                else
                    if direct ==2
                        if lbfs ==1
                            I=lbfs;
                            direct=0;
                        else
                            I=lbfs;
                            direct=1;
                        end
                    end
                    if direct ==0
                        lbfs=lbfs+1;
                        I=lbfs;
                    end
                    if direct ==1
                        lbfs=lbfs-1;
                        I=lbfs;
                    end
                end

                lbfs_Q(I)=lbfs_Q(I)+1;%The lbfs strategy is to join the lbfs
                lbfs_account(I)=lbfs_account(I)+1;
            end

            i =1;
            while i <= sevices
                lbfs_average.aoi(i,t) = lbfs_aoi(i);%Count lbfs's aoi into a two-dimensional array
                i=i+1;
            end


            [M,I] = max(lbfs_aoi);
            B=[I;M];
            lbfs_maxaoi = lbfs_maxaoi+ulist(I)*B(2);
            %             lbfs_maxaoi = lbfs_maxaoi+B(2);

            i =1;
            while i <= sevices
                lbfs_aoi(i) = lbfs_aoi(i)+1;%lbfs's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if lbfs_Q(1)~=0
                    lbfs_aoi(1)=0;
                    lbfs_Q(1)=lbfs_Q(1)-1;
                    if lbfs_Q(1) <0
                        lbfs_Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if lbfs_Q(2)~=0
                    lbfs_aoi(2)=0;
                    lbfs_Q(2)=lbfs_Q(2)-1;
                    if lbfs_Q(2) <0
                        lbfs_Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if lbfs_Q(3)~=0
                    lbfs_aoi(3)=0;
                    lbfs_Q(3)=lbfs_Q(3)-1;
                    if lbfs_Q(3) <0
                        lbfs_Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if lbfs_Q(4)~=0
                    lbfs_aoi(4)=0;
                    lbfs_Q(4)=lbfs_Q(4)-1;
                    if lbfs_Q(4) <0
                        lbfs_Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if lbfs_Q(5)~=0
                    lbfs_aoi(5)=0;
                    lbfs_Q(5)=lbfs_Q(5)-1;
                    if lbfs_Q(5) <0
                        lbfs_Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if lbfs_Q(6)~=0
                    lbfs_aoi(6)=0;
                    lbfs_Q(6)=lbfs_Q(6)-1;
                    if lbfs_Q(6) <0
                        lbfs_Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if lbfs_Q(7)~=0
                    lbfs_aoi(7)=0;
                    lbfs_Q(7)=lbfs_Q(7)-1;
                    if lbfs_Q(7) <0
                        lbfs_Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if lbfs_Q(8)~=0
                    lbfs_aoi(8)=0;
                    lbfs_Q(8)=lbfs_Q(8)-1;
                    if lbfs_Q(8) <0
                        lbfs_Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if lbfs_Q(9)~=0
                    lbfs_aoi(9)=0;
                    lbfs_Q(9)=lbfs_Q(9)-1;
                    if lbfs_Q(9) <0
                        lbfs_Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if lbfs_Q(10)~=0
                    lbfs_aoi(10)=0;
                    lbfs_Q(10)=lbfs_Q(10)-1;
                    if lbfs_Q(10) <0
                        lbfs_Q(10)=0;
                    end
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i =1;
            while i <= sevices
                fbfs_total.Q.L = fbfs_total.Q.L+fbfs_Q(i);%fbfs total queue length
                i=i+1;
            end

            if A(t)==1%%node service request is TRUE

                I=fbfs;
                fbfs=fbfs+1;
                if fbfs > sevices
                    fbfs=1;
                end

                fbfs_Q(I)=fbfs_Q(I)+1;%The fbfs strategy is to join the fbfs
                fbfs_account(I)=fbfs_account(I)+1;
            end

            i =1;
            while i <= sevices
                fbfs_average.aoi(i,t) = fbfs_aoi(i);%Count fbfs's aoi into a two-dimensional array
                i=i+1;
            end


            [M,I] = max(fbfs_aoi);
            B=[I;M];
            fbfs_maxaoi = fbfs_maxaoi+ulist(I)*B(2);
            %             fbfs_maxaoi = fbfs_maxaoi+B(2);

            i =1;
            while i <= sevices
                fbfs_aoi(i) = fbfs_aoi(i)+1;%fbfs's Aoi overall +1
                i=i+1;
            end

            if U1(t)==1%Node 1 service is TRUE
                if fbfs_Q(1)~=0
                    fbfs_aoi(1)=0;
                    fbfs_Q(1)=fbfs_Q(1)-1;
                    if fbfs_Q(1) <0
                        fbfs_Q(1)=0;
                    end
                end
            end
            if U2(t)==1%Node 2 service is TRUE
                if fbfs_Q(2)~=0
                    fbfs_aoi(2)=0;
                    fbfs_Q(2)=fbfs_Q(2)-1;
                    if fbfs_Q(2) <0
                        fbfs_Q(2)=0;
                    end
                end
            end
            if U3(t)==1%Node 3 service is TRUE
                if fbfs_Q(3)~=0
                    fbfs_aoi(3)=0;
                    fbfs_Q(3)=fbfs_Q(3)-1;
                    if fbfs_Q(3) <0
                        fbfs_Q(3)=0;
                    end
                end
            end
            if U4(t)==1%Node 4 service is TRUE
                if fbfs_Q(4)~=0
                    fbfs_aoi(4)=0;
                    fbfs_Q(4)=fbfs_Q(4)-1;
                    if fbfs_Q(4) <0
                        fbfs_Q(4)=0;
                    end
                end
            end
            if U5(t)==1%Node 5 service is TRUE
                if fbfs_Q(5)~=0
                    fbfs_aoi(5)=0;
                    fbfs_Q(5)=fbfs_Q(5)-1;
                    if fbfs_Q(5) <0
                        fbfs_Q(5)=0;
                    end
                end
            end
            if U6(t)==1%Node 6 service is TRUE
                if fbfs_Q(6)~=0
                    fbfs_aoi(6)=0;
                    fbfs_Q(6)=fbfs_Q(6)-1;
                    if fbfs_Q(6) <0
                        fbfs_Q(6)=0;
                    end
                end
            end
            if U7(t)==1%Node 7 service is TRUE
                if fbfs_Q(7)~=0
                    fbfs_aoi(7)=0;
                    fbfs_Q(7)=fbfs_Q(7)-1;
                    if fbfs_Q(7) <0
                        fbfs_Q(7)=0;
                    end
                end
            end
            if U8(t)==1%Node 8 service is TRUE
                if fbfs_Q(8)~=0
                    fbfs_aoi(8)=0;
                    fbfs_Q(8)=fbfs_Q(8)-1;
                    if fbfs_Q(8) <0
                        fbfs_Q(8)=0;
                    end
                end
            end
            if U9(t)==1%Node 9 service is TRUE
                if fbfs_Q(9)~=0
                    fbfs_aoi(9)=0;
                    fbfs_Q(9)=fbfs_Q(9)-1;
                    if fbfs_Q(9) <0
                        fbfs_Q(9)=0;
                    end
                end
            end
            if U10(t)==1%Node 10 service is TRUE
                if fbfs_Q(10)~=0
                    fbfs_aoi(10)=0;
                    fbfs_Q(10)=fbfs_Q(10)-1;
                    if fbfs_Q(10) <0
                        fbfs_Q(10)=0;
                    end
                end
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            t=t+1;
        end


        i =1;
        opt.bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + opt.average.aoi(i,j);
                j=j+1;
            end
            opt.bignumaoi=opt.bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + average.aoi(i,j);
                j=j+1;
            end
            bignumaoi=bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        without_bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + without_average.aoi(i,j);
                j=j+1;
            end
            without_bignumaoi=without_bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        greedy_bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + greedy_average.aoi(i,j);
                j=j+1;
            end
            greedy_bignumaoi=greedy_bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        random_bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + random_average.aoi(i,j);
                j=j+1;
            end
            random_bignumaoi=random_bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        lbfs_bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + lbfs_average.aoi(i,j);
                j=j+1;
            end
            lbfs_bignumaoi=lbfs_bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i =1;
        fbfs_bignumaoi=0;
        while i <= sevices
            j =1;
            numaoi=0;
            while j <= T
                numaoi = numaoi + fbfs_average.aoi(i,j);
                j=j+1;
            end
            fbfs_bignumaoi=fbfs_bignumaoi+(numaoi/T)*ulist(i);
            i=i+1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        x = [x;a] ;
        y1= [y1;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*total.Q.L)/T)+a*bignumaoi)];%POA
        y2= [y2;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*without_total.Q.L)/T)+a*without_bignumaoi)];%POA
        y3= [y3;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*greedy_total.Q.L)/T)+a*greedy_bignumaoi)];%POA
        y4= [y4;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*random_total.Q.L)/T)+a*random_bignumaoi)];%POA
        y5= [y5;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*lbfs_total.Q.L)/T)+a*lbfs_bignumaoi)];%POA
        y6= [y6;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.bignumaoi)/((((b*(1/15)/sevices)*fbfs_total.Q.L)/T)+a*fbfs_bignumaoi)];%POA

        if a<0.01
            a=a+0.001;
        else
            a=a+0.1;
        end

    end

    if b==0
        y1(1)=1;
        y2(1)=1;
        y3(1)=1;
        y4(1)=1;
        y5(1)=1;
        y6(1)=1;
        y11=y1;
        y12=y2;
        y13=y3;
        y14=y4;
        y15=y5;
        y16=y6;
        Y1=account;
    end
    if b==2
        y21=y1;
        y22=y2;
        y23=y3;
        y24=y4;
        y25=y5;
        y26=y6;
        Y2=account;
    end
    if b==5
        y31=y1;
        y32=y2;
        y33=y3;
        y34=y4;
        y35=y5;
        y36=y6;
        Y3=account;
    end
    if b==10
        y41=y1;
        y42=y2;
        y43=y3;
        y44=y4;
        y45=y5;
        y46=y6;
        Y4=account;
    end


    if b==0
        b=2;
    else
        if b==2
            b=5;
        else
            if b==5
                b=10;
            else
                if b==10
                    b=b+1;
                end
            end
        end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
data = [Y1;Y2;Y3;Y4];

b = bar3(data,0.7);    %0.7Represents the width of a single column
colorbar               %Z-axis numerical color bar
caxis([1,10000]);     %Color bar value range
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'xticklabel',{'PoI 1','PoI 2','PoI 3','PoI 4','PoI 5','PoI 6','PoI 7','PoI 8','PoI 9','PoI 10'})    %x coordinate axis scale value
set(gca,'yticklabel',{'\gamma=0','\gamma=2','\gamma=5','\gamma=10'})    %y coordinate axis scale value
zlim([0,10000]);      %z coordinate axis scale value
hXLabel = xlabel('PoIs','Rotation',18,'Position',[5 6.5 5]);
%hYLabel = ylabel('γ','Rotation',-40,'Position',[-1 2 0]);
hZLabel = zlabel('Times','Rotation',-90,'Position',[-1 0 800]);
set(gca,'XGrid', 'off', 'YGrid', 'off','ZGrid', 'on')
hTitle = title('Service Frequency of PoIs \{\beta=10\}');
%set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
axis([0 10 0 1]);
set(gca,'XTick',[0:2:10]) %x-axis range 0-10, interval 2
set(gca,'YTick',[0:0.1:1]) %Y-axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('Symmetric case of PoA in terms of average max age.');
xlabel('Reward Rate \beta','FontSize',15);
ylabel('Price of Anarchy (PoA)','FontSize',15);


plot(x,y21,'-d',x,y22,'-h',x,y23,'-x',x,y24,'-s',x,y25,'-+',x,y26,'-o','linewidth',2,'MarkerSize',5); % linear, color, marker
legend('Incentive Strategy','Without Incentive','Greedy Strategy','Random Strategy','LBFS Strategy','FBFS Strategy','FontSize',15);   % Upper right corner mark
grid on


figure(3)
axis([0 10 0 1]);
set(gca,'XTick',[0:2:10]) %x-axis range 0-10, interval 2
set(gca,'YTick',[0:0.1:1]) %Y-axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('Symmetric case of PoA in terms of average max age.');
xlabel('Reward Rate \beta','FontSize',15);
ylabel('Price of Anarchy (PoA)','FontSize',15);


plot(x,y31,'-d',x,y32,'-h',x,y33,'-x',x,y34,'-s',x,y35,'-+',x,y36,'-o','linewidth',2,'MarkerSize',5); % linear, color, marker
legend('Incentive Strategy','Without Incentive','Greedy Strategy','Random Strategy','LBFS Strategy','FBFS Strategy','FontSize',15);   % Upper right corner mark
grid on


figure(4)
axis([0 10 0 1]);
set(gca,'XTick',[0:2:10]) %x-axis range 0-10, interval 2
set(gca,'YTick',[0:0.1:1]) %Y-axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('Symmetric case of PoA in terms of average max age.');
xlabel('Reward Rate \beta','FontSize',15);
ylabel('Price of Anarchy (PoA)','FontSize',15);


plot(x,y41,'-d',x,y42,'-h',x,y43,'-x',x,y44,'-s',x,y45,'-+',x,y46,'-o','linewidth',2,'MarkerSize',5); % linear, color, marker
legend('Incentive Strategy','Without Incentive','Greedy Strategy','Random Strategy','LBFS Strategy','FBFS Strategy','FontSize',15);   % Upper right corner mark
grid on


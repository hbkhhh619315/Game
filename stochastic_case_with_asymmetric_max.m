%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sevices=10;%num of serve nodes

price =[];
i =1;
PriceArray = [0.25;0.5;0.75;1];%price range
while i <= sevices
    price = [price;PriceArray(randi(4))];
    i=i+1;
end

T=10000;%num of time t

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
    y= [];

    a=0.005;

    while a<=10 %β

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

        opt.total.Q.L=0;
        total.Q.L=0;

        opt.maxaoi=0;
        maxaoi=0;

        opt.average.aoi=zeros(sevices,T);
        average.aoi=zeros(sevices,T);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

        x = [x;a] ;
        y= [y;1-((((b*(1/15)/sevices)*opt.total.Q.L)/T)+a*opt.maxaoi/T)/((((b*(1/15)/sevices)*total.Q.L)/T)+a*maxaoi/T)];%POA

        if a<0.01
            a=a+0.001;
        else
            a=a+0.1;
        end

    end

    if b==0
        y(1)=1;
        y1=y;
        Y1=account;
    end
    if b==2
        y2=y;
        Y2=account;
    end
    if b==5
        y3=y;
        Y3=account;
    end
    if b==10
        y4=y;
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
caxis([1,1200]);     %Color bar value range
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'xticklabel',{'PoI 1','PoI 2','PoI 3','PoI 4','PoI 5','PoI 6','PoI 7','PoI 8','PoI 9','PoI 10'})    %x coordinate axis scale value
set(gca,'yticklabel',{'\gamma=0','\gamma=2','\gamma=5','\gamma=10'})    %y coordinate axis scale value
zlim([0,1200]);      %z coordinate axis scale value
hXLabel = xlabel('PoIs','Rotation',18,'Position',[5 6.5 5]);
%hYLabel = ylabel('γ','Rotation',-40,'Position',[-1 2 0]);
hZLabel = zlabel('Times','Rotation',-90,'Position',[-1 0 800]);
set(gca,'XGrid', 'off', 'YGrid', 'off','ZGrid', 'on')
hTitle = title('Service Frequency of PoIs \{\beta=10\}');
%set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
axis([0 10 0 0.7]);
set(gca,'XTick',[0:2:10]) %x-axis range 0-10, interval 2
set(gca,'YTick',[0:0.1:0.7]) %Y-axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('Symmetric case of PoA in terms of average max age.');
xlabel('Reward Rate \beta','FontSize',15);
ylabel('Price of Anarchy (PoA)','FontSize',15);


plot(x,y1,'-d',x,y2,'-h',x,y3,'-x',x,y4,'-s','linewidth',2,'MarkerSize',5); % linear, color, marker
legend('\gamma=0','\gamma=2','\gamma=5','\gamma=10','FontSize',15);   % Upper right corner mark
grid on


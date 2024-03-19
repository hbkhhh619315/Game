%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sevices=10;%PoIs
price=[];
i =1;
u=[0.25;0.5;0.75;1];%price range
while i <= sevices
    price = [price;u(randi(4))];
    i=i+1;
end

x = [];
y1= [];
y2= [];

a=0;
ac=[];

while a<=1.00 %β

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

    if abs(a-0.03) < 0.001 %draw data
        opt.account =[];
        i =1;
        while i <= sevices
            opt.account = [opt.account;0];
            i=i+1;
        end
        account =[];
        i =1;
        while i <= sevices
            account = [account;0];
            i=i+1;
        end

    else
        ac = [ac;a];

    end

    opt.maxaoi=0;
    opt.totalaoi=0;
    maxaoi=0;
    totalaoi=0;


    t=1;
    T=10000;%num of time t
    cell=[];


    while t<=T %num of time t

        if mod(t,100)==0

            randIndex = randperm(size(price,1));

            price=price(randIndex,:);%The price of each node is reset every 100 rounds

        end

        [M,I] = max(opt.aoi);
        B=[I;M];
        opt.maxaoi = opt.maxaoi+B(2);%Cumulative opt maximum aoi

        k =1;
        while k <= sevices
            opt.totalaoi = opt.totalaoi+opt.aoi(k);%Cumulative opt overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            opt.aoi(j) = opt.aoi(j)+1;%Opt's Aoi overall +1
            j=j+1;
        end

        opt.aoi(B(1))=0;%After opt selects the service node, aoi is set to zero.

        if abs(a-0.03) < 0.001
            opt.account(B(1))=opt.account(B(1))+1;%opt counts the number of calls to each node
        end

        [M,I] = max(aoi);
        B=[I;M];
        maxaoi = maxaoi+B(2);% cumulative incentive maximum aoi

        compare=[];
        l =1;
        while l <= sevices
            compare=[compare;a*aoi(l)-price(l)];%Incentive Bidding
            l=l+1;
        end
        [M,I] = max(compare);
        B=[I;M];
        cell=[cell;I];

        k =1;
        while k <= sevices
            totalaoi = totalaoi+aoi(k);% cumulative incentive overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            aoi(j) = aoi(j)+1;% Incentive aoi overall +1
            j=j+1;
        end

        aoi(B(1))=0;% Incentive to set aoi to zero after selecting service node

        if abs(a-0.03) < 0.001
            account(B(1))=account(B(1))+1;%Incentive statistics of the number of calls of each node
        end

        t=t+1;
    end

    if abs(a-0.03) < 0.001
        figure(1)
        axis([0 10 0 2000]);
        set(gca,'XTick',[0:1:10]) %x axis range 0-10, interval 1
        set(gca,'YTick',[0:100:2000]) %y axis range 0-2000, interval 100
        axis square;
        hold on;

        % Add title and tags
        title('Frequency of Node');
        xlabel('Node');
        ylabel('Times');


        X = 1:1:sevices;
        Y = account;
        tbar=bar(X,Y);

        xtips = tbar.XEndPoints;
        ytips = tbar.YEndPoints;
        labels = string(tbar.YData);
        text(xtips,ytips,labels,'HorizontalAlignment','center',...
            'VerticalAlignment','bottom')

        line([1:length(X)], Y, 'Color', 'r', 'LineStyle', '--', 'Marker', 'o')
    end

    x = [x;a] ;
    y1= [y1;1-opt.maxaoi/maxaoi];
    y2= [y2;1-opt.totalaoi/totalaoi];

    a=a+0.01;

end

figure(2)
axis([0 1 0 1]);
set(gca,'XTick',[0:0.2:1]) %x axis range 0-1, interval 0.2
set(gca,'YTick',[0:0.1:1]) %y axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
title('PoA');
xlabel('Reward Rate β');
ylabel('Price of Anarchy(PoA)');

plot(x,y1,'-*r',x,y2,'-ob','linewidth',2,'MarkerSize',6); % linear, color, marker
grid on



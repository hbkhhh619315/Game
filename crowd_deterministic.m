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
y3= [];
y4= [];

a=0;
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

    without_aoi =[];
    i =1;
    while i <= sevices
        without_aoi = [without_aoi;0];
        i=i+1;
    end

    if abs(a-0.01) < 0.001 %draw data
        account1 =[];
        i =1;
        while i <= sevices
            account1 = [account1;0];
            i=i+1;
        end
    end
    if abs(a-0.10) < 0.001 %draw data
        account2 =[];
        i =1;
        while i <= sevices
            account2 = [account2;0];
            i=i+1;
        end
    end
    if abs(a-0.50) < 0.001 %draw data
        account3 =[];
        i =1;
        while i <= sevices
            account3 = [account3;0];
            i=i+1;
        end
    end

    opt.maxaoi=0;
    maxaoi=0;
    without_maxaoi=0;

    opt.totalaoi=0;
    totalaoi=0;
    without_totalaoi=0;

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

        if abs(a-0.01) < 0.001
            account1(B(1))=account1(B(1))+1;%Incentive statistics of the number of calls of each node
            D1=a;
        end
        if abs(a-0.10) < 0.001
            account2(B(1))=account2(B(1))+1;%Incentive statistics of the number of calls of each node
            D2=a;
        end
        if abs(a-0.50) < 0.001
            account3(B(1))=account3(B(1))+1;%Incentive statistics of the number of calls of each node
            D3=a;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [M,I] = max(without_aoi);
        B=[I;M];
        without_maxaoi = without_maxaoi+B(2);%Cumulative opt without aoi

        [M,I] = min(price);
        B=[I;M];

        k =1;
        while k <= sevices
            without_totalaoi = without_totalaoi+without_aoi(k);%Cumulative opt overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            without_aoi(j) = without_aoi(j)+1;%without's Aoi overall +1
            j=j+1;
        end

        without_aoi(I)=0;%After without selects the service node, aoi is set to zero.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        t=t+1;
    end

    x = [x;a] ;
    y1= [y1;1-opt.maxaoi/maxaoi];
    y2= [y2;1-opt.totalaoi/totalaoi];
    y3= [y3;1-opt.maxaoi/without_maxaoi];
    y4= [y4;1-opt.totalaoi/without_totalaoi];

    a=a+0.01;

end

figure(1)
account1=account1';
account2=account2';
account3=account3';
data = [account1;account2;account3];
b = bar3(data,0.7); %0.7Represents the width of a single column
colorbar %Z-axis numerical color bar
caxis([1,1500]); %Color bar value range
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'xticklabel',{'PoI 1','PoI 2','PoI 3','PoI 4','PoI 5','PoI 6','PoI 7','PoI 8','PoI 9','PoI 10'},'FontSize',30) %x coordinate axis scale value
set(gca,'yticklabel',{'\beta=0.01','\beta=0.1','\beta=0.5'},'FontSize',30) %y coordinate axis scale value
zlim([0,1500]); %z coordinate axis scale value
hXLabel = xlabel('PoIs','Rotation',18,'Position',[5 6.5 5],'FontSize',50);
%hYLabel = ylabel('γ','Rotation',-40,'Position',[-1 2 0]);
hZLabel = zlabel('Times','Rotation',-90,'Position',[-2 0 1000],'FontSize',50);
set(gca,'XGrid', 'off', 'YGrid', 'off','ZGrid', 'on')
%hTitle = title('Service Frequency of PoIs \{\beta=10\}');
%set(hTitle, 'FontSize', 50, 'FontWeight' , 'bold')

figure(2)
axis([0 1 0 1]);
set(gca,'XTick',[0:0.2:1],'FontSize',25) %x axis range 0-1, interval 0.2
set(gca,'YTick',[0:0.1:1],'FontSize',25) %y axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('PoA');
xlabel('Reward Rate \beta','FontSize',35);
ylabel('Price of Anarchy (PoA)','FontSize',35);

plot(x,y1,'-db',x,y2,'-oc',x,y3,'-hg',x,y4,'-xr','linewidth',2,'MarkerSize',10); % linear, color, marker
legend('AVG Maximum Age of Incentive Strategy','AVG Total Age of Incentive Strategy','AVG Maximum Age of without Incentive','AVG Total Age of without Incentive','FontSize',20);   % Upper right corner mark
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axis([0 800 0 1]);
set(gca,'XTick',[0:100:800]) %x-axis range 0-800, interval 100
set(gca,'YTick',[0:0.1:1]) %Y-axis range 0-1, interval 0.1
axis square;
hold on;
% Add titles and tags
%title('');
xlabel('Number of randomly challenged data packets w','FontSize',15);
ylabel('Probability of detecting data loss or tampering P\{ Z≥1 \}','FontSize',15);

n=1;
barray =[0.01*n;0.04*n;0.09*n;0.008*n];
x=[];
y1=[];
y2=[];
y3=[];
y4=[];
sevices=800;
i =0;
while i <= sevices
    x = [x;i] ;
    j=1;
    while j <= 4
        if j==1
            y1= [y1;1-((n-barray(j))/n)^i];
        end
        if j==2
            y2= [y2;1-((n-barray(j))/n)^i];
        end
        if j==3
            y3= [y3;1-((n-barray(j))/n)^i];
        end
        if j==4
            y4= [y4;1-((n-barray(j))/n)^i];
        end
        j=j+1;
    end

    i=i+20;
end

plot(x,y1,'-d',x,y2,'-h',x,y3,'-x',x,y4,'-s','linewidth',4,'MarkerSize',8); % linear, color, marker
h=legend('b=0.01n','b=0.04n','b=0.09n','b=0.008n');   % Upper right corner mark
set(h,'FontName','Times New Roman','FontSize',15,'FontWeight','normal')
grid on
pbaspect([1.5 1 1])

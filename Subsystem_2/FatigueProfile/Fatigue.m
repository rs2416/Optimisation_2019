syms strokes

S = (1:1:500);
Integralforce = zeros(size(S)) ;

% Peak force fatigue reduction with respect to number of strokes
force = -3.*strokes + 500; % assuming initial force of arbitrary value (500 N)

% Determining fatigue reduction in a stroke depending on angle of exit
for strokes = 1:1:length(S)
    Integralforce(strokes)= int(force,[1 strokes]);
end
plot(Integralforce);

% Metamodel
x = linspace(1,500,500);
y = Integralforce;
p = polyfit(x,y,2);

f = polyval(p,x);
plot(x,y,'o',x,f,'-') 
legend('data','linear fit') 
title('Propulsive Force affected by Fatigue')
xlabel('Number of Strokes')
ylabel('Total Propulsive Force')

grid on;

% Place equation in upper left of graph.
xl = xlim;
yl = ylim;
xt = 0 * (xl(2)-xl(1)) + xl(1);
yt = 0.2 * (yl(2)-yl(1)) + yl(1);
caption = sprintf('y = (%.1f) x^2 + (%.1f) x + (%.1f)', p(1), p(2), p(3));
text(xt, yt, caption, 'FontSize', 16, 'Color', 'r', 'FontWeight', 'bold');






%Probabilities. q for x > 0. Else P(0,0) = .5
q = .5;
numOfTrials = 2000;
sim = zeros(1,numOfTrials);
for j = 1:numOfTrials
    X0 = 10;
    X = X0;
    numOfSteps = 1000;
    for n = 0 : numOfSteps
        
        
        %Step (2a). Sample state Y in S following the transition probabilities
        %q(x,y). So P(Y=y) = q(x,y)
        u = rand;
        Y = X;
        r = 1;
        %Check this!!!!!!!!
        if u < 0.5
            Y = X+1;
            r = 5/(X+1);
        else
            Y = X-1;
            r = X/5;
            
        end   
           
         
        
        
        %Step (2b). Accept or reject the jump.
        z = rand;
        %Don't need to include the q's because they cancel out.
        if r > 1
            r = 1;
        end
        
        if z < r
            X = Y;
        end
        %disp(X);
        
    end
    sim(j) = X;
end

%plot and compare to Poisson
figure
h=hist(sim, max(sim)+1);
h=h/sum(h);
pois=arrayfun(@(x)exp(-5)*5^x/factorial(x), 0:max(sim));
comparison=vertcat(h,pois)';
final=bar(0:max(sim),comparison);
grid on
l = cell(1,2);
l{1}='sim'; l{2}='Poisson';
legend(final,l);

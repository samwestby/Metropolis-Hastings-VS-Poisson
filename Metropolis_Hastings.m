% Metropolis-Hastings Algorithm approximating the Poisson distribution
% Sam Westby <swestby2@wisc.edu>

% We are assuming the Markov Chain is a symmetric random walk with 
% S = {0,...,infinity} and p(0,0) = 1/2

% The lamda of the Poisson distribution
lamda = 5;
numOfTrials = 2000;

% sim is a matrix that will hold the final position of X for every trial
sim = zeros(1,numOfTrials);
for j = 1:numOfTrials
    
    % The value of X at time 0
    X = 10;
    numOfSteps = 1000;
    
    for n = 0 : numOfSteps
               
        % Step (2a). Sample state Y in S following the transition probabilities
        % q(x,y). So P(Y=y) = q(x,y)
        u = rand;
        Y = X;
        r = 1;
        
        if u < 0.5
            Y = X+1;
            r = lamda/(X+1);
        else
            Y = X-1;
            r = X/lamda;
            
        end                  
        
        % Step (2b). Accept or reject the jump.
        z = rand;
        if r > 1
            r = 1;
        end
        
        if z < r
            X = Y;
        end
        
    end
    sim(j) = X;
end

% Plot sim and compare to Poisson
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

function error = somTrain(data, sigma, labels, sizeK)
display(sigma)
display(sizeK)

dim = 28*28; % dimension of the images
range = 255; % input range of the images ([0, 255])
[dy, dx]=size(data);

centers=rand(sizeK^2,dim)*range;

% build a neighborhood matrix
neighbor = reshape(1:sizeK^2,sizeK,sizeK);

% YOU HAVE TO SET A LEARNING RATE HERE:
eta = 0.01;

tmax=2000; 

iR = randperm(tmax);

counter = 0;
while(1)  
    temp = centers;
    for t=1:tmax
        i=iR(t);
        centers=som_step(centers,data(i,:),neighbor,eta,sigma);
    end
    counter = counter + 1;
    converge = norm(centers - temp)/norm(temp);
    display(counter)
    display(converge)
        
    if (converge < 0.005)
        break;
    end
 end;

%res = assigne(centers, data, labels, size(targetdigits,2))
assign = knnclassify(centers, data, labels, 5);
reshape(assign, sizeK, sizeK)'
error = errorRate(data, centers, assign, labels)

end


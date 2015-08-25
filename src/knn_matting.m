function output = knn_matting (input, trimap, lambda, level)

% [10;2] means 10 neighbors with default(level) spatial coherence and 
% 2 neighbors with weak spatial coherence.
nn = [10; 2];
[m,n,d] = size(input);

foreground = trimap > 0.99;
background = trimap < 0.01;
all_constraints = foreground + background;

% the first part of the feature vector is the rgb or other color information, 
% the second part is the spatial factor perturbed by a small amount,
% in the for loop below, the second part will be reduced really nonlocally
[a, b] = ind2sub([m n],1:m*n);
feature_vector = [ reshape(input,m*n,d)';[a;b]/sqrt(m*m+n*n)*level+rand(2,m*n)*1e-6];

now=0;
for i=1:size(nn,1)
    kdtree = vl_kdtreebuild(feature_vector);
    ind = vl_kdtreequery(kdtree, feature_vector,feature_vector,'NUMNEIGHBORS',nn(i),'MAXNUMCOMPARISONS',nn(i)*3);
    index1 = reshape(repmat(uint32(1:m*n),nn(i),1),[],1);
    index2 = reshape(ind,[],1);
    row(now+1:now+m*n*nn(i),:) = [min(index1, index2), max(index1, index2)];
    feature_vector(d+1:d+2,:) = feature_vector(d+1:d+2,:)/100;
    now = now+m*n*nn(i);
end

value = max(1-sum(abs(feature_vector(1:d+2,row(:,1))-feature_vector(1:d+2,row(:,2))))/(d+2),0);
A = sparse(double(row(:,1)), double(row(:,2)), value, m*n, m*n);
A = A + A';
D = spdiags(sum(A,2), 0, n*m, n*m);
L = D - A;
H = L +lambda*spdiags(all_constraints, 0, m*n, m*n);
iH = ichol(H);
x = pcg(H, lambda*foreground, [], 2000, iH, iH');

output = reshape(x,m,n);

end


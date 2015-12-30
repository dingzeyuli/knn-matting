clear all;
run('vlfeat-0.9.13/toolbox/vl_setup');
lambda=1;
level=0;
l=15;
load('dove_original.mat');
im=double(im)/255;
[m n d]=size(im);
nn=[3];
[a b]=ind2sub([m n],1:m*n);
feature=[reshape(im,m*n,d)';[a;b]/sqrt(m*m+n*n)*level+rand(2,m*n)*1e-6];
now=0;
for i=1:size(nn,1)
    ind=vl_kdtreequery(vl_kdtreebuild(feature),feature,feature,'NUMNEIGHBORS',nn(i),'MAXNUMCOMPARISONS',nn(i)*2);
    a=reshape(repmat(uint32(1:m*n),nn(i),1),[],1);
    b=reshape(ind,[],1);
    row(now+1:now+m*n*nn(i),:)=[min(a,b) max(a,b)];
    feature(d+1:d+2,:)=feature(d+1:d+2,:)/100;
    now=now+m*n*nn(i);
end
value=max(1-sum(abs(feature(1:d+2,row(:,1))-feature(1:d+2,row(:,2))))/(d+2),0);
A=sparse(double(row(:,1)),double(row(:,2)),value,m*n,m*n);
A=A+A';
D=spdiags(sum(A,2),0,n*m,n*m);
avg=zeros(m,n,1:3);
for i=1:3
    avg(:,:,i)=mean(im(:,:,i:3:d-3+i),3);
end
figure('name','Left click on each layer and press Enter to terminate(Press Space to seperate layers)'),imagesc(avg);
[x,y,BUTTON]=ginput;
imwrite(min(max(avg,0),1),'avg.png','png');
a=round(y);
b=round(x);
map=zeros(m*n,1);
num=size(a,1);
for i=1:num
    if BUTTON(i)==1
        [x y]=meshgrid(a(i)-l:a(i)+l,b(i)-l:b(i)+l);
        for j=0:2
            avg(sub2ind([m n],a(i)-l:a(i)+l,b(i)-l:b(i)+l)+j*m*n)=(j==0);
            avg(sub2ind([m n],a(i)-l:a(i)+l,b(i)+l:-1:b(i)-l)+j*m*n)=(j==0);
        end
        map(sub2ind([m n],x,y))=1;
    end
end
imagesc(avg);
imwrite(avg,'input.png','png');
tot=0;
alpha=zeros(n*m,num);
M=D-A+lambda*spdiags(map(:),0,m*n,m*n);
L=ichol(M);
i=1;
while i<=num
    figure('name','alpha matte');
    val=zeros(m*n,1);
    while i<=num&&BUTTON(i)==1
        [x y]=meshgrid(a(i)-l:a(i)+l,b(i)-l:b(i)+l);
        val(sub2ind([m n],x,y))=1;
        i=i+1;
    end
    i=i+1;
    tot=tot+1;
    alpha(:,tot)=pcg(M,lambda*val(:),1e-15,2000,L,L');
    imagesc(min(max(reshape(alpha(:,tot),m,n),0),1));
    imwrite(min(max(reshape(alpha(:,tot),m,n),0),1),sprintf('%02d.png',tot),'png');
end

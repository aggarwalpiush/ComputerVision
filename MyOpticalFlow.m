function [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%MYOPTICALFLOW calculates the optical flow
%   [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%   x, y are row vector contain the coordinates of the domain of the flow
%   vector field
%   vx, vy are matrices containing the flow vector components
%   The inputs are the current grayscale image Ic, the last grayscale
%   image Il and the side length N of the local area Q.


[height,width] = size(Il);
height_L = floor(height/N);
width_L = floor(width/N);
Imgl = imresize(Il,[height_L width_L]);
Imgc = imresize(Ic,[height_L width_L]);

[m,n] = size(Ic);
% areaC = floor(m/N,n/N);
x = zeros(height_L,1);
y = zeros(width_L,1);

% extracted the local areas in cell
localArea = mat2cell(Imgc, ones(1,height_L), ones(1,width_L));

% md points of the local areas
x(1,1) = floor(N/2);    
y(1,1) = floor(N/2); 
for j = 2:width_L
    x(j,1) = x(j-1,1)+N;    
end
for i = 2:height_L
    y(i,1) = y(i-1,1)+N;
end

vx = zeros(height_L,1);vy = zeros(width_L,1);

% x and y gradient
[Ilx, Ily] = imgradientxy(Imgl,'prewitt');
[Icx, Icy] = imgradientxy(Imgc,'prewitt');
localArea_xGrad = mat2cell(Icx,  ones(1,height_L),  ones(1,width_L));
localArea_yGrad = mat2cell(Icy,  ones(1,height_L),  ones(1,width_L));

%temporal gradient
I_temporal = double(Imgc) - double(Imgl);
localArea_temp = mat2cell(I_temporal, ones(1,height_L),  ones(1,width_L));
for i = 1:height_L
    for j = 1:width_L
       Ax = reshape(cell2mat(localArea_xGrad(i,j)),[],1);
       Ay = reshape(cell2mat(localArea_yGrad(i,j)),[],1); 
       A = horzcat(Ax,Ay);
%       disp(max(A));
%       disp(min(A));
       %disp(A)
       h = reshape(cell2mat(localArea_temp(i,j)),[],1); 
      % h = -I_temp;
%              disp(max(h));
%       disp(min(h));

       %       disp(size(h));
       disp(pinv(A))
       vel = pinv(A)*h;
       %disp(vel)
       vx(i,1) = double(vel(2,1));
       vy(j,1) = double(vel(1,1));
    end
end

end
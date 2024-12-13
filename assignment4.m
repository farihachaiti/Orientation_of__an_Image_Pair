function mainfunction
  clc
  
  #reading images 
  printf("Reading images\n")
  
  A = imread('a.jpg');  
  
  B = imread("b.jpg"); 
  
  
  #Showing image and picking 6 image points
  printf("Showing image a and picking 8 image points\n")
  
 

 [Ax1,Ax2,Ax3,Ax4,Ax5,Ax6,Ax7,Ax8,Ay1,Ay2,Ay3,Ay4,Ay5,Ay6,Ay7,Ay8]=take_points(A)
 
   #Showing image and picking 6 image points
  printf("Showing image b and picking 8 image points\n")
  
 

 [Bx1,Bx2,Bx3,Bx4,Bx5,Bx6,Bx7,Bx8,By1,By2,By3,By4,By5,By6,By7,By8]=take_points(B)
 
 
 
   #Measuring points
  printf("Measuring points\n")
 
  [x1y1_final,x2y2_final,x3y3_final,x4y4_final,x5y5_final,x6y6_final,x7y7_final,x8y8_final,T1] = measure_points(Ax1,Ay1,Ax2,Ay2,Ax3,Ay3,Ax4,Ay4,Ax5,Ay5,Ax6,Ay6,Ax7,Ay7, Ax8,Ay8)
  [x1y1_prime_final,x2y2_prime_final,x3y3_prime_final,x4y4_prime_final,x5y5_prime_final,x6y6_prime_final,x7y7_prime_final,x8y8_prime_final,T2] = measure_points(Bx1,By1,Bx2,By2,Bx3,By3,Bx4,By4,Bx5,By5,Bx6,By6,Bx7,By7,Bx8,By8)



  #Generating Design Matrix
  printf("Generating Design Matrix\n")
 
 A1 = design_matrix(x1y1_final,x1y1_prime_final)
 A2 = design_matrix(x2y2_final,x2y2_prime_final)
 A3 = design_matrix(x3y3_final,x3y3_prime_final)
 A4 = design_matrix(x4y4_final,x4y4_prime_final)
 A5 = design_matrix(x5y5_final,x5y5_prime_final)
 A6 = design_matrix(x6y6_final,x6y6_prime_final)
 A7 = design_matrix(x7y7_final,x7y7_prime_final)
 A8 = design_matrix(x8y8_final,x8y8_prime_final)
 
   #Calculating Fundamental Matrix F
  printf("Calculating Fundamental Matrix F\n")
 
 F = calculate_fundamental_matrix(A1,A2,A3,A4,A5,A6,A7,A8,T1,T2);
 
  #Forcing Singularity Constraint on F
  printf("Forcing Singularity Constraint on F\n")
 
 F = force_rank2(F)
 
 
    #Determining Lines
  printf("Determining Lines\n")
 
 l1 = determine_line(transpose(F),Bx1,By1)
 l1_prime = determine_line(F,Ax1,Ay1)
 l2 = determine_line(transpose(F),Bx2,By2)
 l2_prime = determine_line(F,Ax2,Ay2)
 l3 = determine_line(transpose(F),Bx3,By3)
 l3_prime = determine_line(F,Ax3,Ay3)
 l4 = determine_line(transpose(F),Bx4,By4)
 l4_prime = determine_line(F,Ax4,Ay4)
 l5 = determine_line(transpose(F),Bx5,By5)
 l5_prime = determine_line(F,Ax5,Ay5)
 l6 = determine_line(transpose(F),Bx6,By6)
 l6_prime = determine_line(F,Ax6,Ay6)
 l7 = determine_line(transpose(F),Bx7,By7)
 l7_prime = determine_line(F,Ax7,Ay7)
 l8 = determine_line(transpose(F),Bx8,By8)
 l8_prime = determine_line(F,Ax8,Ay8)


 
     #Drawing Lines
  printf("Drawing Lines\n")
 
 
 figure,imshow(A),hold on
 hline(l1)
 hline(l2)
 hline(l3)
 hline(l4)
 hline(l5)
 hline(l6)
 hline(l7)
 hline(l8)
 
  figure,imshow(B),hold on
 hline(l1_prime)
 hline(l2_prime)
 hline(l3_prime)
 hline(l4_prime)
 hline(l5_prime)
 hline(l6_prime)
 hline(l7_prime)
 hline(l8_prime)
 


 
  #Calculating Geometric Image Error
 printf("Calculating Geometric Image Error\n")
  
 d1 = symmetric_epipolar_distance(Ax1,Ay1,Bx1,By1,l1,l1_prime)
 d2 = symmetric_epipolar_distance(Ax2,Ay2,Bx2,By2,l2,l2_prime)
 d3 = symmetric_epipolar_distance(Ax3,Ay3,Bx3,By3,l3,l3_prime)
 d4 = symmetric_epipolar_distance(Ax4,Ay4,Bx4,By4,l4,l4_prime)
 d5 = symmetric_epipolar_distance(Ax5,Ay5,Bx5,By5,l5,l5_prime)
 d6 = symmetric_epipolar_distance(Ax6,Ay6,Bx6,By6,l6,l6_prime)
 d7 = symmetric_epipolar_distance(Ax7,Ay7,Bx7,By7,l7,l7_prime)
 d8 = symmetric_epipolar_distance(Ax8,Ay8,Bx8,By8,l8,l8_prime)
 
 geometric_image_error = d1+d2+d3+d4+d5+d6+d7+d8
 
 endfunction

 
 
 
  function [x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8]=take_points(A)
    imshow(A)
    
 [xinput,yinput,mouse_button] = ginput(1)
 x1 = xinput
 y1 = yinput
 hold on; plot(x1,y1,'r+'); hold off;
 [xinput,yinput,mouse_button] = ginput(1)
 x2 = xinput
 y2 = yinput
 hold on; plot(x2,y2,'r+'); hold off;
 [xinput,yinput,mouse_button] = ginput(1)
 x3 = xinput
 y3 = yinput
 hold on; plot(x3,y3,'r+'); hold off;
 [xinput,yinput,mouse_button] = ginput(1)
 x4 = xinput
 y4 = yinput
 hold on; plot(x4,y4,'r+'); hold off; 
  [xinput,yinput,mouse_button] = ginput(1)
 x5 = xinput
 y5 = yinput
 hold on; plot(x5,y5,'r+'); hold off; 
  [xinput,yinput,mouse_button] = ginput(1)
 x6 = xinput
 y6 = yinput
 hold on; plot(x6,y6,'r+'); hold off; 
  [xinput,yinput,mouse_button] = ginput(1)
 x7 = xinput
 y7 = yinput 
 hold on; plot(x7,y7,'r+'); hold off;
  [xinput,yinput,mouse_button] = ginput(1)
 x8 = xinput
 y8 = yinput 
 hold on; plot(x8,y8,'r+'); hold off;
 close(gcf)
    
  endfunction
  
    function [X1Y1_conditioned,X2Y2_conditioned,X3Y3_conditioned,X4Y4_conditioned,X5Y5_conditioned,X6Y6_conditioned,X7Y7_conditioned,X8Y8_conditioned,T]=measure_points(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8)
  
   #Conditioning: Translation
  printf("Conditioning: Translation\n")
  
  
  X1Y1 = [x1; y1; 1]
  X2Y2 = [x2; y2; 1]
  X3Y3 = [x3; y3; 1]
  X4Y4 = [x4; y4; 1]
  X5Y5 = [x5; y5; 1]
  X6Y6 = [x6; y6; 1]
  X7Y7 = [x7; y7; 1]
  X8Y8 = [x8; y8; 1]
  XYmat = [abs(X1Y1) abs(X2Y2) abs(X3Y3) abs(X4Y4) abs(X5Y5) abs(X6Y6) abs(X7Y7) abs(X8Y8)]
  
  t = mean(XYmat,2)
  t(1,1)
  t(2,1)
  t(3,1)
  
   #Conditioning: Scalling
  printf("Conditioning: Scalling\n")
  
 X1final = x1 - t(1,1)
 Y1final = y1 - t(2,1)
 X2final = x2 - t(1,1)
 Y2final = y2 - t(2,1)
 X3final = x3 - t(1,1)
 Y3final = y3 - t(2,1)
 X4final = x4 - t(1,1)
 Y4final = y4 - t(2,1)
 X5final = x5 - t(1,1)
 Y5final = y5 - t(2,1)
 X6final = x6 - t(1,1)
 Y6final = y6 - t(2,1)
 X7final = x7 - t(1,1)
 Y7final = y7 - t(2,1)
 X8final = x8 - t(1,1)
 Y8final = y8 - t(2,1)
  
 X1Y1final = [X1final; Y1final; 1]
 X2Y2final = [X2final; Y2final; 1]
 X3Y3final = [X3final; Y3final; 1]
 X4Y4final = [X4final; Y4final; 1]
 X5Y5final = [X5final; Y5final; 1]
 X6Y6final = [X6final; Y6final; 1]
 X7Y7final = [X7final; Y7final; 1]
 X8Y8final = [X8final; Y8final; 1]
 
 XYmat2 = [abs(X1Y1final) abs(X2Y2final) abs(X3Y3final) abs(X4Y4final) abs(X5Y5final) abs(X6Y6final) abs(X7Y7final) abs(X8Y8final)]
 
 s = mean(XYmat2,2)
 s(1,1)
 s(2,1)
 s(3,1)
 
  #Coordinate Transformation
  printf("Coordinate Transformation\n")
 
 
 T = [1/s(1,1) 0 0; 0 1/s(2,1) 0; 0 0 1]*[ 1 0 -t(1,1); 0 1 -t(2,1); 0 0 1] 
 
  #Conditioned Coordinates
  printf("Conditioned Coordinates\n")
 
 X1Y1_conditioned = T*X1Y1
 X2Y2_conditioned = T*X2Y2
 X3Y3_conditioned = T*X3Y3
 X4Y4_conditioned = T*X4Y4
 X5Y5_conditioned = T*X5Y5
 X6Y6_conditioned = T*X6Y6
 X7Y7_conditioned = T*X7Y7
 X8Y8_conditioned = T*X8Y8

 
endfunction



function y=design_matrix(xy,xy_prime)
   y = [xy(1,1)*xy_prime(1,1)  xy(2,1)*xy_prime(1,1) xy_prime(1,1) xy(1,1)*xy_prime(2,1) xy(2,1)*xy_prime(2,1) xy_prime(2,1) xy(1,1) xy(2,1) 1]
  
endfunction


 function F=calculate_fundamental_matrix(A1,A2,A3,A4,A5,A6,A7,A8,T1,T2)
    
 
  #Design Matrix A1
  printf("Design Matrix A\n")
 
 A = [A1; A2; A3; A4; A5; A6; A7; A8]
 
  #Singular Value Decompisition
  printf("Singular Value Decompisition\n")
 
 [U,D,V] = svd(A)

 F_prime = [V(:,end)]
 
  #Reshaping to get the Fundamental Matrix
  printf("Reshaping to get the Fundamental Matrix\n")
 
 F2 = reshape(F_prime,3,3)'

   #Reverse Conditioning
  printf("Reverse Conditioning\n")
 
 F = transpose(T2)*F2*T1
 
endfunction


function F = force_rank2(F) % Force singularity constraint det(F)=0
% ==============
[U, D, V] = svd(F); % Singular value decomposition
D(3, 3) = 0; % Smallest singular value must be 0
F = U * D * V';
endfunction



function l=determine_line(F,x,y)
  
  XY = [x;y;1]
  l = F*XY
 endfunction
  

 
 function d=symmetric_epipolar_distance(x,y,xprime,yprime,l,l_prime)
   XY = [x;y;1]
   XYprime = [xprime;yprime;1]
   
   d = ((transpose(XYprime)*l_prime).^2)/(l_prime(1,1).^2+l_prime(2,1).^2+l(1,1).^2+l(2,1).^2)
   
   
 endfunction

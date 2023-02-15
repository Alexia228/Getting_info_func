function [Ec_positive , Ec_negative, loop_span] = getting_info(X1)

[~,I] = min(abs(X1.P.p));
[~,I1] = min(abs(X1.P.n));


for k = I-3 : I+3
     Part_of_loop(1,k-I+4) = (X1.P.p(k)); %Часть точек петли
     grid_x1(k-I+4) = [X1.E.p(k)];        %Сетка для построения апроксимации
end
 
for k = I1-3 : I1+3
     Part_of_loop1(1,k-I1+4) = (X1.P.n(k)); % То же для отрицательной ветки
     grid2_x1(k-I1+4) = -[X1.E.n(k)];
end
 
 fitting_line = polyfit(grid_x1,Part_of_loop,1);     %Фитинг 1
 fitting_line1 = polyfit(grid2_x1,-Part_of_loop1,1); %Фитинг 2

 Ec_positive = -fitting_line(2)/fitting_line(1);  %Нахождение нуля 1
 Ec_negative = fitting_line1(2)/fitting_line1(1); %Нахождение нуля 2
 
 Max_P_posotive = prctile(X1.P.p,99);
 Max_P_negative = prctile(X1.P.n,1);
  
 loop_span = Max_P_posotive - Max_P_negative;
  
 grid on
 hold on
  
 plot(grid_x1, Part_of_loop,'o')
 plot(-grid2_x1,Part_of_loop1,'o')
  
 grid_x2 = 0 : 18;
 y1 = fitting_line(1)*grid_x2+fitting_line(2);
 y2 = fitting_line1(1)*grid_x2+fitting_line1(2);
 
 plot(Ec_negative,0, 'o');
 plot(Ec_positive,0, 'o');
 plot(grid_x2,y2);
 
 
end

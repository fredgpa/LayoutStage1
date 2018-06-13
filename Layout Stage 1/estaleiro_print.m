function estaleiro_print(population, problem, ~, ~)
sol = population.best;
%{
  subplot(2,1,1);
  plot(population.tabela_valores);
  population.best_fx
  drawnow;
%}
table = [];
label = [];
for i = 1:problem.height
  for j = 1:problem.width
    table(i, j) = sol((20 - (5 * (i - 1))) - (problem.width - j));
  end
end
im = ones(400, 500);
for i =1:399
im(i, 96:100) = 0;
im(i, 196:200) = 0;
im(i, 296:300) = 0;
im(i, 396:400) = 0;
end
for i =1:499
im(98:101, i) = 0;
im(198:201, i) = 0;
im(298:301, i) = 0;
end
imshow(im)
k = 1;
for i = 1:problem.width
  for j = 1:problem.height
    label(k) = text((i - 1)*100 + 35, (j - 1)*100 + 45, num2str(table(j, i)));
  end
end

end

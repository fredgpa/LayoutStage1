function [ fx, solution, problem ] = estaleiro_evaluate( solution, problem, ~)
  fx = 0;
  penalty_position = [];
  penalty_flow = 1860;
  %%calculando matriz de posições
  k=1;
    for i = 1:problem.height
      for j = 1:problem.width
%{
        if solution(k) == problem.origin
            penalty_position(1) = i;
            penalty_position(2) = j;
        end
%}
        pos(i, j) = solution(k);
        k = k + 1;
      end
    end
problem.distance = zeros(problem.n_var);
  %%calculando matriz de distância
  for i = 1:problem.height
    for j = 1:problem.width
        for i2 = 1:problem.height
          for j2 = 1:problem.width
              if i ~= i2 || j ~= j2
                problem.distance(pos(i, j), pos(i2, j2)) = sqrt((i2-i)^2 + (j2-j)^2);
              end
          end
        end
    end
  end

  %penalty_distance = sqrt((4 - penalty_position(1))^2 + (1 - penalty_position(2))^2)
  penalty_distance = 0;
  for i = 1:problem.n_var
    for j = 1:problem.n_var
      fx = fx + problem.cost(i, j)*problem.materials(i, j)*problem.distance(i, j);
    end
  end
  fx
  %fx = fx + penalty_distance*penalty_flow
end

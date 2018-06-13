function x = estaleiro_mutation_bitflop(x, problem,~, population)
  pos = [];
  pos(1) = randi(length(x));
  pos(2) = randi(length(x));
%
  if not(isempty(problem.fixedPos))
    ok = false;
    while not(ok)
      ok = true;
      for k = 1:length(problem.fixedPos)
        if problem.fixedPos(k).dept == x(pos(1))
          pos(1) = randi(length(x));
          ok = false;
        elseif problem.fixedPos(k).dept == x(pos(2))
          pos(2) = randi(length(x));
          ok = false;
        end
      end
    end
  end
%
  aux = x(pos(1));
  x(pos(1)) = x(pos(2));
  x(pos(2)) = aux;
end

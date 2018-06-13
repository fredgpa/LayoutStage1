function child = teste(parent1, parent2,problem,~,~)
  n_parents = length(parent1);
  child = zeros(1, n_parents);
  l = randi(n_parents) - 1;
  start = randi(n_parents - l);
  child(start:(start + l)) = parent1(start:(start + l));
  for i = start:(start + l)
    if ~ismember(parent2(i), child)
      value = parent1(i);
      ok = false;
      while ~ok
        for j = 1:length(parent2)
          if parent2(j) == value
            if j >= start && j <= (start + l)
              value = parent1(j);
            else
              child(j) = parent2(i);
              ok = true;
            end
          end
        end
      end
  end
  for i = 1:length(parent2)
    for j = 1:length(child)
      if ~ismember(parent2(i), child) && child(j) == 0
        child(j) = parent2(i);
      end
    end
  end
end

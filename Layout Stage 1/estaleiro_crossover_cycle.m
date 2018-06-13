function child = estaleiro_crossover_cycle(parents,problem, ~, population)
  n_parents = length(parents);
  randparents = randperm(n_parents);
  parent1 = population.ind{parents(randparents(1))};
  parent2 = population.ind{parents(randparents(2))};
  child = zeros(1,length(parent1));
  pos_parent1 = randi(n_parents);
  aux = []; first = [];
  first = parent1(pos_parent1);
    while true
      child(pos_parent1) = parent1(pos_parent1);
      if parent1(pos_parent1) == first
        break;
      end
      for i=1:length(parent1)
        if parent1(i) == parent2(pos_parent1);
          pos_parent1 = i;
        end
      end
    end
    for i=1:length(child)
      parent2(parent2 == child(i)) = [];
    end
    for i=1:length(child)
      if child(i) == 0
        child(i) = parent2(1);
        parent2(1) = [];
      end
    end
end

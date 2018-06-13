function [ solution ] = estaleiro_generate_random( problem, ~ )
  array = randperm(problem.n_var, problem.n_var);
  it = 0;
  align_departments = [];
  solution = zeros(1, problem.n_var);

  %retira todos que tem constraint
  if not(isempty(problem.constraint))
    for k=1:length(problem.constraint)
      array(array == problem.constraint(k, 1)) = [];
      array(array == problem.constraint(k, 2)) = [];
    end
  end

  %retira todos que tem posição fixa
  if not(isempty(problem.fixedPos))
    for k = 1:length(problem.fixedPos)
      array(array == problem.fixedPos(k).dept) = [];
      position = ((problem.fixedPos(k).i - 1) * problem.width) + problem.fixedPos(k).j;
      solution(position) = problem.fixedPos(k).dept;
    end
  end

  if not(isempty(problem.constraint))
    for k=1:length(problem.constraint)
      if isempty(align_departments)
        align_departments = [align_departments problem.constraint(k, 1)];
        align_departments = [align_departments problem.constraint(k, 2)];
      else
        if not(ismember(problem.constraint(k, 1), align_departments))
          align_departments = [align_departments problem.constraint(k, 1)];
        end
        if not(ismember(problem.constraint(k, 2), align_departments))
          align_departments = [align_departments problem.constraint(k, 2)];
        end
      end
    end
    align_departments
    [success, solution] = generate(align_departments, problem, solution);
  end
array
solution
  for i = 1:length(solution)
    if solution(i) == 0
      solution(i) = array(1);
      array(1) = [];
    end
  end
end

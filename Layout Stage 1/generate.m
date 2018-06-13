function [ success, solution ] = generate(departments, problem, solution)
backup = solution;
position = [];
alignment = [];

  if isempty(departments)
    success = true;
  else
    department = departments(1)
    departments(1) = [];
    if ismember(department, solution)
        department = departments(1);
        departments(1) = [];
    end
    solution
    %olha em todas as restrições e verifica se algum dos departamentos que tem relação com o escolhido já estão na solução
    for i = 1:length(problem.constraint)
      if problem.constraint(i, 1) == department
        if ismember(problem.constraint(i, 2), solution)
          for j = 1:length(solution)
            if solution(j) == problem.constraint(i, 2)
              position = [position j];
              if problem.constraint(i, 3) == 1
                alignment = [alignment 1];
              else
                alignment = [alignment 0]
              end
            end
          end
        end
      elseif problem.constraint(i, 2) == department
        if ismember(problem.constraint(i, 1), solution)
          for j = 1:length(solution)
            if solution(j) == problem.constraint(i, 1)
              position = [position j];
              if problem.constraint(i, 3) == 1
                alignment = [alignment 1];
              else
                alignment = [alignment 0]
              end
            end
          end
        end
      end
    end
    position
    if ~isempty(position)
      new_pos = [];
      temp_pos = [];
      error = false;
      for i = 1:length(position)
        if ~error
          aux_pos = [];
          if alignment(i) == 1
            if mod(position(i)-1, problem.width) ~= 0
              aux_pos = [aux_pos [position(i)-1]];
            end
            if position(i) > problem.width
              aux_pos = [aux_pos [position(i)-problem.width]];
            end
            if mod(position(i), problem.width) ~= 0
             aux_pos = [aux_pos [position(i)+1]];
            end
            if position(i) <= (length(solution) - problem.width)
              aux_pos = [aux_pos [position(i)+problem.width]];
            end
          else
            if (position(i) > problem.width) && (mod(position(i)-1, problem.width) ~= 0)
              aux_pos = [aux_pos [position(i)-problem.width-1]];
            end
            if (position(i) > problem.width) && (mod(position(i), problem.width) ~= 0)
              aux_pos = [aux_pos [position(i)-problem.width+1]];
            end
            if position(i) <= (length(solution) - problem.width)
              aux_pos = [aux_pos [position(i)+problem.width]];
            end
            if (position(i) <= (length(solution) - problem.width)) && (mod(position(i)-1, problem.width) ~= 0)
              aux_pos = [aux_pos [position(i)+problem.width-1]];
            end
          end
        end
        aux_pos
        if isempty(aux_pos)
          error = true;
        else
          if isempty(temp_pos)
            new_pos = aux_pos;
          else
            new_pos = [];
            for i = 1:length(aux_pos)
              new_pos = [new_pos temp_pos(temp_pos == aux_pos(i))];
            end
          end
        end
        temp_pos = new_pos;
      end
      new_pos
      [ok, solution, new_pos] =constraint_calc(department,  new_pos, solution);
    else
      for i=1:problem.n_var
          new_pos(i) = i;
      end
      new_pos
      [ok, solution, new_pos] =constraint_calc(department,  new_pos, solution);
      new_pos
    end
    if ok
      [success, solution] = generate(departments, problem, solution);
      department
      new_pos
      while ~success && not(isempty(new_pos))
        solution = backup;
        [ok, solution, new_pos] =constraint_calc(department,  new_pos, solution);
        if ok
          [success, solution] = generate(departments, problem, solution);
        end
      end
      if ~success
        solution = backup;
      end
    else
      success = false;
    end
  end
end

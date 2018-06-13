function [ problem ] = estaleiro_initialize( costs, materials )

  problem.name = 'estaleiro';
  problem.minimization = true;

  problem.generation_method = 'random';
  problem.mutation_method = 'bitflop';
  problem.crossover_method1 = 'cycle';
  problem.crossover_method2 = 'PMX';

  %%Definindo a instancia do problema
  problem.n_var = input('Number of departments: ');

  problem.cost = costs;
  sz = size(problem.cost);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Costs','modal')
    return;
  end

  problem.materials = materials;
  sz = size(problem.materials);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Materials','modal')
    return;
  end

  problem.height = input('Shipyard Height: ');
  problem.width = input('Shipyard Width: ');
  if problem.width * problem.height ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Height/Width','modal')
    return;
  end

  problem.fixedPos = [];
  ans = input('Any departments with fixed positions? (y/n)', 's');
  ans = upper(ans);
  if ans == 'Y'
    n = input('How many departments? ');
    for i = 1:n
      problem.fixedPos(i).dept = input('Department number: ');
      x = input('Position: ');
      problem.fixedPos(i).i = ceil(x/problem.width);
      problem.fixedPos(i).j = (x - (problem.fixedPos(i).i - 1) * problem.width);
    end
  end

  problem.constraint = [];
  ans = input('Any constraints between departments? (y/n)', 's');
  ans = upper(ans);
  if ans == 'Y'
    n = input('How many departments have constraints? ');
    for i = 1:n
      problem.constraint(i, 1) = input('First department number: ');
      problem.constraint(i, 2) = input('Second department number: ');

      ans = input('Must the departments be aligned? (y/n)', 's');
      if upper(ans) == 'Y'
        problem.constraint(i, 3) = true;
      else
        problem.constraint(i, 3) = false;
      end
    end
  end
end

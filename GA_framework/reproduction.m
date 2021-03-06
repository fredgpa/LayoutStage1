function [ population ] = reproduction( settings, population, problem, parents, f )
%REPRODUCAO Faz cruzamento e mutacao para gerar novos indiv�duos na
%populacao

if ~settings.reinitialize
    % For each set of parents, generates a child
    for i=1:settings.n_ind
        r = ((population.cp(parents(i,:)) + settings.crossover_delta) - (population.cp(parents(i,:)) - settings.crossover_delta)).*rand(1000,1) + (population.cp(parents(i,:)) - settings.crossover_delta);
        crossover_prob = randi(length(r));
        % Crossover between the parents if the crossover probability happens
        if (rand()<max(r(crossover_prob)))
            if settings.crossover_method == 1
              population.ind{i+settings.n_ind} = f.crossover1(parents(i,:),problem,settings,population);
            else
              population.ind{i+settings.n_ind} = f.crossover2(parents(i,:),problem,settings,population);
            end
            population.cp(i+settings.n_ind) = mean(population.cp(parents(i,:)));
            population.mp(i+settings.n_ind) = mean(population.mp(parents(i,:)));
        else
            % otherwise, the child is a copy of a parent
            parent = randi(size(parents,2));
            population.ind{i+settings.n_ind} = population.ind{parent};
            population.mp(i+settings.n_ind) = population.mp(parent);
            population.cp(i+settings.n_ind) = population.cp(parent);
        end

        % Causes mutation if the mutation probability happens
        if (rand()<population.mp(i+settings.n_ind))
            population.ind{i+settings.n_ind} = f.mutation(population.ind{i+settings.n_ind},problem,settings,population);
        end
    end
else
    % If the reinitialization is requested, the reinitialize button is off
    % If the reinitialize button is off, it means we will only reinitialize
    % the population with new random children instead

    % for each child
    for i=1:settings.n_ind
        % Generates the number of individuals defined by the settings
        population.ind{i+settings.n_ind} = f.initialize_individual(problem,settings);
    end

    population.cp = settings.cp*ones(1,settings.n_ind*2);
    population.mp = settings.mp*ones(1,settings.n_ind*2);

end

end

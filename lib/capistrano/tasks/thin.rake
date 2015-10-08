# encoding: UTF-8

namespace :thin do
  desc 'Restart thin server'
  task :restart do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          fetch(:thin_config_paths).each do |path|
            execute :bundle, "exec thin restart -C #{path}"
          end
        end
      end
    end
  end

  desc 'Stop thin server'
  task :stop do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          fetch(:thin_config_paths).each do |path|
            execute :bundle, "exec thin stop -C #{path}"
          end
        end
      end
    end
  end

  desc 'Start thin server'
  task :start do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          fetch(:thin_config_paths).each do |path|
            execute :bundle, "exec thin start -C #{path}"
          end
        end
      end
    end
  end
end

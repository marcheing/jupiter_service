namespace :setup do
  task :run_setup do
    on roles(:web) do
      %w(parser application).each do |config|
        execute "cd #{release_path} && cp -nv config/#{config}.yml.sample config/#{config}.yml"
      end
    end
  end
end

after :deploy, 'setup:run_setup'

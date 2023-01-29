Specinfra::Command::Astralinux = Class.new
Specinfra::Command::Astralinux::Base = Class.new(Specinfra::Command::Debian::Base)
Specinfra::Command::Astralinux::Base::Ppa = Class.new(Specinfra::Command::Debian::Base::Ppa)
Specinfra::Command::Astralinux::Base::Service = Class.new(Specinfra::Command::Debian::Base::Service)

user_ingipro = 'ingipro'
env_ingipro = {
  RAILS_ENV: 'production',
  NODE_ENV: 'production',
  RAILS_SERVE_STATIC_FILES: true,
  APP_HOST: 'dev-trophy.ingipro.ml',
  RAILS_LOG_TO_STDOUT: true,
  RAILS_MASTER_KEY: ENV['RAILS_MASTER_KEY'],
  REDIS_URL: 'redis://127.0.0.1:6379',
  EMAIL_FROM: 'admin@ingipro.com',
  RACK_MULTIPART_PART_LIMIT: 1024,
  RACK_MULTIPART_LIMIT: 1024,
  RAILS_MAX_THREADS: 10
}

local_ruby_block 'purge tmp' do
  block do
    system 'rm -r tmp/*'
    system 'rm -r log/*.log'
  end
end

directory '/ingipro' do
  owner user_ingipro
  group user_ingipro
end

directory '/ingipro/dev-trophy' do
  owner user_ingipro
  group user_ingipro
end

service 'dev-trophy' do
  action :stop
  provider :systemd
end

remote_directory '/ingipro/dev-trophy' do
  source '../../dev-trophy'
  owner user_ingipro
  group user_ingipro
end

local_ruby_block 'purge deploy' do
  block do
    run_command 'rm -r /ingipro/dev-trophy/deploy'
  end
end

local_ruby_block 'prepare rails' do
  block do
    env = env_ingipro.collect { |k, v| "#{k}=\"#{v}\"" }.join(' ')
    run_command <<~BUNDLE
      cd /ingipro/dev-trophy
      #{env} bundle install
    BUNDLE
  end
end

local_ruby_block 'prepare rails' do
  user user_ingipro
  block do
    env = env_ingipro.collect { |k, v| "#{k}=\"#{v}\"" }.join(' ')
    run_command <<~PREP
      cd /ingipro/dev-trophy
      #{env} bin/rails db:migrate
      #{env} bin/rails assets:precompile
      mv /ingipro/dev-trophy/db/dev-trophy-development.sqlite3 /ingipro/dev-trophy/db/dev-trophy-production.sqlite3
    PREP
  end
end

template '/etc/systemd/system/dev-trophy.service' do
  source 'dev-trophy.service.erb'
  variables(env: env_ingipro, user: user_ingipro)
end

template '/etc/systemd/system/sidekiq.service' do
  source 'sidekiq.service.erb'
  variables(env: env_ingipro, user: user_ingipro)
end

template '/etc/nginx/conf.d/dev-trophy.conf' do
  mode '640'
  source 'dev-trophy.conf.erb'
end

service 'dev-trophy' do
  action [:reload, :enable, :start]
  provider :systemd
end

service 'nginx' do
  action :restart
  provider :systemd
end

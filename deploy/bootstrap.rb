require 'bundler'

Specinfra::Command::Astralinux = Class.new
Specinfra::Command::Astralinux::Base = Class.new(Specinfra::Command::Debian::Base)
Specinfra::Command::Astralinux::Base::Ppa = Class.new(Specinfra::Command::Debian::Base::Ppa)
Specinfra::Command::Astralinux::Base::Service = Class.new(Specinfra::Command::Debian::Base::Service)

user_ingipro = 'ingipro'

# пользователь ingipro
user user_ingipro do
  create_home true
end

directory "/home/#{user_ingipro}/.ssh" do
  owner user_ingipro
  group user_ingipro
  mode '700'
end

remote_file "/home/#{user_ingipro}/.ssh/authorized_keys" do
  mode '600'
  owner user_ingipro
  group user_ingipro
  source 'authorized_keys'
end

directory "/ingipro/data" do
  owner user_ingipro
  group user_ingipro
end

file '/ingipro/data/forms-production.sqlite3' do
  owner user_ingipro
  group user_ingipro
end

# астровые репозитории
file '/etc/apt/sources.list' do
  action :create
  not_if 'stat /etc/apt/sources.list'
end

file '/etc/apt/sources.list' do
  action :edit
  block do |content|
    [
      'deb http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-main/     1.7_x86-64 main contrib non-free',
      'deb http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-update/   1.7_x86-64 main contrib non-free',
      'deb http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-base/     1.7_x86-64 main contrib non-free',
      'deb http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/ 1.7_x86-64 main contrib non-free',
      'deb http://ftp.ru.debian.org/debian/ buster main contrib non-free'
    ].each do |line|
      content << "#{line}\n" unless content.include? line
    end
  end
end

local_ruby_block 'keyring' do
  block do
    run_command <<~KEYRING
      apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 605C66F00D6C9793 DCC9EFBF77E11517 0E98404D386FA1D9 648ACFD622F3D138
      apt-get update
      DEBIAN_FRONTEND="noninteractive" apt-get install -y debian-archive-keyring dirmngr
      apt-get update
    KEYRING
  end
end

# руби
[
  'git',
  'build-essential',
  'libssl-dev',
  'zlib1g-dev',
  'libssl-dev'
].each do |pkg|
  package pkg do
    not_if 'ruby -v'
    action :install
  end
end

directory '/tmp/ruby-build' do
  not_if 'ruby -v'
  user user_ingipro
end

git 'ruby-build' do
  not_if 'ruby -v'
  destination '/tmp/ruby-build'
  repository 'https://github.com/rbenv/ruby-build.git'
end

local_ruby_block 'ruby-build' do
  not_if 'ruby -v'
  block do
    ruby_version = Bundler::LockfileParser.new(Bundler.read_file('Gemfile.lock')).ruby_version.match(/[\d.]+/)
    run_command <<~BUILD
      cd /tmp/ruby-build
      PREFIX=/usr ./install.sh
      ruby-build #{ruby_version} /usr
      ruby --version
    BUILD
  end
end

# nginx
[
  'nginx',
].each do |pkg|
  package pkg do
    action :install
  end
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  variables(user: user_ingipro)
end

directory "/etc/nginx/ssl" do
end

remote_file '/etc/nginx/ssl/ingipro.ml.crt' do
  source 'ingipro.ml.crt'
end

remote_file '/etc/nginx/ssl/ingipro.ml.key' do
  source 'ingipro.ml.key'
end

service 'nginx' do
  action [:reload, :enable, :start]
  provider :systemd
end

# redis
[
  'redis',
].each do |pkg|
  package pkg do
    action :install
  end
end

service 'redis' do
  action [:start, :enable]
  provider :systemd
end

# selenium

[
  'firefox',
].each do |pkg|
  package pkg do
    action :install
  end
end

[
  'xvfb',
].each do |pkg|
  package pkg do
    action :install
  end
end


#local_ruby_block 'selenium-build' do
#  block do
#    run_command <<~BUILD
#    sudo Xvfb :5 -ac
#    export DISPLAY=:5
#    firefox
#    BUILD
#  end
#end

#[
#  'chromium-chromedriver',
#].each do |pkg|
#  package pkg do
#    action :install
#  end
#end

#file '/usr/bin' do
#  owner user_ingipro
#  group user_ingipro
#end

#file '/usr/bin/chromium' do
#  owner user_ingipro
#  group user_ingipro
#end

#[
#  'google-chrome-stable',
#].each do |pkg|
#  package pkg do
#    action :install
#  end
#end

Specinfra::Command::Astralinux = Class.new
Specinfra::Command::Astralinux::Base = Class.new(Specinfra::Command::Debian::Base)
Specinfra::Command::Astralinux::Base::Ppa = Class.new(Specinfra::Command::Debian::Base::Ppa)
Specinfra::Command::Astralinux::Base::Service = Class.new(Specinfra::Command::Debian::Base::Service)

# itamae ssh -u ingipro -h 158.160.40.98 deploy/update-db.rb

user_ingipro = 'ingipro'

local_ruby_block 'make free space' do
  block do
    run_command 'truncate -s 0 /var/log/daemon.log.2.gz'
  end
end

service 'dev-trophy' do
  action [:stop]
  provider :systemd
end

remote_directory '/ingipro/dev-trophy' do
  source '../../dev-trophy'
  owner user_ingipro
  group user_ingipro
end

service 'dev-trophy' do
  action [:start]
  provider :systemd
end

# local_ruby_block 'kill free space' do
#   block do
#     sleep 10
#     run_command 'cat /var/log/daemon.log.4.gz >> /var/log/daemon.log.2.gz; true'
#   end
# end

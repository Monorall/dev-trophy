class EcosystemsListJob < ApplicationJob
  def perform(cloud_id)
    Ingipro::Cloudctl.init.ecosystem_list cloud_id
  end
end

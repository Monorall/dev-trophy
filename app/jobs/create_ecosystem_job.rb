class CreateEcosystemJob < ApplicationJob
  def perform(econame, slug, first_name, last_name, phone, post, email, password, cloud_id)
    Ingipro::Cloudctl.init.ecosystem_create econame, slug, first_name, last_name, phone, post, email, password, cloud_id
  end
end

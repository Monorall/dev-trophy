class CreateInitJob < ApplicationJob
  def perform(user_id, cloud_id)
    Ingipro::Cloudctl.init.cloud_init user_id, cloud_id
  end
end
